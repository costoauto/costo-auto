import crypto from 'node:crypto';
import fs from 'node:fs/promises';
import path from 'node:path';
import process from 'node:process';
import { fileURLToPath } from 'node:url';

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const repoDir = path.dirname(scriptDir);
const workspaceDir = path.dirname(repoDir);
const rawDir = path.join(workspaceDir, 'eea_history_input');
const canonicalDir = path.join(workspaceDir, 'eea_history_canonical');
const manifestPath = path.join(
  repoDir,
  'docs',
  'audits',
  'eea-history-canonical-manifest.json',
);

const endpoint = 'https://discodata.eea.europa.eu/sql';
const pageSize = 50000;
const firstYear = 2010;
const lastYear = 2024;
const downloadAll = process.argv.includes('--download-all');

// Le tabelle annuali finali colmano gli anni per cui il vecchio snapshot
// conteneva solo l'edizione provvisoria.
const remoteFinalSources = new Map([
  [2022, '[CO2Emission].[latest].[co2cars_2022Fv26]'],
  [2024, '[CO2Emission].[latest].[co2cars_2024Fv30]'],
]);

function officialTableForYear(year) {
  if (year === 2022) return '[CO2Emission].[latest].[co2cars_2022Fv26]';
  if (year === 2023) return '[CO2Emission].[latest].[co2cars_2023Fv28]';
  if (year === 2024) return '[CO2Emission].[latest].[co2cars_2024Fv30]';
  return '[CO2Emission].[latest].[co2cars]';
}

const wait = (milliseconds) => new Promise((resolve) => {
  setTimeout(resolve, milliseconds);
});

function queryFor(table, year) {
  return `
SELECT
  [Year] AS [year],
  [Status] AS [status],
  [Mk] AS [make],
  [Cn] AS [commercial_name],
  [T] AS [type],
  [Va] AS [variant],
  [Ve] AS [version],
  [Ft] AS [fuel_type],
  [Fm] AS [fuel_mode],
  [Ep (KW)] AS [power_kw],
  [Ec (cm3)] AS [engine_capacity_cm3],
  [Fc] AS [fuel_consumption_l_100km],
  [Z (Wh/km)] AS [electric_consumption_wh_km],
  [Erwltp (g/km)] AS [co2_wltp_g_km],
  [Enedc (g/km)] AS [co2_nedc_g_km],
  COUNT(*) AS [registrations_count]
FROM ${table}
WHERE [MS] = 'IT'
  AND [Year] = ${year}
  AND [Status] = 'F'
GROUP BY
  [Year], [Status], [Mk], [Cn], [T], [Va], [Ve],
  [Ft], [Fm], [Ep (KW)], [Ec (cm3)], [Fc], [Z (Wh/km)],
  [Erwltp (g/km)], [Enedc (g/km)]
  `.trim();
}

async function fetchJson(url, attempts = 4) {
  let lastError;
  for (let attempt = 1; attempt <= attempts; attempt += 1) {
    try {
      const response = await fetch(url, {
        headers: {
          accept: 'application/json',
          'user-agent': 'CostoAuto-canonical-EEA-import/2.0',
        },
        signal: AbortSignal.timeout(120000),
      });
      if (!response.ok) {
        throw new Error(`HTTP ${response.status} ${response.statusText}`);
      }
      const payload = await response.json();
      if (Array.isArray(payload.errors) && payload.errors.length > 0) {
        throw new Error(payload.errors.map((item) => item.error).join(' | '));
      }
      if (!Array.isArray(payload.results)) {
        throw new Error('La risposta EEA non contiene results');
      }
      return payload.results;
    } catch (error) {
      lastError = error;
      if (attempt < attempts) await wait(attempt * 2000);
    }
  }
  throw lastError;
}

async function downloadFinal(year, table) {
  const query = queryFor(table, year);
  const rows = [];
  for (let page = 1; ; page += 1) {
    const url = new URL(endpoint);
    url.searchParams.set('query', query);
    url.searchParams.set('p', String(page));
    url.searchParams.set('nrOfHits', String(pageSize));
    process.stdout.write(`EEA ${year} F, pagina ${page}... `);
    const pageRows = await fetchJson(url);
    console.log(`${pageRows.length} righe`);
    if (pageRows.length === 0) break;
    rows.push(...pageRows);
  }
  if (rows.length === 0) {
    throw new Error(`La tabella finale ${table} non ha restituito righe italiane`);
  }
  return rows;
}

function dataHash(rows) {
  return crypto.createHash('sha256').update(JSON.stringify(rows)).digest('hex');
}

function validateRows(rows, year) {
  const invalid = rows.filter((row) => (
    Number(row.year) !== year || String(row.status ?? '').trim().toUpperCase() !== 'F'
  ));
  if (invalid.length > 0) {
    throw new Error(`${year}: ${invalid.length} righe non appartengono all'edizione finale`);
  }
}

async function main() {
  const prepared = [];

  // Prima eseguiamo tutti i download: se la rete fallisce, non tocchiamo
  // nessun file canonico gia presente.
  const remoteRows = new Map();
  const downloadedTables = new Map(
    (downloadAll
      ? Array.from({ length: lastYear - firstYear + 1 }, (_, index) => firstYear + index)
      : [...remoteFinalSources.keys()]
    ).map((year) => [year, officialTableForYear(year)]),
  );
  for (const [year, table] of downloadedTables) {
    remoteRows.set(year, await downloadFinal(year, table));
  }

  await fs.mkdir(canonicalDir, { recursive: true });
  await fs.mkdir(path.dirname(manifestPath), { recursive: true });

  for (let year = firstYear; year <= lastYear; year += 1) {
    const fileName = `eea-italy-${year}-tvv.json`;
    const remoteTable = downloadedTables.get(year);
    let rows;
    let origin;
    let source;
    let sourceUrl;
    let sourceDownloadedAt;

    if (remoteTable) {
      rows = remoteRows.get(year);
      origin = 'downloaded_from_annual_final_table';
      source = `European Environment Agency - ${remoteTable}`;
      sourceUrl = 'https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b';
      sourceDownloadedAt = new Date().toISOString();
    } else {
      const rawPath = path.join(rawDir, fileName);
      const rawPayload = JSON.parse(await fs.readFile(rawPath, 'utf8'));
      rows = rawPayload.rows.filter(
        (row) => String(row.status ?? '').trim().toUpperCase() === 'F',
      );
      origin = 'filtered_from_preserved_raw_snapshot';
      source = rawPayload.source ?? null;
      sourceUrl = rawPayload.source_url ?? null;
      sourceDownloadedAt = rawPayload.downloaded_at ?? null;
    }

    validateRows(rows, year);
    const document = {
      schema_version: 1,
      source,
      source_url: sourceUrl,
      country: 'IT',
      year,
      status: 'F',
      quality: 'final',
      origin,
      source_downloaded_at: sourceDownloadedAt,
      canonicalized_at: new Date().toISOString(),
      rows,
    };
    const outputPath = path.join(canonicalDir, fileName);
    await fs.writeFile(outputPath, `${JSON.stringify(document)}\n`, 'utf8');

    prepared.push({
      year,
      status: 'F',
      quality: 'final',
      origin,
      source,
      source_url: sourceUrl,
      source_downloaded_at: sourceDownloadedAt,
      file: fileName,
      rows: rows.length,
      registrations: rows.reduce(
        (sum, row) => sum + Math.max(0, Number(row.registrations_count) || 0),
        0,
      ),
      data_sha256: dataHash(rows),
    });
  }

  const manifest = {
    schema_version: 1,
    generated_at: new Date().toISOString(),
    source: 'EEA CO2 monitoring data for cars, final annual editions',
    country: 'IT',
    first_year: firstYear,
    last_year: lastYear,
    policy: 'Una sola edizione finale F per paese e anno.',
    files: prepared,
    totals: {
      years: prepared.length,
      final_years: prepared.filter((item) => item.status === 'F').length,
      rows: prepared.reduce((sum, item) => sum + item.rows, 0),
      registrations: prepared.reduce((sum, item) => sum + item.registrations, 0),
    },
  };
  await fs.writeFile(manifestPath, `${JSON.stringify(manifest, null, 2)}\n`, 'utf8');

  console.log('');
  console.log(JSON.stringify({
    ...manifest.totals,
    remote_final_years: [...downloadedTables.keys()],
    full_refresh: downloadAll,
    output_directory: canonicalDir,
    manifest: manifestPath,
    verification: prepared.length === 15
      && prepared.every((item) => item.status === 'F' && item.rows > 0)
      ? 'ok'
      : 'failed',
  }, null, 2));
}

main().catch((error) => {
  console.error('');
  console.error(`Preparazione interrotta: ${error.message}`);
  process.exitCode = 1;
});
