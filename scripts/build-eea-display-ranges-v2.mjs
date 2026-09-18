import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const here = path.dirname(fileURLToPath(import.meta.url));
const repoDir = path.dirname(here);
const workspaceDir = path.dirname(repoDir);
const historyDir = path.join(workspaceDir, 'eea_history_normalized_v2');
const deploymentDir = path.join(workspaceDir, 'deployment');
const historicalOutputDir = path.join(workspaceDir, 'historical_catalog_output_v2');
const outputDir = path.join(workspaceDir, 'catalog_audit_output_v2');
const publishData = process.argv.includes('--publish-data');
const maximumObservationGapYears = 3;

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
    if (
      !preserveMgModel
      && prefix
      && key.startsWith(prefix)
      && key.length > prefix.length
    ) {
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
    const classModel = key.match(
      /^(GLA|GLB|GLC|GLE|GLS|CLA|CLE|CLS|[ABCEGSV])(?:CLASS|CLASSE|\d)/,
    );
    if (classModel) return `${classModel[1]}CLASS`;
    const catalogClass = key.match(
      /^(GLA|GLB|GLC|GLE|GLS|CLA|CLE|CLS|[ABCEGSV])(?:CLASS|CLASSE)?$/,
    );
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

  return sqlText
    .slice(dataStart, dataEnd)
    .split(/\r?\n/)
    .filter(Boolean)
    .map((line) => {
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
  'vehicle_cluster_id',
  'model_catalog_id',
  'seed_model_id',
  'brand_key',
  'model_key',
  'brand',
  'model',
  'version_label',
  'fuel_type',
  'hybrid_type',
  'powertrain_type',
  'power_group_kw',
  'power_kw',
  'power_cv',
  'power_semantics',
  'consumption_l_100km',
  'electric_consumption_kwh_100km',
  'electric_range_km',
  'co2_wltp_g_km',
  'energy_data_status',
  'observation_quality',
  'registrations_count',
  'homologation_versions_count',
  'normalization_method',
  'vehicle_profile_id',
  'profile_power_gap_kw',
  'profile_bridge_quality',
  'profile_bridge_method',
  'has_documented_value_forecast',
  'has_internal_depreciation_model',
  'depreciation_data_status',
  'source_name',
  'source_url',
  'built_at',
];

function objectsFromCsv(filePath, columns) {
  return parseCsv(fs.readFileSync(filePath, 'utf8'))
    .filter((row) => row.length > 1)
    .map((row) => {
      const object = {};
      columns.forEach((column, index) => {
        object[column] = row[index] ?? '';
      });
      return object;
    });
}

function baseFuel(value) {
  const key = compact(value);
  if (
    key.includes('ELECTRIC')
    && !key.includes('PETROL')
    && !key.includes('DIESEL')
  ) return 'electric';
  if (key.includes('DIESEL')) return 'diesel';
  if (key.includes('PETROL') || key.includes('GASOLINE')) return 'petrol';
  if (key.includes('LPG')) return 'lpg';
  if (key === 'NG' || key.includes('NATURALGAS') || key.includes('CNG')) {
    return 'ng';
  }
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

function homologationSignatures(row) {
  const values = [
    compact(row.vehicle_type_reported ?? row.type),
    compact(row.vehicle_variant_reported ?? row.variant),
    compact(row.vehicle_version_reported ?? row.version),
  ];
  return {
    type: values[0] || null,
    type_variant: values[0] && values[1]
      ? `${values[0]}|${values[1]}`
      : null,
    tvv: values.every((value) => value === '') ? null : values.join('|'),
  };
}

function bucketKey(seedId, year, fuelType, hybridType, powerKw) {
  return [
    seedId,
    year,
    fuelType,
    hybridType,
    Math.round(Number(powerKw)),
  ].join('|');
}

const seedSql = fs.readFileSync(
  path.join(deploymentDir, '02_dati_tabelle.sql'),
  'utf8',
);
const seeds = parseSeeds(seedSql);
const seedsByBrandModel = new Map(
  seeds.map((seed) => [`${seed.brand_key}|${seed.model_key}`, seed]),
);
const seedsById = new Map(seeds.map((seed) => [seed.id, seed]));

const currentCatalog = objectsFromCsv(
  path.join(deploymentDir, 'mvp_site_vehicle_catalog_eea_v2.csv'),
  catalogColumns,
);
const currentCatalogBySeedFuelPower = new Map();
const catalogAliases = new Map();
for (const row of currentCatalog) {
  const seedId = Number(row.seed_model_id);
  if (Number.isInteger(seedId) && seedsById.has(seedId)) {
    catalogAliases.set(
      `${brandKey(row.brand)}|${compact(row.model_key)}`,
      seedsById.get(seedId),
    );
    const fuel = baseFuel(row.fuel_type);
    const powerKw = Number(row.power_kw);
    if (fuel && Number.isFinite(powerKw) && powerKw > 0) {
      const key = [seedId, fuel, Math.round(powerKw)].join('|');
      if (!currentCatalogBySeedFuelPower.has(key)) {
        currentCatalogBySeedFuelPower.set(key, []);
      }
      currentCatalogBySeedFuelPower.get(key).push(row);
    }
  }
}

function findSeed(row) {
  const brand = row.brand_key_normalized
    ?? brandKey(row.make_reported ?? row.make);
  const model = row.model_key_normalized
    ?? modelKey(
      row.commercial_name_reported ?? row.commercial_name,
      row.make_reported ?? row.make,
    );
  return catalogAliases.get(`${brand}|${model}`)
    ?? seedsByBrandModel.get(`${brand}|${model}`)
    ?? null;
}

const rawBuckets = new Map();
let rawRows = 0;
let rowsWithTvv = 0;
let mappedRows = 0;
let mappedRowsWithTvv = 0;

for (let year = 2010; year <= 2024; year += 1) {
  const payload = JSON.parse(
    fs.readFileSync(
      path.join(historyDir, `eea-italy-${year}-normalized.json`),
      'utf8',
    ),
  );

  for (const row of payload.rows) {
    rawRows += 1;
    const signatures = homologationSignatures(row);
    if (signatures.tvv) rowsWithTvv += 1;

    const seed = findSeed(row);
    const drive = row.fuel_type_normalized && row.hybrid_type_normalized
      ? {
          fuel_type: row.fuel_type_normalized,
          hybrid_type: row.hybrid_type_normalized,
        }
      : null;
    const powerKw = Number(row.engine_power_kw_reported);
    if (!seed || !drive || !Number.isFinite(powerKw) || powerKw <= 0) continue;

    mappedRows += 1;
    if (signatures.tvv) mappedRowsWithTvv += 1;

    const key = bucketKey(
      seed.id,
      year,
      drive.fuel_type,
      drive.hybrid_type,
      powerKw,
    );
    if (!rawBuckets.has(key)) {
      rawBuckets.set(key, {
        registrations: 0,
        signatures: {
          type: new Map(),
          type_variant: new Map(),
          tvv: new Map(),
        },
      });
    }
    const bucket = rawBuckets.get(key);
    const registrations = Math.max(0, Number(row.registrations_count) || 0);
    bucket.registrations += registrations;
    for (const level of ['type', 'type_variant', 'tvv']) {
      const signature = signatures[level];
      if (!signature) continue;
      bucket.signatures[level].set(
        signature,
        (bucket.signatures[level].get(signature) ?? 0) + registrations,
      );
    }
  }
}

const tvv2025Columns = [
  'homologation_version_id',
  'type_approval_number',
  'vehicle_type',
  'vehicle_variant',
  'vehicle_version',
  'make_reported',
  'commercial_name_reported',
  'manufacturer_reported',
  'fuel_type_reported',
  'source_status',
  'source_year',
  'registrations_count',
  'distinct_make_count',
  'distinct_commercial_name_count',
  'distinct_fuel_type_count',
  'engine_power_observations',
  'engine_power_kw_median',
  'engine_power_kw_min',
  'engine_power_kw_max',
  'fuel_consumption_observations',
  'fuel_consumption_median',
  'fuel_consumption_min',
  'fuel_consumption_max',
  'electric_consumption_observations',
  'electric_consumption_kwh_100km_median',
  'electric_consumption_kwh_100km_min',
  'electric_consumption_kwh_100km_max',
  'electric_range_observations',
  'electric_range_km_median',
  'electric_range_km_min',
  'electric_range_km_max',
  'co2_wltp_observations',
  'co2_wltp_g_km_median',
  'publication_status',
  'quality_notes',
  'source_name',
  'source_url',
  'built_at',
];

const tvv2025 = objectsFromCsv(
  path.join(deploymentDir, 'curated_wltp_italy_tvv_2025_v1.csv'),
  tvv2025Columns,
);

for (const row of tvv2025) {
  rawRows += 1;
  const signatures = {
    type: compact(row.vehicle_type) || null,
    type_variant: (
      compact(row.vehicle_type) && compact(row.vehicle_variant)
    )
      ? `${compact(row.vehicle_type)}|${compact(row.vehicle_variant)}`
      : null,
    tvv: (
      compact(row.vehicle_type)
      || compact(row.vehicle_variant)
      || compact(row.vehicle_version)
    )
      ? [
        compact(row.vehicle_type),
        compact(row.vehicle_variant),
        compact(row.vehicle_version),
      ].join('|')
      : null,
  };
  if (signatures.tvv) rowsWithTvv += 1;

  const seed = findSeed({
    make: row.make_reported,
    commercial_name: row.commercial_name_reported,
  });
  const fuel = baseFuel(row.fuel_type_reported);
  const powerKw = Number(row.engine_power_kw_median);
  if (!seed || !fuel || !Number.isFinite(powerKw) || powerKw <= 0) continue;

  const catalogCandidates = currentCatalogBySeedFuelPower.get(
    [seed.id, fuel, Math.round(powerKw)].join('|'),
  ) ?? [];
  let hybridTypes;
  if (fuel === 'electric') {
    hybridTypes = ['electric'];
  } else if (Number(row.electric_consumption_observations) > 0) {
    hybridTypes = ['plug_in_hybrid'];
  } else {
    hybridTypes = [...new Set(
      catalogCandidates
        .map((candidate) => candidate.hybrid_type || 'none')
        .filter((hybrid) => ['none', 'hybrid'].includes(hybrid)),
    )];
  }
  if (hybridTypes.length !== 1) continue;

  const hybridType = hybridTypes[0];
  const canonicalFuel = hybridType === 'plug_in_hybrid'
    ? `${fuel}/electric`
    : fuel;
  mappedRows += 1;
  if (signatures.tvv) mappedRowsWithTvv += 1;

  const key = bucketKey(
    seed.id,
    2025,
    canonicalFuel,
    hybridType,
    powerKw,
  );
  if (!rawBuckets.has(key)) {
    rawBuckets.set(key, {
      registrations: 0,
      signatures: {
        type: new Map(),
        type_variant: new Map(),
        tvv: new Map(),
      },
    });
  }
  const bucket = rawBuckets.get(key);
  const registrations = Math.max(0, Number(row.registrations_count) || 0);
  bucket.registrations += registrations;
  for (const level of ['type', 'type_variant', 'tvv']) {
    const signature = signatures[level];
    if (!signature) continue;
    bucket.signatures[level].set(
      signature,
      (bucket.signatures[level].get(signature) ?? 0) + registrations,
    );
  }
}

const historicalSelected = JSON.parse(
  fs.readFileSync(
    path.join(historicalOutputDir, 'historical-versions.json'),
    'utf8',
  ),
).filter((item) => item.publication_status === 'publishable').map((item) => ({
  ...item,
  seed_model_id: Number(item.seed_model_id ?? item.seed?.id),
  brand: item.brand ?? item.seed?.brand,
  model: item.model ?? item.seed?.model,
  representative_year: Number(item.representative_year ?? item.year),
  power_kw: Number(item.power_kw),
  registrations_count: Number(item.registrations_count),
}));

const currentSelected = currentCatalog
  .filter((item) => (
    Number.isInteger(Number(item.seed_model_id))
    && Number.isFinite(Number(item.power_kw))
    && Number(item.power_kw) > 0
    && Number.isInteger(Number(item.vehicle_profile_id))
    && Number(item.vehicle_profile_id) > 0
    && item.vehicle_cluster_id
  ))
  .map((item) => ({
    historical_version_id:
      `current_cluster:${item.vehicle_cluster_id}`,
    vehicle_profile_id: Number(item.vehicle_profile_id),
    seed_model_id: Number(item.seed_model_id),
    brand: item.brand,
    model: item.model,
    representative_year: 2025,
    fuel_type: item.fuel_type,
    hybrid_type: item.hybrid_type || 'none',
    power_kw: Number(item.power_kw),
    power_cv: Number(item.power_cv),
    consumption_l_100km: Number(item.consumption_l_100km),
    electric_consumption_kwh_100km:
      Number(item.electric_consumption_kwh_100km),
    registrations_count: Number(item.registrations_count),
  }));

const selected = [...historicalSelected, ...currentSelected];
const selectedById = new Map(
  selected.map((item) => [item.historical_version_id, item]),
);

const selectedByModelDrive = new Map();
for (const item of selected) {
  const key = [
    item.seed_model_id,
    item.fuel_type,
    item.hybrid_type,
  ].join('|');
  if (!selectedByModelDrive.has(key)) selectedByModelDrive.set(key, []);
  selectedByModelDrive.get(key).push(item);
}

const edges = [];

function energyCompatible(left, right) {
  const leftThermal = Number(left.consumption_l_100km);
  const rightThermal = Number(right.consumption_l_100km);
  const leftElectric = Number(left.electric_consumption_kwh_100km);
  const rightElectric = Number(right.electric_consumption_kwh_100km);

  const thermalAvailable = Number.isFinite(leftThermal)
    && leftThermal > 0
    && Number.isFinite(rightThermal)
    && rightThermal > 0;
  const electricAvailable = Number.isFinite(leftElectric)
    && leftElectric > 0
    && Number.isFinite(rightElectric)
    && rightElectric > 0;
  const thermalMatches = thermalAvailable
    && Math.abs(leftThermal - rightThermal)
      <= Math.max(0.35, leftThermal * 0.08);
  const electricMatches = electricAvailable
    && Math.abs(leftElectric - rightElectric)
      <= Math.max(1.5, leftElectric * 0.08);

  if (left.fuel_type === 'electric') return electricMatches;
  if (left.hybrid_type === 'plug_in_hybrid') {
    return thermalMatches && electricMatches;
  }
  return thermalMatches;
}

for (const versions of selectedByModelDrive.values()) {
  const byYear = new Map();
  for (const item of versions) {
    if (!byYear.has(item.representative_year)) {
      byYear.set(item.representative_year, []);
    }
    byYear.get(item.representative_year).push(item);
  }

  for (const item of versions) {
    for (
      let yearGap = 1;
      yearGap <= maximumObservationGapYears;
      yearGap += 1
    ) {
      const following = byYear.get(item.representative_year + yearGap) ?? [];
      for (const other of following) {
      if (Math.abs(item.power_kw - other.power_kw) > 3) continue;
      if (!energyCompatible(item, other)) continue;

      const leftBucket = rawBuckets.get(bucketKey(
        item.seed_model_id,
        item.representative_year,
        item.fuel_type,
        item.hybrid_type,
        item.power_kw,
      ));
      const rightBucket = rawBuckets.get(bucketKey(
        other.seed_model_id,
        other.representative_year,
        other.fuel_type,
        other.hybrid_type,
        other.power_kw,
      ));
      if (!leftBucket || !rightBucket) continue;

      let matchLevel = null;
      let shared = [];
      const matchLevels = yearGap === 1
        ? ['tvv', 'type_variant', 'type']
        : ['tvv', 'type_variant'];
      for (const level of matchLevels) {
        shared = [...leftBucket.signatures[level].keys()].filter(
          (signature) => rightBucket.signatures[level].has(signature),
        );
        if (shared.length > 0) {
          matchLevel = level;
          break;
        }
      }
      if (!matchLevel) continue;

      const sharedLeftRegistrations = shared.reduce(
        (sum, signature) => (
          sum + leftBucket.signatures[matchLevel].get(signature)
        ),
        0,
      );
      const sharedRightRegistrations = shared.reduce(
        (sum, signature) => (
          sum + rightBucket.signatures[matchLevel].get(signature)
        ),
        0,
      );
      const leftCoverage = leftBucket.registrations > 0
        ? sharedLeftRegistrations / leftBucket.registrations
        : 0;
      const rightCoverage = rightBucket.registrations > 0
        ? sharedRightRegistrations / rightBucket.registrations
        : 0;
      const minimumCoverage = Math.min(leftCoverage, rightCoverage);

      edges.push({
        left_id: item.historical_version_id,
        right_id: other.historical_version_id,
        seed_model_id: item.seed_model_id,
        brand: item.brand,
        model: item.model,
        fuel_type: item.fuel_type,
        hybrid_type: item.hybrid_type,
        left_year: item.representative_year,
        right_year: other.representative_year,
        year_gap: yearGap,
        left_power_kw: item.power_kw,
        right_power_kw: other.power_kw,
        shared_signature_count: shared.length,
        match_level: matchLevel,
        left_coverage: Number(leftCoverage.toFixed(4)),
        right_coverage: Number(rightCoverage.toFixed(4)),
        minimum_coverage: Number(minimumCoverage.toFixed(4)),
        confidence: (
          yearGap === 1
            ? (
              (
                matchLevel !== 'type'
                && minimumCoverage >= 0.70
              )
              || (
                matchLevel === 'type'
                && minimumCoverage >= 0.85
              )
            )
            : (
              matchLevel !== 'type'
              && minimumCoverage >= 0.80
            )
        )
          ? 'high'
          : minimumCoverage >= 0.35
            ? 'medium'
            : 'low',
      });
      }
    }
  }
}

const highEdges = edges.filter((edge) => edge.confidence === 'high');
const parent = new Map(selected.map((item) => [
  item.historical_version_id,
  item.historical_version_id,
]));

function find(id) {
  let current = id;
  while (parent.get(current) !== current) {
    current = parent.get(current);
  }
  let node = id;
  while (parent.get(node) !== current) {
    const next = parent.get(node);
    parent.set(node, current);
    node = next;
  }
  return current;
}

function union(left, right) {
  const leftRoot = find(left);
  const rightRoot = find(right);
  if (leftRoot !== rightRoot) parent.set(rightRoot, leftRoot);
}

for (const edge of highEdges) union(edge.left_id, edge.right_id);

const components = new Map();
for (const item of selected) {
  const rootId = find(item.historical_version_id);
  if (!components.has(rootId)) components.set(rootId, []);
  components.get(rootId).push(item);
}

const unmergedProposedRanges = [...components.values()]
  .filter((items) => items.length > 1)
  .map((items) => {
    items.sort((a, b) => a.representative_year - b.representative_year);
    const years = items.map((item) => item.representative_year);
    const distinctYears = [...new Set(years)];
    const maximumObservedGap = distinctYears.reduce(
      (maximum, year, index) => (
        index === 0
          ? maximum
          : Math.max(maximum, year - distinctYears[index - 1])
      ),
      1,
    );
    const contiguous = maximumObservedGap <= maximumObservationGapYears;
    const edgeRows = highEdges.filter(
      (edge) => items.some((item) => item.historical_version_id === edge.left_id)
        && items.some((item) => item.historical_version_id === edge.right_id),
    );
    return {
      seed_model_id: items[0].seed_model_id,
      brand: items[0].brand,
      model: items[0].model,
      fuel_type: items[0].fuel_type,
      hybrid_type: items[0].hybrid_type,
      year_from: Math.min(...years),
      year_to: Math.max(...years),
      years: distinctYears,
      contiguous,
      maximum_observed_gap: maximumObservedGap,
      power_kw_min: Math.min(...items.map((item) => item.power_kw)),
      power_kw_max: Math.max(...items.map((item) => item.power_kw)),
      power_cv_representative: Math.round(
        items.reduce((sum, item) => sum + Number(item.power_cv), 0)
          / items.length,
      ),
      thermal_consumption_min: Math.min(
        ...items
          .map((item) => Number(item.consumption_l_100km))
          .filter((value) => Number.isFinite(value) && value > 0),
      ),
      thermal_consumption_max: Math.max(
        ...items
          .map((item) => Number(item.consumption_l_100km))
          .filter((value) => Number.isFinite(value) && value > 0),
      ),
      electric_consumption_min: Math.min(
        ...items
          .map((item) => Number(item.electric_consumption_kwh_100km))
          .filter((value) => Number.isFinite(value) && value > 0),
      ),
      electric_consumption_max: Math.max(
        ...items
          .map((item) => Number(item.electric_consumption_kwh_100km))
          .filter((value) => Number.isFinite(value) && value > 0),
      ),
      profile_ids: items.map((item) => item.historical_version_id),
      minimum_tvv_coverage: Number(
        Math.min(...edgeRows.map((edge) => edge.minimum_coverage)).toFixed(4),
      ),
      edge_count: edgeRows.length,
    };
  })
  .filter((range) => range.contiguous)
  .sort((a, b) => (
    a.brand.localeCompare(b.brand)
    || a.model.localeCompare(b.model)
    || a.year_from - b.year_from
  ));

function finite(value) {
  return Number.isFinite(value) && value > 0;
}

function consumptionRangesCompatible(left, right) {
  if (left.fuel_type === 'electric') {
    if (
      !finite(left.electric_consumption_min)
      || !finite(left.electric_consumption_max)
      || !finite(right.electric_consumption_min)
      || !finite(right.electric_consumption_max)
    ) return false;
    return Math.max(
      left.electric_consumption_min,
      right.electric_consumption_min,
    ) <= Math.min(
      left.electric_consumption_max,
      right.electric_consumption_max,
    ) + 1.5;
  }

  if (
    !finite(left.thermal_consumption_min)
    || !finite(left.thermal_consumption_max)
    || !finite(right.thermal_consumption_min)
    || !finite(right.thermal_consumption_max)
  ) return false;
  return Math.max(
    left.thermal_consumption_min,
    right.thermal_consumption_min,
  ) <= Math.min(
    left.thermal_consumption_max,
    right.thermal_consumption_max,
  ) + 0.35;
}

// Due famiglie di omologazione contemporanee ma indistinguibili nella UI
// (stesso modello, alimentazione, potenza e consumo) diventano una sola riga.
const proposedRanges = [];
for (const candidate of unmergedProposedRanges) {
  const existing = proposedRanges.find((range) => (
    range.seed_model_id === candidate.seed_model_id
    && range.fuel_type === candidate.fuel_type
    && range.hybrid_type === candidate.hybrid_type
    && Math.abs(
      range.power_cv_representative - candidate.power_cv_representative
    ) <= 5
    && range.year_from <= candidate.year_to
    && range.year_to >= candidate.year_from
    && consumptionRangesCompatible(range, candidate)
  ));

  if (!existing) {
    proposedRanges.push({
      ...candidate,
      profile_ids: candidate.profile_ids.slice(),
      years: candidate.years.slice(),
    });
    continue;
  }

  const previousMemberCount = existing.profile_ids.length;
  const incomingMemberCount = candidate.profile_ids.length;
  existing.year_from = Math.min(existing.year_from, candidate.year_from);
  existing.year_to = Math.max(existing.year_to, candidate.year_to);
  existing.years = [...new Set([...existing.years, ...candidate.years])]
    .sort((a, b) => a - b);
  existing.power_kw_min = Math.min(
    existing.power_kw_min,
    candidate.power_kw_min,
  );
  existing.power_kw_max = Math.max(
    existing.power_kw_max,
    candidate.power_kw_max,
  );
  existing.power_cv_representative = Math.round(
    (
      existing.power_cv_representative * previousMemberCount
      + candidate.power_cv_representative * incomingMemberCount
    ) / (previousMemberCount + incomingMemberCount),
  );
  for (const field of [
    'thermal_consumption_min',
    'electric_consumption_min',
  ]) {
    const values = [existing[field], candidate[field]].filter(finite);
    existing[field] = values.length > 0 ? Math.min(...values) : Infinity;
  }
  for (const field of [
    'thermal_consumption_max',
    'electric_consumption_max',
  ]) {
    const values = [existing[field], candidate[field]].filter(finite);
    existing[field] = values.length > 0 ? Math.max(...values) : -Infinity;
  }
  existing.profile_ids = [...new Set([
    ...existing.profile_ids,
    ...candidate.profile_ids,
  ])];
  existing.minimum_tvv_coverage = Math.min(
    existing.minimum_tvv_coverage,
    candidate.minimum_tvv_coverage,
  );
  existing.edge_count += candidate.edge_count;
}

proposedRanges.sort((a, b) => (
  a.brand.localeCompare(b.brand)
  || a.model.localeCompare(b.model)
  || a.year_from - b.year_from
));

const publishableRanges = proposedRanges.map((range) => ({
  ...range,
  range_id: `eea_tvv_range_v2_${crypto
    .createHash('sha256')
    .update([
      range.seed_model_id,
      range.fuel_type,
      range.hybrid_type,
      range.year_from,
      range.year_to,
      ...range.profile_ids.slice().sort(),
    ].join('|'))
    .digest('hex')
    .slice(0, 24)}`,
  evidence_status: 'confirmed',
  evidence_method: 'high_confidence_tvv_continuity',
}));

const crossPowerProfileIds = new Set(
  highEdges
    .filter(
      (edge) => (
        Math.round(edge.left_power_kw) !== Math.round(edge.right_power_kw)
      ),
    )
    .flatMap((edge) => [edge.left_id, edge.right_id]),
);

const gapContinuityProfileIds = new Set(
  highEdges
    .filter((edge) => edge.year_gap > 1)
    .flatMap((edge) => [edge.left_id, edge.right_id]),
);

const usefulRanges = proposedRanges
  .filter(
    (range) => (
      range.profile_ids.some(
        (profileId) => crossPowerProfileIds.has(profileId),
      )
      || range.profile_ids.some(
        (profileId) => gapContinuityProfileIds.has(profileId),
      )
    ),
  )
  .map((range) => ({
    ...range,
    range_id: `eea_tvv_range_${crypto
      .createHash('sha256')
      .update([
        range.seed_model_id,
        range.fuel_type,
        range.hybrid_type,
        range.year_from,
        range.year_to,
        ...range.profile_ids.slice().sort(),
      ].join('|'))
      .digest('hex')
      .slice(0, 24)}`,
  }));

const summary = {
  generated_at: new Date().toISOString(),
  source: 'EEA Italy 2010-2025 Type/Variant/Version continuity',
  raw_rows: rawRows,
  raw_rows_with_tvv: rowsWithTvv,
  raw_tvv_coverage_pct: Number((100 * rowsWithTvv / rawRows).toFixed(2)),
  mapped_rows: mappedRows,
  mapped_rows_with_tvv: mappedRowsWithTvv,
  mapped_tvv_coverage_pct: Number(
    (100 * mappedRowsWithTvv / mappedRows).toFixed(2),
  ),
  selected_profiles: selected.length,
  candidate_edges_with_shared_tvv: edges.length,
  high_confidence_edges: highEdges.length,
  medium_confidence_edges: edges.filter(
    (edge) => edge.confidence === 'medium',
  ).length,
  low_confidence_edges: edges.filter(
    (edge) => edge.confidence === 'low',
  ).length,
  proposed_high_confidence_ranges: proposedRanges.length,
  publishable_ranges: publishableRanges.length,
  profiles_covered_by_proposed_ranges: proposedRanges.reduce(
    (sum, range) => sum + range.profile_ids.length,
    0,
  ),
  models_covered: new Set(
    proposedRanges.map((range) => `${range.brand}|${range.model}`),
  ).size,
  useful_cross_power_edges: highEdges.filter(
    (edge) => Math.round(edge.left_power_kw) !== Math.round(edge.right_power_kw),
  ).length,
  useful_gap_continuity_edges: highEdges.filter(
    (edge) => edge.year_gap > 1,
  ).length,
  useful_ranges_not_already_built_by_current_logic: usefulRanges.length,
  useful_profiles: usefulRanges.reduce(
    (sum, range) => sum + range.profile_ids.length,
    0,
  ),
  useful_models: new Set(
    usefulRanges.map((range) => `${range.brand}|${range.model}`),
  ).size,
};

fs.mkdirSync(outputDir, { recursive: true });
fs.writeFileSync(
  path.join(outputDir, 'tvv-gap-continuity-summary.json'),
  `${JSON.stringify(summary, null, 2)}\n`,
);
fs.writeFileSync(
  path.join(outputDir, 'tvv-gap-continuity-edges.json'),
  `${JSON.stringify(edges, null, 2)}\n`,
);
fs.writeFileSync(
  path.join(outputDir, 'tvv-gap-continuity-proposed-ranges.json'),
  `${JSON.stringify(publishableRanges, null, 2)}\n`,
);
fs.writeFileSync(
  path.join(outputDir, 'tvv-gap-continuity-useful-ranges.json'),
  `${JSON.stringify(usefulRanges, null, 2)}\n`,
);

function sqlCopyValue(value) {
  if (value === null || value === undefined || value === '') return '\\N';
  return String(value)
    .replace(/\\/g, '\\\\')
    .replace(/\t/g, ' ')
    .replace(/\r?\n/g, ' ');
}

const rangeCopyRows = publishableRanges.map((range) => [
  range.range_id,
  range.seed_model_id,
  range.brand,
  range.model,
  range.year_from,
  range.year_to,
  range.fuel_type,
  range.hybrid_type,
  range.power_cv_representative,
  range.minimum_tvv_coverage,
  range.profile_ids.length,
  Number.isFinite(range.thermal_consumption_min)
    ? range.thermal_consumption_min
    : null,
  Number.isFinite(range.thermal_consumption_max)
    ? range.thermal_consumption_max
    : null,
  Number.isFinite(range.electric_consumption_min)
    ? range.electric_consumption_min
    : null,
  Number.isFinite(range.electric_consumption_max)
    ? range.electric_consumption_max
    : null,
  'high',
  'EEA CO2 monitoring, continuita Tipo/Variante/Versione',
  'https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b',
].map(sqlCopyValue).join('\t'));

const memberCopyRows = publishableRanges.flatMap((range) => (
  range.profile_ids.map((historicalVersionId) => [
    range.range_id,
    historicalVersionId,
    selectedById.get(historicalVersionId)?.vehicle_profile_id ?? null,
  ].map(sqlCopyValue).join('\t'))
));

const dataSql = `-- Generato da scripts/audit-eea-tvv-continuity.mjs.
-- Include continuita EEA TVV anche in presenza di uno o due anni
-- senza immatricolazioni osservate.

COPY mvp.eea_historical_display_ranges_v1 (
  range_id,
  seed_model_id,
  brand,
  model,
  year_from,
  year_to,
  fuel_type,
  hybrid_type,
  display_power_cv,
  minimum_tvv_coverage,
  member_count,
  thermal_consumption_min,
  thermal_consumption_max,
  electric_consumption_min,
  electric_consumption_max,
  confidence,
  source_name,
  source_url
) FROM stdin;
${rangeCopyRows.join('\n')}
\\.

COPY mvp.eea_historical_display_range_members_v1 (
  range_id,
  historical_version_id,
  vehicle_profile_id
) FROM stdin;
${memberCopyRows.join('\n')}
\\.
`;

fs.writeFileSync(
  path.join(outputDir, 'display-ranges-copy.sql'),
  dataSql,
);
if (publishData) {
  fs.writeFileSync(
    path.join(repoDir, 'supabase', '27_tvv_gap_display_ranges_data.sql'),
    dataSql,
  );
}

console.log(JSON.stringify(summary, null, 2));
console.log(`SQL di produzione aggiornato: ${publishData ? 'si' : 'no'}`);
console.log('\nEsempi di intervalli ad alta affidabilita:');
for (const range of publishableRanges.slice(0, 20)) {
  console.log(
    `${range.brand} ${range.model}: ${range.year_from}-${range.year_to}, `
      + `${range.fuel_type}, ${range.power_cv_representative} CV, `
      + `copertura TVV minima ${(range.minimum_tvv_coverage * 100).toFixed(1)}%`,
  );
}
