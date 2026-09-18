import crypto from 'node:crypto';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const repoDir = path.dirname(scriptDir);
const workspaceDir = path.dirname(repoDir);
const inputDir = path.join(workspaceDir, 'eea_history_input');
const outputDir = path.join(repoDir, 'docs', 'audits');

const firstYear = 2010;
const lastYear = 2024;
const preferredStatuses = ['F', 'P'];

function sha256(buffer) {
  return crypto.createHash('sha256').update(buffer).digest('hex');
}

function integer(value) {
  const parsed = Number(value);
  return Number.isFinite(parsed) ? Math.max(0, Math.trunc(parsed)) : 0;
}

function observationKey(row) {
  return [
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
}

function percent(numerator, denominator) {
  if (!denominator) return 0;
  return Math.round((numerator / denominator) * 10000) / 100;
}

function formatInteger(value) {
  return new Intl.NumberFormat('it-IT').format(value);
}

function escapeTable(value) {
  return String(value ?? '').replaceAll('|', '\\|');
}

if (!fs.existsSync(inputDir)) {
  throw new Error(`Cartella EEA non trovata: ${inputDir}`);
}

const years = [];
for (let year = firstYear; year <= lastYear; year += 1) {
  const fileName = `eea-italy-${year}-tvv.json`;
  const filePath = path.join(inputDir, fileName);
  if (!fs.existsSync(filePath)) {
    throw new Error(`File EEA mancante: ${filePath}`);
  }

  const buffer = fs.readFileSync(filePath);
  const payload = JSON.parse(buffer.toString('utf8'));
  if (!Array.isArray(payload.rows)) {
    throw new Error(`Formato non valido in ${fileName}: rows non e un array`);
  }

  const statusMaps = new Map();
  for (const row of payload.rows) {
    const status = String(row.status ?? '').trim().toUpperCase() || 'MISSING';
    if (!statusMaps.has(status)) statusMaps.set(status, new Map());
    const key = observationKey(row);
    const statusMap = statusMaps.get(status);
    const previous = statusMap.get(key) ?? { rows: 0, registrations: 0 };
    previous.rows += 1;
    previous.registrations += integer(row.registrations_count);
    statusMap.set(key, previous);
  }

  const availableStatuses = [...statusMaps.keys()].sort();
  const selectedStatus = preferredStatuses.find((status) => statusMaps.has(status));
  if (!selectedStatus) {
    throw new Error(
      `Nessuna edizione F/P riconosciuta per ${year}: ${availableStatuses.join(', ')}`,
    );
  }

  const statusStats = Object.fromEntries(
    [...statusMaps.entries()].sort(([a], [b]) => a.localeCompare(b)).map(([status, rows]) => [
      status,
      {
        rows: [...rows.values()].reduce((sum, item) => sum + item.rows, 0),
        unique_observations: rows.size,
        registrations: [...rows.values()].reduce(
          (sum, item) => sum + item.registrations,
          0,
        ),
      },
    ]),
  );

  const finalRows = statusMaps.get('F') ?? new Map();
  const provisionalRows = statusMaps.get('P') ?? new Map();
  let overlappingObservations = 0;
  let overlappingWithDifferentCounts = 0;
  for (const [key, finalObservation] of finalRows) {
    const provisionalObservation = provisionalRows.get(key);
    if (!provisionalObservation) continue;
    overlappingObservations += 1;
    if (finalObservation.registrations !== provisionalObservation.registrations) {
      overlappingWithDifferentCounts += 1;
    }
  }

  const selected = statusStats[selectedStatus];
  const allRows = Object.values(statusStats).reduce((sum, item) => sum + item.rows, 0);
  const allRegistrations = Object.values(statusStats).reduce(
    (sum, item) => sum + item.registrations,
    0,
  );

  years.push({
    year,
    file: fileName,
    source_url: payload.source_url ?? null,
    downloaded_at: payload.downloaded_at ?? null,
    sha256: sha256(buffer),
    bytes: buffer.length,
    available_statuses: availableStatuses,
    selected_status: selectedStatus,
    selected_quality: selectedStatus === 'F' ? 'final' : 'provisional',
    selection_rule: selectedStatus === 'F'
      ? 'final_preferred'
      : 'provisional_used_because_final_missing',
    status_stats: statusStats,
    selected_rows: selected.rows,
    selected_registrations: selected.registrations,
    rows_excluded_from_other_editions: allRows - selected.rows,
    registrations_excluded_from_other_editions: allRegistrations - selected.registrations,
    final_provisional_overlap: {
      observations: overlappingObservations,
      observations_with_different_registration_counts: overlappingWithDifferentCounts,
    },
  });
}

const totals = {
  source_files: years.length,
  final_years: years.filter((item) => item.selected_status === 'F').length,
  provisional_years: years.filter((item) => item.selected_status === 'P').length,
  mixed_edition_files: years.filter((item) => item.available_statuses.length > 1).length,
  all_rows_before_selection: years.reduce(
    (sum, item) => sum + Object.values(item.status_stats)
      .reduce((inner, status) => inner + status.rows, 0),
    0,
  ),
  canonical_rows: years.reduce((sum, item) => sum + item.selected_rows, 0),
  excluded_rows: years.reduce(
    (sum, item) => sum + item.rows_excluded_from_other_editions,
    0,
  ),
  all_registrations_before_selection: years.reduce(
    (sum, item) => sum + Object.values(item.status_stats)
      .reduce((inner, status) => inner + status.registrations, 0),
    0,
  ),
  canonical_registrations: years.reduce(
    (sum, item) => sum + item.selected_registrations,
    0,
  ),
  excluded_registrations: years.reduce(
    (sum, item) => sum + item.registrations_excluded_from_other_editions,
    0,
  ),
  overlapping_final_provisional_observations: years.reduce(
    (sum, item) => sum + item.final_provisional_overlap.observations,
    0,
  ),
  overlapping_observations_with_different_counts: years.reduce(
    (sum, item) => sum
      + item.final_provisional_overlap.observations_with_different_registration_counts,
    0,
  ),
};

totals.excluded_rows_percent = percent(totals.excluded_rows, totals.all_rows_before_selection);
totals.excluded_registrations_percent = percent(
  totals.excluded_registrations,
  totals.all_registrations_before_selection,
);

const manifest = {
  schema_version: 1,
  generated_at: new Date().toISOString(),
  source: 'EEA CO2 monitoring data for cars, Italy',
  country: 'IT',
  input_directory: '../eea_history_input',
  canonical_edition_policy: {
    order: preferredStatuses,
    description: 'Usa l edizione finale F; usa P solo quando F non e disponibile.',
  },
  totals,
  years,
};

const rows = years.map((item) => {
  const finalStats = item.status_stats.F ?? { rows: 0, registrations: 0 };
  const provisionalStats = item.status_stats.P ?? { rows: 0, registrations: 0 };
  return `| ${item.year} | ${item.selected_status} | ${formatInteger(finalStats.rows)} | ${formatInteger(provisionalStats.rows)} | ${formatInteger(item.rows_excluded_from_other_editions)} | ${formatInteger(item.final_provisional_overlap.observations)} | ${escapeTable(item.selected_quality)} |`;
});

const report = `# Audit delle edizioni EEA storiche

Generato: ${manifest.generated_at}

## Esito

Il vecchio generatore leggeva tutte le righe presenti nei file annuali senza scegliere una singola edizione. ${totals.mixed_edition_files} file su ${totals.source_files} contengono insieme dati finali (F) e provvisori (P), quindi le immatricolazioni e il peso relativo delle versioni potevano essere contati due volte o combinati tra revisioni diverse.

La regola canonica introdotta dall audit e:

- usare F quando esiste;
- usare P solo se F non esiste;
- rifiutare un anno senza una delle due edizioni;
- conservare hash, data di download, URL e statistiche per rendere il processo riproducibile.

Con questa regola si usano ${formatInteger(totals.canonical_rows)} righe su ${formatInteger(totals.all_rows_before_selection)}. Vengono escluse ${formatInteger(totals.excluded_rows)} righe (${totals.excluded_rows_percent}%) appartenenti a edizioni alternative dello stesso anno. Questo non significa che siano tutte duplicati perfetti: ${formatInteger(totals.overlapping_final_provisional_observations)} osservazioni tecniche compaiono sia in F sia in P e ${formatInteger(totals.overlapping_observations_with_different_counts)} hanno conteggi di immatricolazioni diversi.

## Edizione scelta per anno

| Anno | Scelta | Righe F | Righe P | Righe escluse | Osservazioni comuni F/P | Qualita |
|---:|:---:|---:|---:|---:|---:|:---|
${rows.join('\n')}

## Conseguenze operative

1. Il catalogo storico corrente non va rigenerato con il vecchio script senza filtro: produrrebbe nuovamente il difetto.
2. Il prossimo generatore deve leggere il manifest e accettare soltanto l edizione scelta per ogni anno.
3. La scelta dell edizione risolve il doppio conteggio alla fonte, ma non basta a garantire identita commerciali corrette: normalizzazione di marca/modello, raggruppamento e donazione di consumi devono avere audit separati.
4. Nessuna modifica al database online e stata applicata da questo audit.
`;

fs.mkdirSync(outputDir, { recursive: true });
fs.writeFileSync(
  path.join(outputDir, 'eea-history-source-manifest.json'),
  `${JSON.stringify(manifest, null, 2)}\n`,
);
fs.writeFileSync(
  path.join(outputDir, 'eea-history-source-audit.md'),
  report,
);

console.log(JSON.stringify({
  ...totals,
  manifest: path.relative(repoDir, path.join(outputDir, 'eea-history-source-manifest.json')),
  report: path.relative(repoDir, path.join(outputDir, 'eea-history-source-audit.md')),
  verification: 'ok',
}, null, 2));
