import crypto from 'node:crypto';
import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const repoDir = path.dirname(scriptDir);
const workspaceDir = path.dirname(repoDir);
const templatePath = path.join(
  repoDir,
  'supabase',
  '48_passo2_staging_pipeline_eea.sql',
);
const outputPath = path.join(
  workspaceDir,
  'pipeline_review_output_v2',
  '48_passo2_staging_pipeline_eea.generated.sql',
);

const canonicalManifestPath = path.join(
  repoDir,
  'docs',
  'audits',
  'eea-history-canonical-manifest.json',
);
const normalizedManifestPath = path.join(
  repoDir,
  'docs',
  'audits',
  'eea-history-normalized-manifest.json',
);
const historicalDir = path.join(workspaceDir, 'historical_catalog_output_v2');
const rangesDir = path.join(workspaceDir, 'catalog_audit_output_v2');
const reviewDir = path.join(workspaceDir, 'pipeline_review_output_v2');

function fingerprint(value) {
  return crypto.createHash('sha256').update(value).digest('hex');
}

function observationKey(item) {
  const identity = [
    item.seed_model_id,
    item.year,
    item.fuel_type,
    item.hybrid_type,
    item.power_kw,
  ].join('|');
  return `eea_commercial_${fingerprint(identity).slice(0, 24)}`;
}

function reconciliationKey(item, index) {
  const version = item.version;
  const identity = [
    version.display_variant_id,
    version.vehicle_cluster_id,
    version.brand,
    version.model,
    version.version_label,
    index,
  ].join('|');
  return `eea_reconciliation_${fingerprint(identity).slice(0, 24)}`;
}

function copyValue(value) {
  if (value === null || value === undefined || value === '') return '\\N';
  let text;
  if (typeof value === 'object') text = JSON.stringify(value);
  else if (typeof value === 'boolean') text = value ? 't' : 'f';
  else text = String(value);
  return text
    .replace(/\\/g, '\\\\')
    .replace(/\t/g, '\\t')
    .replace(/\r/g, '\\r')
    .replace(/\n/g, '\\n');
}

function copyBlock(table, columns, rows) {
  const lines = rows.map((row) => (
    columns.map((column) => copyValue(row[column])).join('\t')
  ));
  return [
    `COPY ${table} (${columns.join(', ')}) FROM STDIN;`,
    ...lines,
    '\\.',
    '',
  ].join('\n');
}

function sqlLiteral(value) {
  return `'${String(value).replace(/'/g, "''")}'`;
}

async function readJson(filePath) {
  return JSON.parse(await fs.readFile(filePath, 'utf8'));
}

const [
  template,
  canonicalManifest,
  normalizedManifest,
  historicalSummary,
  commercialObservations,
  historicalVersions,
  rangesSummary,
  ranges,
  reconciliation,
] = await Promise.all([
  fs.readFile(templatePath, 'utf8'),
  readJson(canonicalManifestPath),
  readJson(normalizedManifestPath),
  readJson(path.join(historicalDir, 'summary.json')),
  readJson(path.join(historicalDir, 'commercial-observations.json')),
  readJson(path.join(historicalDir, 'historical-versions.json')),
  readJson(path.join(rangesDir, 'tvv-gap-continuity-summary.json')),
  readJson(path.join(rangesDir, 'tvv-gap-continuity-proposed-ranges.json')),
  readJson(path.join(reviewDir, 'catalog-reconciliation.json')),
]);

const marker = '-- __PASSO2_GENERATED_DATA__';
if (!template.includes(marker)) throw new Error('Segnaposto dati mancante nella migrazione 48');

const canonicalFingerprint = fingerprint(
  canonicalManifest.files
    .map((item) => `${item.year}|${item.status}|${item.data_sha256}`)
    .join('\n'),
);
const normalizedFingerprint = fingerprint(
  normalizedManifest.files
    .map((item) => `${item.year}|${item.source_data_sha256}|${item.normalized_sha256}`)
    .join('\n'),
);
const runId = `eea_pipeline_v2_${fingerprint([
  canonicalFingerprint,
  normalizedFingerprint,
  'commercial_identity_v2',
  'tvv_continuity_v2',
].join('|')).slice(0, 24)}`;

const publishable = historicalVersions.filter(
  (item) => item.publication_status === 'publishable',
).length;
const quarantined = historicalVersions.filter(
  (item) => item.publication_status === 'candidate',
).length;

const expected = {
  observations: commercialObservations.length,
  candidates: historicalVersions.length,
  publishable,
  quarantined,
  ranges: ranges.length,
  reconciled: reconciliation.current_versions.length,
};

if (canonicalManifest.totals.final_years !== 15) {
  throw new Error('La pipeline non usa 15 annualita finali');
}
if (normalizedManifest.totals.rows !== canonicalManifest.totals.rows) {
  throw new Error('Il livello normalizzato non coincide con la sorgente canonica');
}
if (historicalSummary.selected_versions !== historicalVersions.length) {
  throw new Error('Il riepilogo storico non coincide con i candidati generati');
}
if (historicalSummary.publishable_versions !== publishable
    || historicalSummary.candidate_versions !== quarantined) {
  throw new Error('Le classificazioni pubblicabile/quarantena non coincidono');
}
if (rangesSummary.publishable_ranges !== ranges.length) {
  throw new Error('Il riepilogo TVV non coincide con gli intervalli generati');
}
if (reconciliation.counts.online_versions !== reconciliation.current_versions.length) {
  throw new Error('La riconciliazione non copre tutto il catalogo online');
}

const observationKeys = new Set();
const observationRows = commercialObservations.map((item) => {
  const key = observationKey(item);
  if (observationKeys.has(key)) throw new Error(`Osservazione commerciale duplicata: ${key}`);
  observationKeys.add(key);
  return {
    run_id: runId,
    observation_key: key,
    seed_model_id: item.seed_model_id,
    brand: item.brand,
    model: item.model,
    observation_year: item.year,
    source_status: item.source_status,
    fuel_type: item.fuel_type,
    hybrid_type: item.hybrid_type,
    power_kw: item.power_kw,
    direct_consumption_l_100km: item.direct_consumption_l_100km,
    direct_electric_consumption_kwh_100km:
      item.direct_electric_consumption_kwh_100km,
    registrations_count: item.registrations_count,
    source_records_count: item.source_records_count,
    model_match_methods: item.model_match_methods,
    source_identity_samples: item.source_identity_samples,
    selected_for_catalog: item.selected_for_catalog,
    selection_reason: item.selection_reason,
  };
});

const candidateRows = historicalVersions.map((item) => {
  const key = observationKey({
    seed_model_id: item.seed_model_id ?? item.seed?.id,
    year: item.representative_year ?? item.year,
    fuel_type: item.fuel_type,
    hybrid_type: item.hybrid_type,
    power_kw: item.power_kw,
  });
  if (!observationKeys.has(key)) {
    throw new Error(`Candidato senza osservazione commerciale: ${item.historical_version_id}`);
  }
  return {
    run_id: runId,
    historical_version_id: item.historical_version_id,
    observation_key: key,
    seed_model_id: item.seed_model_id ?? item.seed?.id,
    brand: item.brand ?? item.seed?.brand,
    model: item.model ?? item.seed?.model,
    representative_year: item.representative_year ?? item.year,
    fuel_type: item.fuel_type,
    hybrid_type: item.hybrid_type,
    power_kw: item.power_kw,
    power_cv: item.power_cv,
    direct_consumption_l_100km: item.direct_consumption_l_100km,
    direct_electric_consumption_kwh_100km:
      item.direct_electric_consumption_kwh_100km,
    selected_consumption_l_100km: item.consumption_l_100km,
    selected_electric_consumption_kwh_100km:
      item.electric_consumption_kwh_100km,
    registrations_count: item.registrations_count,
    source_records_count: item.source_records_count,
    source_status: item.source_status,
    confidence: item.confidence,
    energy_method: item.energy_method,
    model_match_methods: item.model_match_methods,
    quarantine_reasons: item.quarantine_reasons,
    publication_status: item.publication_status,
  };
});

const rangeRows = ranges.map((item) => ({
  run_id: runId,
  range_id: item.range_id,
  seed_model_id: item.seed_model_id,
  brand: item.brand,
  model: item.model,
  fuel_type: item.fuel_type,
  hybrid_type: item.hybrid_type,
  year_from: item.year_from,
  year_to: item.year_to,
  observed_years: item.years,
  maximum_observed_gap: item.maximum_observed_gap,
  power_kw_min: item.power_kw_min,
  power_kw_max: item.power_kw_max,
  power_cv_representative: item.power_cv_representative,
  thermal_consumption_min: item.thermal_consumption_min,
  thermal_consumption_max: item.thermal_consumption_max,
  electric_consumption_min: item.electric_consumption_min,
  electric_consumption_max: item.electric_consumption_max,
  profile_ids: item.profile_ids,
  minimum_tvv_coverage: item.minimum_tvv_coverage,
  edge_count: item.edge_count,
  evidence_status: item.evidence_status,
  evidence_method: item.evidence_method,
}));

const reconciliationRows = reconciliation.current_versions.map((item, index) => ({
  run_id: runId,
  reconciliation_id: reconciliationKey(item, index),
  display_variant_id: item.version.display_variant_id,
  vehicle_cluster_id: item.version.vehicle_cluster_id,
  brand: item.version.brand,
  model: item.version.model,
  version_label: item.version.version_label,
  classification: item.classification,
  year_from: item.version.year_from,
  year_to: item.version.year_to,
  fuel_type: item.version.fuel_type,
  hybrid_type: item.version.hybrid_type,
  power_kw: item.version.power_kw,
  power_cv: item.version.power_cv,
  observed_years: item.observed_years,
  raw_observed_years: item.raw_observed_years,
  suggested_ranges: item.suggested_ranges,
}));

const runRow = {
  run_id: runId,
  pipeline_version: '2.0.0',
  generated_at: historicalSummary.generated_at,
  source_year_from: 2010,
  source_year_to: 2024,
  source_files: canonicalManifest.totals.years,
  source_rows: canonicalManifest.totals.rows,
  source_registrations: canonicalManifest.totals.registrations,
  mapped_registrations: historicalSummary.mapped_registrations,
  mapped_registrations_pct: historicalSummary.mapped_registrations_pct,
  commercial_observations: commercialObservations.length,
  selected_versions: historicalVersions.length,
  publishable_versions: publishable,
  candidate_versions: quarantined,
  confirmed_ranges: ranges.length,
  reconciled_online_versions: reconciliation.current_versions.length,
  canonical_manifest_fingerprint: canonicalFingerprint,
  normalized_manifest_fingerprint: normalizedFingerprint,
  policy: {
    source_editions: 'final_only',
    raw_layer: 'immutable_local_snapshot',
    normalized_layer: 'one_observation_per_source_row',
    approximate_matches: 'candidate_not_public',
    intervals: 'high_confidence_tvv_only',
    current_public_catalog: 'unchanged_by_this_migration',
  },
};

const blocks = [];
blocks.push(`DELETE FROM mvp.eea_pipeline_runs_v2 WHERE run_id = ${sqlLiteral(runId)};\n`);
blocks.push(copyBlock(
  'mvp.eea_pipeline_runs_v2',
  Object.keys(runRow),
  [runRow],
));
blocks.push(copyBlock(
  'mvp.eea_commercial_observations_v2',
  Object.keys(observationRows[0]),
  observationRows,
));
blocks.push(copyBlock(
  'mvp.eea_historical_version_candidates_v2',
  Object.keys(candidateRows[0]),
  candidateRows,
));
blocks.push(copyBlock(
  'mvp.eea_display_ranges_v2',
  Object.keys(rangeRows[0]),
  rangeRows,
));
blocks.push(copyBlock(
  'mvp.eea_catalog_reconciliation_v2',
  Object.keys(reconciliationRows[0]),
  reconciliationRows,
));
blocks.push([
  'CREATE TEMP TABLE _passo2_expected_v1 (',
  '  run_id text, observations integer, candidates integer,',
  '  publishable integer, quarantined integer, ranges integer, reconciled integer',
  ');',
  `INSERT INTO _passo2_expected_v1 VALUES (${[
    runId,
    expected.observations,
    expected.candidates,
    expected.publishable,
    expected.quarantined,
    expected.ranges,
    expected.reconciled,
  ].map(sqlLiteral).join(', ')});`,
  '',
].join('\n'));

await fs.mkdir(path.dirname(outputPath), { recursive: true });
await fs.writeFile(
  outputPath,
  template.replace(marker, blocks.join('\n')),
  'utf8',
);

const outputStat = await fs.stat(outputPath);
console.log(JSON.stringify({
  run_id: runId,
  output: outputPath,
  output_bytes: outputStat.size,
  ...expected,
  public_catalog_changed: false,
  verification: 'ok',
}, null, 2));
