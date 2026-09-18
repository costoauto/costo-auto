import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const here = path.dirname(fileURLToPath(import.meta.url));
const repoDir = path.dirname(here);
const workspaceDir = path.dirname(repoDir);
const historyDir = path.join(workspaceDir, 'eea_history_normalized_v2');
const deploymentDir = path.join(workspaceDir, 'deployment');
const legacyOutputDir = path.join(workspaceDir, 'historical_catalog_output');
const outputDir = path.join(workspaceDir, 'historical_catalog_output_v2');
const manifestPath = path.join(
  repoDir,
  'docs',
  'audits',
  'eea-history-normalized-manifest.json',
);
const publishData = process.argv.includes('--publish-data');

if (!fs.existsSync(manifestPath)) {
  throw new Error(
    'Manifest EEA normalizzato mancante. Eseguire prima: node scripts/normalize-eea-history.mjs',
  );
}

const sourceManifest = JSON.parse(fs.readFileSync(manifestPath, 'utf8'));
const normalizedSourceByYear = new Map(
  sourceManifest.files.map((item) => [Number(item.year), item]),
);

function parseCsv(text) {
  const rows = [];
  let row = [];
  let field = '';
  let quoted = false;

  for (let index = 0; index < text.length; index += 1) {
    const char = text[index];
    if (quoted) {
      if (char === '"' && text[index + 1] === '"') {
        field += '"';
        index += 1;
      } else if (char === '"') {
        quoted = false;
      } else {
        field += char;
      }
    } else if (char === '"') {
      quoted = true;
    } else if (char === ',') {
      row.push(field);
      field = '';
    } else if (char === '\n') {
      row.push(field.replace(/\r$/, ''));
      rows.push(row);
      row = [];
      field = '';
    } else {
      field += char;
    }
  }

  if (field.length > 0 || row.length > 0) {
    row.push(field);
    rows.push(row);
  }
  return rows;
}

function compact(value) {
  return String(value ?? '')
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toUpperCase()
    .replace(/[^A-Z0-9]/g, '');
}

const brandAliases = new Map([
  ['MERCEDES', 'MERCEDESBENZ'],
  ['MERCEDESBENZ', 'MERCEDESBENZ'],
  ['MERCEDESAMG', 'MERCEDESBENZ'],
  ['DSAUTOMOBILES', 'DS'],
  ['DS', 'DS'],
  ['VW', 'VOLKSWAGEN'],
  ['VOLKSWAGEN', 'VOLKSWAGEN'],
  ['ALFAROMEO', 'ALFAROMEO'],
  ['LANDROVER', 'LANDROVER'],
  ['RANGEROVER', 'LANDROVER'],
]);

function brandKey(value) {
  const key = compact(value);
  return brandAliases.get(key) ?? key;
}

function modelKey(value, brandValue) {
  let key = compact(value);
  const brand = brandKey(brandValue);
  const rawBrand = compact(brandValue);

  for (const prefix of new Set([brand, rawBrand])) {
    const preserveMgModel = brand === 'MG' && /^MG\d/.test(key);
    if (!preserveMgModel && prefix && key.startsWith(prefix) && key.length > prefix.length) {
      key = key.slice(prefix.length);
    }
  }

  if (brand === 'BMW') {
    const xModel = key.match(/^(IX\d|X\d|I\d)/);
    if (xModel) return xModel[1];
    const numberedSeries = key.match(/^([1-8])(?:SERIES|SERIE|ER|\d{2})/);
    if (numberedSeries) return `${numberedSeries[1]}SERIES`;
  }

  if (brand === 'MERCEDESBENZ') {
    const classModel = key.match(/^(GLA|GLB|GLC|GLE|GLS|CLA|CLE|CLS|[ABCEGSV])(?:CLASS|CLASSE|\d)/);
    if (classModel) return `${classModel[1]}CLASS`;
    const catalogClass = key.match(/^(GLA|GLB|GLC|GLE|GLS|CLA|CLE|CLS|[ABCEGSV])(?:CLASS|CLASSE)?$/);
    if (catalogClass) return `${catalogClass[1]}CLASS`;
  }

  return key;
}

function parseSeeds(sqlText) {
  const marker = 'COPY mvp.italy_popular_models_seed ';
  const start = sqlText.indexOf(marker);
  if (start < 0) throw new Error('Blocco seed model non trovato');
  const dataStart = sqlText.indexOf('\n', start) + 1;
  const dataEnd = sqlText.indexOf('\n\\.\n', dataStart);
  if (dataEnd < 0) throw new Error('Fine blocco seed model non trovata');

  return sqlText.slice(dataStart, dataEnd).split(/\r?\n/).filter(Boolean).map((line) => {
    const values = line.split('\t');
    return {
      id: Number(values[0]),
      brand: values[1],
      model: values[2],
      brand_key: brandKey(values[1]),
      model_key: modelKey(values[2], values[1]),
    };
  });
}

const catalogColumns = [
  'vehicle_cluster_id', 'model_catalog_id', 'seed_model_id', 'brand_key',
  'model_key', 'brand', 'model', 'version_label', 'fuel_type', 'hybrid_type',
  'powertrain_type', 'power_group_kw', 'power_kw', 'power_cv', 'power_semantics',
  'consumption_l_100km', 'electric_consumption_kwh_100km', 'electric_range_km',
  'co2_wltp_g_km', 'energy_data_status', 'observation_quality',
  'registrations_count', 'homologation_versions_count', 'normalization_method',
  'vehicle_profile_id', 'profile_power_gap_kw', 'profile_bridge_quality',
  'profile_bridge_method', 'has_documented_value_forecast',
  'has_internal_depreciation_model', 'depreciation_data_status', 'source_name',
  'source_url', 'built_at',
];

function objectsFromCsv(filePath, columns) {
  return parseCsv(fs.readFileSync(filePath, 'utf8')).filter((row) => row.length > 1).map((row) => {
    const object = {};
    columns.forEach((column, index) => {
      object[column] = row[index] ?? '';
    });
    return object;
  });
}

function baseFuel(value) {
  const key = compact(value);
  if (key.includes('ELECTRIC') && !key.includes('PETROL') && !key.includes('DIESEL')) return 'electric';
  if (key.includes('DIESEL')) return 'diesel';
  if (key.includes('PETROL') || key.includes('GASOLINE')) return 'petrol';
  if (key.includes('LPG')) return 'lpg';
  if (key === 'NG' || key.includes('NATURALGAS') || key.includes('CNG')) return 'ng';
  return null;
}

function powertrain(row) {
  const fuel = baseFuel(row.fuel_type);
  const mode = compact(row.fuel_mode);
  if (!fuel) return null;
  if (fuel === 'electric') {
    return { fuel_type: 'electric', hybrid_type: 'electric' };
  }
  if (mode === 'P') {
    return {
      fuel_type: fuel === 'diesel' ? 'diesel/electric' : 'petrol/electric',
      hybrid_type: 'plug_in_hybrid',
    };
  }
  if (mode === 'H') {
    return { fuel_type: fuel, hybrid_type: 'hybrid' };
  }
  return { fuel_type: fuel, hybrid_type: 'none' };
}

function validNumber(value, minimum, maximum) {
  const number = Number(value);
  return Number.isFinite(number) && number >= minimum && number <= maximum
    ? number
    : null;
}

function weightedMedian(values) {
  const valid = values
    .filter((item) => Number.isFinite(item.value) && item.weight > 0)
    .sort((a, b) => a.value - b.value);
  if (valid.length === 0) return null;
  const total = valid.reduce((sum, item) => sum + item.weight, 0);
  let running = 0;
  for (const item of valid) {
    running += item.weight;
    if (running >= total / 2) return item.value;
  }
  return valid.at(-1).value;
}

function round(value, digits = 2) {
  if (value === null || !Number.isFinite(value)) return null;
  const factor = 10 ** digits;
  return Math.round(value * factor) / factor;
}

function sqlValue(value) {
  if (value === null || value === undefined || value === '') return '\\N';
  return String(value).replace(/\\/g, '\\\\').replace(/\t/g, ' ').replace(/\r?\n/g, ' ');
}

function confidenceRank(value) {
  return { high: 4, medium_high: 3, medium: 2, medium_low: 1, low: 0 }[value] ?? 0;
}

const seedSql = fs.readFileSync(path.join(deploymentDir, '02_dati_tabelle.sql'), 'utf8');
const seeds = parseSeeds(seedSql);
const seedsByBrandModel = new Map(seeds.map((seed) => [
  `${seed.brand_key}|${seed.model_key}`,
  seed,
]));
const seedsById = new Map(seeds.map((seed) => [seed.id, seed]));

const currentCatalog = objectsFromCsv(
  path.join(deploymentDir, 'mvp_site_vehicle_catalog_eea_v2.csv'),
  catalogColumns,
);
const catalogAliases = new Map();
for (const row of currentCatalog) {
  const seedId = Number(row.seed_model_id);
  if (Number.isInteger(seedId) && seedsById.has(seedId)) {
    catalogAliases.set(`${brandKey(row.brand)}|${compact(row.model_key)}`, seedsById.get(seedId));
  }
}

function findSeed(row) {
  const brand = row.brand_key_normalized;
  const model = row.model_key_normalized;
  const alias = catalogAliases.get(`${brand}|${model}`);
  if (alias) return { seed: alias, method: 'catalog_alias_exact' };
  const seed = seedsByBrandModel.get(`${brand}|${model}`);
  if (seed) return { seed, method: 'seed_model_exact' };
  return null;
}

const groups = new Map();
let totalRegistrations = 0;
let mappedRegistrations = 0;
let rowsExcludedByEdition = 0;
let registrationsExcludedByEdition = 0;
let unmappedRegistrations = 0;

for (let year = 2010; year <= 2024; year += 1) {
  const payload = JSON.parse(fs.readFileSync(
    path.join(historyDir, `eea-italy-${year}-normalized.json`),
    'utf8',
  ));
  const normalizedSource = normalizedSourceByYear.get(year);
  if (!normalizedSource || normalizedSource.source_status !== 'F') {
    throw new Error(`Edizione finale normalizzata mancante per ${year}`);
  }

  for (const row of payload.rows) {
    const registrations = Math.max(0, Number(row.registrations_count) || 0);
    if (row.source_status !== 'F') {
      rowsExcludedByEdition += 1;
      registrationsExcludedByEdition += registrations;
      continue;
    }
    totalRegistrations += registrations;
    const match = findSeed(row);
    const drive = row.fuel_type_normalized && row.hybrid_type_normalized
      ? {
          fuel_type: row.fuel_type_normalized,
          hybrid_type: row.hybrid_type_normalized,
        }
      : null;
    if (!match || !drive) {
      unmappedRegistrations += registrations;
      continue;
    }
    const { seed } = match;
    mappedRegistrations += registrations;

    const powerKw = validNumber(row.engine_power_kw_reported, 1, 1000);
    const roundedPower = powerKw === null ? null : Math.round(powerKw);
    const key = [
      seed.id,
      year,
      drive.fuel_type,
      drive.hybrid_type,
      roundedPower ?? 'unknown',
    ].join('|');

    if (!groups.has(key)) {
      groups.set(key, {
        seed,
        year,
        fuel_type: drive.fuel_type,
        hybrid_type: drive.hybrid_type,
        power_kw: roundedPower,
        registrations_count: 0,
        source_records_count: 0,
        source_status: row.source_status,
        model_match_methods: new Set(),
        source_identity_samples: [],
        thermal_values: [],
        electric_values: [],
      });
    }

    const group = groups.get(key);
    const weight = Math.max(1, registrations);
    group.registrations_count += registrations;
    group.source_records_count += 1;
    group.model_match_methods.add(match.method);
    if (group.source_identity_samples.length < 5) {
      group.source_identity_samples.push({
        observation_id: row.observation_id,
        make: row.make_reported ?? null,
        commercial_name: row.commercial_name_reported ?? null,
        type: row.vehicle_type_reported ?? null,
        variant: row.vehicle_variant_reported ?? null,
        version: row.vehicle_version_reported ?? null,
      });
    }

    const thermal = validNumber(row.fuel_consumption_l_100km_reported, 1.5, 40);
    if (thermal !== null && drive.hybrid_type !== 'plug_in_hybrid' && drive.fuel_type !== 'electric') {
      group.thermal_values.push({ value: thermal, weight });
    }

    const electricKwh100km = validNumber(
      row.electric_consumption_kwh_100km_reported,
      6,
      60,
    );
    if (electricKwh100km !== null && (
      drive.fuel_type === 'electric' || drive.hybrid_type === 'plug_in_hybrid'
    )) {
      group.electric_values.push({ value: electricKwh100km, weight });
    }
  }
}

const candidates = [...groups.values()]
  // Senza potenza non possiamo calcolare un bollo credibile. Queste righe
  // restano nei file sorgente, ma non diventano versioni selezionabili.
  .filter((group) => group.power_kw !== null)
  .map((group) => {
    const directThermal = round(weightedMedian(group.thermal_values), 2);
    const directElectric = round(weightedMedian(group.electric_values), 2);
    return {
      ...group,
      direct_consumption_l_100km: directThermal,
      direct_electric_consumption_kwh_100km: directElectric,
      consumption_l_100km: directThermal,
      electric_consumption_kwh_100km: directElectric,
    };
  });

const byModelYear = new Map();
for (const candidate of candidates) {
  const key = `${candidate.seed.id}|${candidate.year}`;
  if (!byModelYear.has(key)) byModelYear.set(key, []);
  byModelYear.get(key).push(candidate);
}

const selected = [];
for (const modelYearCandidates of byModelYear.values()) {
  modelYearCandidates.sort((a, b) => b.registrations_count - a.registrations_count);
  const total = modelYearCandidates.reduce((sum, item) => sum + item.registrations_count, 0);
  if (total < 3) continue;
  const threshold = Math.max(3, Math.ceil(total * 0.01));
  const required = new Map();
  for (const candidate of modelYearCandidates) {
    if (candidate.registrations_count < 3) continue;
    const key = `${candidate.fuel_type}|${candidate.hybrid_type}`;
    if (!required.has(key)) required.set(key, candidate);
  }
  const retained = new Map();
  for (const candidate of modelYearCandidates) {
    if (candidate.registrations_count >= threshold) retained.set(candidate, candidate);
  }
  for (const candidate of required.values()) retained.set(candidate, candidate);
  const top = [...retained.values()]
    .sort((a, b) => b.registrations_count - a.registrations_count)
    .slice(0, 12);
  for (const candidate of required.values()) {
    if (!top.includes(candidate)) top.push(candidate);
  }
  selected.push(...top);
}

function metricDonor(candidate, metric, filter) {
  const sameModel = candidates.filter((other) => (
    other.seed.id === candidate.seed.id
    && other[metric] !== null
    && filter(other)
  ));
  const pool = sameModel.length > 0
    ? sameModel
    : candidates.filter((other) => other[metric] !== null && filter(other));
  if (pool.length === 0) return null;
  return pool.sort((a, b) => {
    const aModelPenalty = a.seed.id === candidate.seed.id ? 0 : 10000;
    const bModelPenalty = b.seed.id === candidate.seed.id ? 0 : 10000;
    const aPowerGap = candidate.power_kw === null || a.power_kw === null
      ? 200 : Math.abs(candidate.power_kw - a.power_kw);
    const bPowerGap = candidate.power_kw === null || b.power_kw === null
      ? 200 : Math.abs(candidate.power_kw - b.power_kw);
    return (aModelPenalty + Math.abs(a.year - candidate.year) * 10 + aPowerGap)
      - (bModelPenalty + Math.abs(b.year - candidate.year) * 10 + bPowerGap);
  })[0];
}

for (const candidate of selected) {
  let confidence = 'high';
  const notes = [];
  const base = baseFuel(candidate.fuel_type);

  if (candidate.fuel_type !== 'electric' && candidate.consumption_l_100km === null) {
    const donor = metricDonor(candidate, 'consumption_l_100km', (other) => (
      baseFuel(other.fuel_type) === base
      && other.hybrid_type !== 'plug_in_hybrid'
      && other.fuel_type !== 'electric'
    ));
    if (donor) {
      candidate.consumption_l_100km = donor.consumption_l_100km;
      notes.push(donor.seed.id === candidate.seed.id
        ? 'consumo_termico_stesso_modello'
        : 'consumo_termico_comparabile');
      confidence = donor.seed.id === candidate.seed.id ? 'medium' : 'low';
    }
  }

  if ((candidate.fuel_type === 'electric' || candidate.hybrid_type === 'plug_in_hybrid')
      && candidate.electric_consumption_kwh_100km === null) {
    const donor = metricDonor(candidate, 'electric_consumption_kwh_100km', (other) => (
      other.hybrid_type === candidate.hybrid_type
      || (candidate.fuel_type === 'electric' && other.fuel_type === 'electric')
    ));
    if (donor) {
      candidate.electric_consumption_kwh_100km = donor.electric_consumption_kwh_100km;
      notes.push(donor.seed.id === candidate.seed.id
        ? 'consumo_elettrico_stesso_modello'
        : 'consumo_elettrico_comparabile');
      const estimatedConfidence = donor.seed.id === candidate.seed.id ? 'medium' : 'low';
      if (confidenceRank(estimatedConfidence) < confidenceRank(confidence)) {
        confidence = estimatedConfidence;
      }
    }
  }

  candidate.confidence = confidence;
  candidate.energy_method = notes.length > 0 ? notes.join('+') : 'dato_eea_diretto';
  candidate.model_match_methods = [...candidate.model_match_methods].sort();
  candidate.euro_class = candidate.year >= 2015 ? 6 : candidate.year >= 2011 ? 5 : 4;
  candidate.power_cv = candidate.power_kw === null ? null : Math.round(candidate.power_kw * 1.35962);
  candidate.historical_version_id = `eea_hist_${crypto.createHash('sha256').update([
    candidate.seed.id,
    candidate.year,
    candidate.fuel_type,
    candidate.hybrid_type,
    candidate.power_kw ?? 'unknown',
  ].join('|')).digest('hex').slice(0, 24)}`;
  candidate.quarantine_reasons = [];
  if (candidate.confidence === 'low') {
    candidate.quarantine_reasons.push('consumo_donato_da_altro_modello');
  }
  if (candidate.fuel_type === 'electric'
      && candidate.electric_consumption_kwh_100km === null) {
    candidate.quarantine_reasons.push('consumo_elettrico_mancante');
  }
  if (candidate.fuel_type !== 'electric'
      && candidate.consumption_l_100km === null) {
    candidate.quarantine_reasons.push('consumo_termico_mancante');
  }
  if (candidate.hybrid_type === 'plug_in_hybrid'
      && candidate.electric_consumption_kwh_100km === null) {
    candidate.quarantine_reasons.push('consumo_elettrico_plugin_mancante');
  }
  candidate.publication_status = candidate.quarantine_reasons.length === 0
    ? 'publishable'
    : 'candidate';
  delete candidate.thermal_values;
  delete candidate.electric_values;
}

selected.sort((a, b) => (
  a.seed.brand.localeCompare(b.seed.brand, 'it')
  || a.seed.model.localeCompare(b.seed.model, 'it')
  || b.year - a.year
  || b.registrations_count - a.registrations_count
));

const readyEnergy = selected.filter((candidate) => (
  (candidate.fuel_type === 'electric'
    ? candidate.electric_consumption_kwh_100km !== null
    : candidate.consumption_l_100km !== null)
  && (candidate.hybrid_type !== 'plug_in_hybrid'
    || candidate.electric_consumption_kwh_100km !== null)
));
const publishable = selected.filter((candidate) => candidate.publication_status === 'publishable');
const quarantined = selected.filter((candidate) => candidate.publication_status === 'candidate');

const bmw3 = selected.filter((candidate) => (
  candidate.seed.brand_key === 'BMW' && candidate.seed.model_key === '3SERIES'
));

fs.mkdirSync(outputDir, { recursive: true });
const selectedCandidateSet = new Set(selected);
const commercialObservations = candidates.map((candidate) => ({
  seed_model_id: candidate.seed.id,
  brand: candidate.seed.brand,
  model: candidate.seed.model,
  year: candidate.year,
  source_status: candidate.source_status,
  fuel_type: candidate.fuel_type,
  hybrid_type: candidate.hybrid_type,
  power_kw: candidate.power_kw,
  direct_consumption_l_100km: candidate.direct_consumption_l_100km,
  direct_electric_consumption_kwh_100km:
    candidate.direct_electric_consumption_kwh_100km,
  registrations_count: candidate.registrations_count,
  source_records_count: candidate.source_records_count,
  model_match_methods: Array.isArray(candidate.model_match_methods)
    ? candidate.model_match_methods
    : [...candidate.model_match_methods].sort(),
  source_identity_samples: candidate.source_identity_samples,
  selected_for_catalog: selectedCandidateSet.has(candidate),
  selection_reason: selectedCandidateSet.has(candidate)
    ? 'selected_by_prevalence_rule'
    : 'below_prevalence_or_variant_limit',
}));
fs.writeFileSync(
  path.join(outputDir, 'commercial-observations.json'),
  `${JSON.stringify(commercialObservations, null, 2)}\n`,
);
fs.writeFileSync(
  path.join(outputDir, 'historical-versions.json'),
  JSON.stringify(selected, (key, value) => key === 'seed' ? {
    id: value.id,
    brand: value.brand,
    model: value.model,
  } : value, 2),
);

const summary = {
  generated_at: new Date().toISOString(),
  source_years: '2010-2024',
  source_registrations: totalRegistrations,
  mapped_registrations: mappedRegistrations,
  unmapped_registrations: unmappedRegistrations,
  mapped_registrations_pct: round(mappedRegistrations / totalRegistrations * 100, 2),
  rows_excluded_by_edition: rowsExcludedByEdition,
  registrations_excluded_by_edition: registrationsExcludedByEdition,
  seed_models: seeds.length,
  source_groups: candidates.length,
  selected_versions: selected.length,
  publishable_versions: publishable.length,
  candidate_versions: quarantined.length,
  selected_models: new Set(selected.map((candidate) => candidate.seed.id)).size,
  ready_energy: readyEnergy.length,
  missing_energy: selected.length - readyEnergy.length,
  bmw_3_series_versions: bmw3.length,
  bmw_3_series_2013_2024: bmw3.filter((candidate) => candidate.year >= 2013).length,
  bmw_3_series_by_year: Object.fromEntries(
    Array.from({ length: 15 }, (_, index) => 2010 + index).map((year) => [
      year,
      bmw3.filter((candidate) => candidate.year === year).length,
    ]),
  ),
};
fs.writeFileSync(path.join(outputDir, 'summary.json'), JSON.stringify(summary, null, 2));

const columns = [
  'historical_version_id', 'seed_model_id', 'brand', 'model',
  'representative_year', 'fuel_type', 'hybrid_type', 'power_kw', 'power_cv',
  'euro_class', 'consumption_l_100km', 'electric_consumption_kwh_100km',
  'registrations_count', 'source_records_count', 'confidence', 'energy_method',
];

const copyLines = publishable.map((candidate) => [
  candidate.historical_version_id,
  candidate.seed.id,
  candidate.seed.brand,
  candidate.seed.model,
  candidate.year,
  candidate.fuel_type,
  candidate.hybrid_type,
  candidate.power_kw,
  candidate.power_cv,
  candidate.euro_class,
  candidate.consumption_l_100km,
  candidate.electric_consumption_kwh_100km,
  candidate.registrations_count,
  candidate.source_records_count,
  candidate.confidence,
  candidate.energy_method,
].map(sqlValue).join('\t'));

const copySql = `COPY mvp.eea_historical_versions_compact_v1 (${columns.join(', ')}) FROM stdin;\n${copyLines.join('\n')}\n\\.\n`;
fs.writeFileSync(path.join(outputDir, 'historical-versions-copy.sql'), copySql);
if (publishData) {
  fs.writeFileSync(
    path.join(repoDir, 'supabase', '14_catalogo_storico_eea_data.sql'),
    copySql,
  );
}

const legacyPath = path.join(legacyOutputDir, 'historical-versions.json');
const legacy = fs.existsSync(legacyPath)
  ? JSON.parse(fs.readFileSync(legacyPath, 'utf8'))
  : [];
const legacyById = new Map(legacy.map((item) => [item.historical_version_id, item]));
const canonicalById = new Map(publishable.map((item) => [item.historical_version_id, item]));
const canonicalSelectedById = new Map(
  selected.map((item) => [item.historical_version_id, item]),
);
const added = publishable.filter((item) => !legacyById.has(item.historical_version_id));
const removed = legacy.filter((item) => !canonicalById.has(item.historical_version_id)).map((item) => {
  const candidate = canonicalSelectedById.get(item.historical_version_id);
  return {
    ...item,
    publication_status: candidate ? 'candidate' : 'not_in_canonical_edition',
    quarantine_reasons: candidate?.quarantine_reasons
      ?? ['non_presente_nell_edizione_canonica'],
  };
});
const changed = publishable.flatMap((item) => {
  const previous = legacyById.get(item.historical_version_id);
  if (!previous) return [];
  const fields = [
    'registrations_count',
    'source_records_count',
    'consumption_l_100km',
    'electric_consumption_kwh_100km',
    'confidence',
    'energy_method',
  ];
  const differences = Object.fromEntries(fields.flatMap((field) => (
    String(previous[field] ?? '') === String(item[field] ?? '')
      ? []
      : [[field, { before: previous[field] ?? null, after: item[field] ?? null }]]
  )));
  return Object.keys(differences).length === 0
    ? []
    : [{
      historical_version_id: item.historical_version_id,
      brand: item.seed.brand,
      model: item.seed.model,
      year: item.year,
      fuel_type: item.fuel_type,
      hybrid_type: item.hybrid_type,
      power_kw: item.power_kw,
      differences,
    }];
});

const compactIdentity = (item) => ({
  historical_version_id: item.historical_version_id,
  brand: item.seed?.brand ?? item.brand,
  model: item.seed?.model ?? item.model,
  year: item.year ?? item.representative_year,
  fuel_type: item.fuel_type,
  hybrid_type: item.hybrid_type,
  power_kw: item.power_kw,
  registrations_count: item.registrations_count,
  publication_status: item.publication_status ?? 'legacy',
  reasons: item.quarantine_reasons ?? [],
});

const diff = {
  generated_at: new Date().toISOString(),
  baseline: '../historical_catalog_output/historical-versions.json',
  candidate: '../historical_catalog_output_v2/historical-versions.json',
  counts: {
    legacy_versions: legacy.length,
    canonical_selected_versions: selected.length,
    canonical_publishable_versions: publishable.length,
    canonical_candidate_versions: quarantined.length,
    added_publishable: added.length,
    removed_from_publishable: removed.length,
    changed_publishable: changed.length,
  },
  added_publishable: added.map(compactIdentity),
  removed_from_publishable: removed.map(compactIdentity),
  candidates_not_auto_published: quarantined.map(compactIdentity),
  changed_publishable: changed,
};
fs.writeFileSync(path.join(outputDir, 'catalog-diff.json'), `${JSON.stringify(diff, null, 2)}\n`);

const topReasons = Object.entries(quarantined.flatMap((item) => item.quarantine_reasons)
  .reduce((counts, reason) => ({ ...counts, [reason]: (counts[reason] ?? 0) + 1 }), {}))
  .sort((a, b) => b[1] - a[1]);
const sampleRows = (items, limit = 20) => items.slice(0, limit).map((item) => {
  const value = compactIdentity(item);
  return `| ${value.brand} | ${value.model} | ${value.year} | ${value.fuel_type} | ${value.power_kw ?? ''} | ${value.reasons.join(', ')} |`;
}).join('\n') || '| - | - | - | - | - | - |';

const diffReport = `# Confronto catalogo storico EEA: vecchio vs canonico

Generato: ${diff.generated_at}

## Numeri principali

- Versioni nel vecchio output: ${legacy.length}
- Versioni selezionate dalla sorgente canonica: ${selected.length}
- Versioni pubblicabili automaticamente: ${publishable.length}
- Versioni trattenute come candidate: ${quarantined.length}
- Nuove identita pubblicabili: ${added.length}
- Identita rimosse dalla pubblicazione automatica: ${removed.length}
- Identita mantenute ma con dati cambiati: ${changed.length}

La quarantena non elimina i dati grezzi: impedisce soltanto che un consumo preso da un altro modello venga presentato automaticamente come dato della versione scelta.

## Motivi della quarantena

${topReasons.map(([reason, count]) => `- ${reason}: ${count}`).join('\n') || '- Nessuno'}

## Esempi rimossi dalla pubblicazione automatica

| Marca | Modello | Anno | Alimentazione | kW | Motivo |
|---|---|---:|---|---:|---|
${sampleRows(removed)}

## Esempi mantenuti come candidate

| Marca | Modello | Anno | Alimentazione | kW | Motivo |
|---|---|---:|---|---:|---|
${sampleRows(quarantined)}

Il dettaglio completo e disponibile in catalog-diff.json. Nessun file SQL di produzione e stato sovrascritto${publishData ? '' : ', perche lo script e stato eseguito senza --publish-data'}.
`;
fs.writeFileSync(path.join(outputDir, 'catalog-diff.md'), diffReport);

console.log(JSON.stringify({
  ...summary,
  diff: diff.counts,
  publish_data: publishData,
  verification: 'ok',
}, null, 2));
