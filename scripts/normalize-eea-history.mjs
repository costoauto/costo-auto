import crypto from 'node:crypto';
import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const repoDir = path.dirname(scriptDir);
const workspaceDir = path.dirname(repoDir);
const inputDir = path.join(workspaceDir, 'eea_history_canonical');
const outputDir = path.join(workspaceDir, 'eea_history_normalized_v2');
const canonicalManifestPath = path.join(
  repoDir,
  'docs',
  'audits',
  'eea-history-canonical-manifest.json',
);
const manifestPath = path.join(
  repoDir,
  'docs',
  'audits',
  'eea-history-normalized-manifest.json',
);

const canonicalManifest = JSON.parse(await fs.readFile(canonicalManifestPath, 'utf8'));
const canonicalFilesByYear = new Map(
  canonicalManifest.files.map((item) => [Number(item.year), item]),
);

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

function baseFuel(value) {
  const key = compact(value);
  if (key.includes('ELECTRIC') && !key.includes('PETROL') && !key.includes('DIESEL')) return 'electric';
  if (key.includes('DIESEL')) return 'diesel';
  if (key.includes('PETROL') || key.includes('GASOLINE')) return 'petrol';
  if (key.includes('LPG')) return 'lpg';
  if (key === 'NG' || key.includes('NATURALGAS') || key.includes('CNG')) return 'ng';
  return null;
}

function normalizedPowertrain(row) {
  const fuel = baseFuel(row.fuel_type);
  const mode = compact(row.fuel_mode);
  if (!fuel) return { fuel_type: null, hybrid_type: null };
  if (fuel === 'electric') return { fuel_type: 'electric', hybrid_type: 'electric' };
  if (mode === 'P') {
    return {
      fuel_type: fuel === 'diesel' ? 'diesel/electric' : 'petrol/electric',
      hybrid_type: 'plug_in_hybrid',
    };
  }
  if (mode === 'H') return { fuel_type: fuel, hybrid_type: 'hybrid' };
  return { fuel_type: fuel, hybrid_type: 'none' };
}

function numberOrNull(value) {
  if (value === null || value === undefined || value === '') return null;
  const number = Number(value);
  return Number.isFinite(number) ? number : null;
}

function cycleEvidence(row) {
  const wltp = numberOrNull(row.co2_wltp_g_km);
  const nedc = numberOrNull(row.co2_nedc_g_km);
  if (wltp !== null && nedc !== null) return 'wltp_and_nedc_reported';
  if (wltp !== null) return 'wltp_reported';
  if (nedc !== null) return 'nedc_reported';
  return 'not_reported';
}

function observationId(row, year, sourceRowIndex) {
  const identity = [
    year,
    'F',
    sourceRowIndex,
    row.make,
    row.commercial_name,
    row.type,
    row.variant,
    row.version,
    row.fuel_type,
    row.fuel_mode,
    row.power_kw,
    row.engine_capacity_cm3,
    row.fuel_consumption_l_100km,
    row.electric_consumption_wh_km,
    row.co2_wltp_g_km,
    row.co2_nedc_g_km,
  ].map((value) => String(value ?? '').trim()).join('\u001f');
  return `eea_it_${crypto.createHash('sha256').update(identity).digest('hex').slice(0, 28)}`;
}

function sha256(text) {
  return crypto.createHash('sha256').update(text).digest('hex');
}

const files = [];
let totalRows = 0;
let rowsWithModel = 0;
let rowsWithPower = 0;
let rowsWithThermalConsumption = 0;
let rowsWithElectricConsumption = 0;
let unknownPowertrains = 0;

await fs.mkdir(outputDir, { recursive: true });
await fs.mkdir(path.dirname(manifestPath), { recursive: true });

for (let year = 2010; year <= 2024; year += 1) {
  const canonicalFile = canonicalFilesByYear.get(year);
  if (!canonicalFile || canonicalFile.status !== 'F') {
    throw new Error(`Sorgente finale canonica mancante per ${year}`);
  }
  const fileName = `eea-italy-${year}-normalized.json`;
  const inputPayload = JSON.parse(await fs.readFile(
    path.join(inputDir, `eea-italy-${year}-tvv.json`),
    'utf8',
  ));
  const rows = inputPayload.rows.map((row, sourceRowIndex) => {
    const powertrain = normalizedPowertrain(row);
    const normalized = {
      observation_id: observationId(row, year, sourceRowIndex),
      source_row_index: sourceRowIndex,
      source_country: 'IT',
      source_year: year,
      source_status: 'F',
      source_quality: 'final',
      make_reported: row.make ?? null,
      commercial_name_reported: row.commercial_name ?? null,
      brand_key_normalized: brandKey(row.make),
      model_key_normalized: modelKey(row.commercial_name, row.make),
      vehicle_type_reported: row.type ?? null,
      vehicle_variant_reported: row.variant ?? null,
      vehicle_version_reported: row.version ?? null,
      tvv_key_normalized: [row.type, row.variant, row.version]
        .map(compact)
        .join('|'),
      fuel_type_reported: row.fuel_type ?? null,
      fuel_mode_reported: row.fuel_mode ?? null,
      fuel_type_normalized: powertrain.fuel_type,
      hybrid_type_normalized: powertrain.hybrid_type,
      engine_power_kw_reported: numberOrNull(row.power_kw),
      power_semantics: 'engine_power_reported_by_eea_not_commercial_system_power',
      engine_capacity_cm3_reported: numberOrNull(row.engine_capacity_cm3),
      fuel_consumption_l_100km_reported: numberOrNull(row.fuel_consumption_l_100km),
      electric_consumption_kwh_100km_reported:
        numberOrNull(row.electric_consumption_wh_km) === null
          ? null
          : numberOrNull(row.electric_consumption_wh_km) / 10,
      consumption_cycle_status: 'not_explicit_for_consumption_field',
      co2_cycle_evidence: cycleEvidence(row),
      co2_wltp_g_km_reported: numberOrNull(row.co2_wltp_g_km),
      co2_nedc_g_km_reported: numberOrNull(row.co2_nedc_g_km),
      registrations_count: Math.max(0, Number(row.registrations_count) || 0),
      generation: null,
      generation_status: 'not_reported_by_eea',
      transmission: null,
      transmission_status: 'not_reported_by_eea',
      traction: null,
      traction_status: 'not_reported_by_eea',
      source_name: inputPayload.source,
      source_url: inputPayload.source_url,
      source_data_sha256: canonicalFile.data_sha256,
    };
    return normalized;
  });

  totalRows += rows.length;
  rowsWithModel += rows.filter((row) => row.brand_key_normalized && row.model_key_normalized).length;
  rowsWithPower += rows.filter((row) => row.engine_power_kw_reported !== null).length;
  rowsWithThermalConsumption += rows.filter(
    (row) => row.fuel_consumption_l_100km_reported !== null,
  ).length;
  rowsWithElectricConsumption += rows.filter(
    (row) => row.electric_consumption_kwh_100km_reported !== null,
  ).length;
  unknownPowertrains += rows.filter((row) => !row.fuel_type_normalized).length;

  const serialized = `${JSON.stringify({
    schema_version: 1,
    layer: 'normalized_observations',
    source_file: `eea-italy-${year}-tvv.json`,
    source_status: 'F',
    year,
    rows,
  })}\n`;
  await fs.writeFile(path.join(outputDir, fileName), serialized, 'utf8');
  files.push({
    year,
    file: fileName,
    rows: rows.length,
    source_status: canonicalFile.status,
    source_data_sha256: canonicalFile.data_sha256,
    normalized_sha256: sha256(serialized),
  });
}

const summary = {
  schema_version: 1,
  generated_at: new Date().toISOString(),
  layer: 'normalized_observations',
  input: '../eea_history_canonical',
  output: '../eea_history_normalized_v2',
  policy: {
    editions: 'final_only',
    commercial_identity: 'not_assigned_in_this_layer',
    missing_generation_transmission_traction: 'kept_null_not_invented',
    power: 'EEA engine power retained with explicit semantics',
    consumption_cycle: 'not inferred when the source field is not explicit',
  },
  totals: {
    files: files.length,
    rows: totalRows,
    rows_with_brand_and_model_key: rowsWithModel,
    rows_with_power: rowsWithPower,
    rows_with_thermal_consumption: rowsWithThermalConsumption,
    rows_with_electric_consumption: rowsWithElectricConsumption,
    rows_with_unknown_powertrain: unknownPowertrains,
  },
  files,
};
await fs.writeFile(manifestPath, `${JSON.stringify(summary, null, 2)}\n`, 'utf8');
console.log(JSON.stringify({ ...summary.totals, verification: 'ok' }, null, 2));
