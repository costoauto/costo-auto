import crypto from 'node:crypto';
import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const cacheDir = path.join(scriptDir, '.cache', 'adac-phev');
const matchPath = path.join(scriptDir, 'adac-phev-model-matches.json');
const apiCatalogPath = path.join(scriptDir, 'phev-api-catalog.json');
const outputPath = path.join(scriptDir, 'adac-phev-system-power.json');
const sqlDataPath = path.join(scriptDir, 'adac-phev-system-power.sql');
const sourceLabel = 'ADAC Autokatalog, schede tecniche pubbliche';

await fs.mkdir(cacheDir, { recursive: true });

const matches = JSON.parse(await fs.readFile(matchPath, 'utf8'));
const apiCatalog = JSON.parse(await fs.readFile(apiCatalogPath, 'utf8'));
const apiItems = apiCatalog.items.filter(
  (item) => item.hybrid_type === 'plug_in_hybrid',
);

function cachePath(url) {
  const hash = crypto.createHash('sha256').update(url).digest('hex');
  return path.join(cacheDir, `${hash}.html`);
}

function wait(milliseconds) {
  return new Promise((resolve) => setTimeout(resolve, milliseconds));
}

async function fetchText(url) {
  const target = cachePath(url);

  try {
    return await fs.readFile(target, 'utf8');
  } catch {
    // Il file non è ancora in cache.
  }

  let lastError;
  for (let attempt = 1; attempt <= 4; attempt += 1) {
    try {
      const response = await fetch(url, {
        headers: {
          'User-Agent': 'CostoAuto public-data audit/1.0',
          Accept: 'text/html,application/xhtml+xml',
        },
      });

      if (!response.ok) {
        throw new Error(`HTTP ${response.status}`);
      }

      const html = await response.text();
      await fs.writeFile(target, html, 'utf8');
      return html;
    } catch (error) {
      lastError = error;
      await wait(400 * attempt);
    }
  }

  throw new Error(`Download fallito per ${url}: ${lastError?.message}`);
}

async function mapLimit(items, concurrency, mapper) {
  const results = new Array(items.length);
  let nextIndex = 0;

  async function worker() {
    while (nextIndex < items.length) {
      const index = nextIndex;
      nextIndex += 1;
      results[index] = await mapper(items[index], index);
    }
  }

  await Promise.all(
    Array.from(
      { length: Math.min(concurrency, items.length) },
      () => worker(),
    ),
  );

  return results;
}

function decodeHtml(value) {
  return String(value || '')
    .replace(/<script\b[\s\S]*?<\/script>/gi, ' ')
    .replace(/<style\b[\s\S]*?<\/style>/gi, ' ')
    .replace(/<[^>]+>/g, ' ')
    .replace(/&nbsp;|&#160;/gi, ' ')
    .replace(/&amp;/gi, '&')
    .replace(/&quot;/gi, '"')
    .replace(/&apos;|&#39;|&#x27;/gi, "'")
    .replace(/&auml;/gi, 'ä')
    .replace(/&ouml;/gi, 'ö')
    .replace(/&uuml;/gi, 'ü')
    .replace(/&szlig;/gi, 'ß')
    .replace(/&#x([0-9a-f]+);/gi, (_, hex) =>
      String.fromCodePoint(Number.parseInt(hex, 16)))
    .replace(/&#([0-9]+);/g, (_, decimal) =>
      String.fromCodePoint(Number.parseInt(decimal, 10)))
    .replace(/\s+/g, ' ')
    .trim();
}

function cell(row, heading) {
  const pattern = new RegExp(
    `<td[^>]*data-th="${heading}"[^>]*>([\\s\\S]*?)<\\/td>`,
    'i',
  );
  return decodeHtml(row.match(pattern)?.[1] || '');
}

function numberBefore(text, unit) {
  const match = String(text).match(
    new RegExp(`(\\d+(?:[.,]\\d+)?)\\s*${unit}`, 'i'),
  );
  return match ? Number(match[1].replace(',', '.')) : null;
}

function parseDateRange(text) {
  const match = String(text).match(
    /\((\d{2})\/(\d{2})\s*-\s*(?:(\d{2})\/(\d{2})|heute)\)/i,
  );

  if (match) {
    return {
      start_month: Number(match[1]),
      year_from: 2000 + Number(match[2]),
      end_month: match[3] ? Number(match[3]) : 12,
      year_to: match[4] ? 2000 + Number(match[4]) : 2099,
    };
  }

  const openEnded = String(text).match(
    /\((?:ab\s+)?(\d{2})\/(\d{2})\)/i,
  );
  if (openEnded) {
    return {
      start_month: Number(openEnded[1]),
      year_from: 2000 + Number(openEnded[2]),
      end_month: 12,
      year_to: 2099,
    };
  }

  return {
    start_month: null,
    year_from: null,
    end_month: null,
    year_to: null,
  };
}

function parseGenerationRows(html, modelMatch, generationUrl) {
  const rows = html.match(
    /<tr[^>]*data-testid="carpages:generation:model:row"[\s\S]*?<\/tr>/gi,
  ) || [];

  return rows.flatMap((row) => {
    const href = row.match(
      /href="(\/rund-ums-fahrzeug\/autokatalog\/marken-modelle\/[^"]+\/\d+\/)"/i,
    )?.[1];
    const title = cell(row, 'Fahrzeug');
    const fuel = cell(row, 'Kraftstoff');
    const power = cell(row, 'Leistung');
    const price = cell(row, 'Listenpreis');
    const phevFuel =
      /strom/i.test(fuel)
      && /(super|benzin|diesel)/i.test(fuel);
    const phevCommercialName =
      /(plug.?in|phev|e[- ]?hybrid|twin engine|recharge|4xe|dm-i|activehybrid|hybrid4|e-tense)/i
        .test(title)
      || (
        modelMatch.brand === 'BMW'
        && modelMatch.model === 'XM'
      );

    if (
      !href
      || (!phevFuel && !phevCommercialName)
    ) {
      return [];
    }

    const dates = parseDateRange(title);
    return [{
      brand: modelMatch.brand,
      model: modelMatch.model,
      brand_key: modelMatch.brand_key,
      model_id: modelMatch.model_id,
      generation_url: generationUrl,
      detail_url: new URL(href, 'https://www.adac.de').href,
      adac_title: title,
      adac_fuel: fuel,
      system_power_kw: numberBefore(power, 'kW'),
      system_power_cv: numberBefore(power, 'PS'),
      list_price_eur: numberBefore(
        price.replace(/\./g, '').replace(',', '.'),
        '€',
      ),
      ...dates,
    }];
  });
}

function parseDetail(html) {
  const text = decodeHtml(html);
  const systemKw = text.match(
    /Leistung maximal in kW \(Systemleistung\)\s*(\d+(?:[.,]\d+)?)/i,
  );
  const systemCv = text.match(
    /Leistung maximal in PS \(Systemleistung\)\s*(\d+(?:[.,]\d+)?)/i,
  );
  const thermal = text.match(
    /Leistung\s*\/\s*Drehmoment \(Verbrennungsmotor\)\s*(\d+(?:[.,]\d+)?)\s*kW\s*\((\d+(?:[.,]\d+)?)\s*PS\)/i,
  );

  return {
    detail_system_power_kw: systemKw
      ? Number(systemKw[1].replace(',', '.'))
      : null,
    detail_system_power_cv: systemCv
      ? Number(systemCv[1].replace(',', '.'))
      : null,
    thermal_power_kw: thermal
      ? Number(thermal[1].replace(',', '.'))
      : null,
    thermal_power_cv: thermal
      ? Number(thermal[2].replace(',', '.'))
      : null,
  };
}

const generationJobs = matches.items.flatMap((item) =>
  item.generation_urls.map((generationUrl) => ({
    item,
    generationUrl,
  })));

console.log(
  `Pagine generazione da analizzare: ${generationJobs.length}`,
);

const generationResults = await mapLimit(
  generationJobs,
  4,
  async ({ item, generationUrl }, index) => {
    const html = await fetchText(generationUrl);
    if ((index + 1) % 25 === 0 || index + 1 === generationJobs.length) {
      console.log(
        `Generazioni analizzate: ${index + 1}/${generationJobs.length}`,
      );
    }
    return parseGenerationRows(html, item, generationUrl);
  },
);

const rawRows = generationResults.flat();

function mechanicalGroupKey(row) {
  return [
    row.model_id,
    row.generation_url,
    row.year_from,
    row.year_to,
    row.system_power_kw,
    row.system_power_cv,
  ].join('|');
}

const representativeByGroup = new Map();
for (const row of rawRows) {
  const key = mechanicalGroupKey(row);
  const existing = representativeByGroup.get(key);
  if (
    !existing
    || (row.list_price_eur || Number.POSITIVE_INFINITY)
      < (existing.list_price_eur || Number.POSITIVE_INFINITY)
  ) {
    representativeByGroup.set(key, row);
  }
}

const uniqueDetailUrls = [
  ...new Set(
    [...representativeByGroup.values()].map((row) => row.detail_url),
  ),
];
console.log(
  `Schede plug-in trovate: ${rawRows.length}; `
  + `motorizzazioni rappresentative: ${uniqueDetailUrls.length}`,
);

const detailEntries = await mapLimit(
  uniqueDetailUrls,
  4,
  async (url, index) => {
    const html = await fetchText(url);
    if ((index + 1) % 25 === 0 || index + 1 === uniqueDetailUrls.length) {
      console.log(
        `Schede tecniche analizzate: ${index + 1}/${uniqueDetailUrls.length}`,
      );
    }
    return [url, parseDetail(html)];
  },
);
const detailByUrl = new Map(detailEntries);

const enrichedRows = rawRows.map((row) => {
  const representative = representativeByGroup.get(mechanicalGroupKey(row));
  const detail = detailByUrl.get(representative.detail_url);
  return {
    ...row,
    technical_source_url: representative.detail_url,
    system_power_kw:
      detail.detail_system_power_kw ?? row.system_power_kw,
    system_power_cv:
      detail.detail_system_power_cv ?? row.system_power_cv,
    thermal_power_kw: detail.thermal_power_kw,
    thermal_power_cv: detail.thermal_power_cv,
  };
});
const detailParseFailures = enrichedRows.filter((row) =>
  !row.system_power_cv || !row.thermal_power_cv);

function keyForDeduplication(row) {
  return [
    row.brand_key,
    row.model_id,
    row.year_from,
    row.year_to,
    row.system_power_kw,
    row.system_power_cv,
    row.thermal_power_kw,
    row.thermal_power_cv,
  ].join('|');
}

const grouped = new Map();
for (const row of enrichedRows) {
  if (
    !row.system_power_cv
    || !row.thermal_power_cv
    || !row.year_from
    || !row.year_to
  ) {
    continue;
  }

  const key = keyForDeduplication(row);
  const existing = grouped.get(key);
  if (!existing) {
    grouped.set(key, {
      ...row,
      source_urls: [row.technical_source_url],
      matching_adac_versions: 1,
    });
    continue;
  }

  existing.matching_adac_versions += 1;
  existing.list_price_eur = Math.min(
    existing.list_price_eur || Number.POSITIVE_INFINITY,
    row.list_price_eur || Number.POSITIVE_INFINITY,
  );
  if (!existing.source_urls.includes(row.technical_source_url)) {
    existing.source_urls.push(row.technical_source_url);
  }
}

const catalogRows = [...grouped.values()]
  .map((row) => ({
    brand: row.brand,
    model: row.model,
    brand_key: row.brand_key,
    model_id: row.model_id,
    year_from: row.year_from,
    year_to: row.year_to,
    system_power_kw: row.system_power_kw,
    system_power_cv: row.system_power_cv,
    thermal_power_kw: row.thermal_power_kw,
    thermal_power_cv: row.thermal_power_cv,
    list_price_eur: Number.isFinite(row.list_price_eur)
      ? row.list_price_eur
      : null,
    source_name: sourceLabel,
    source_url: row.source_urls[0],
    source_urls: row.source_urls,
    matching_adac_versions: row.matching_adac_versions,
    confidence: 'high',
  }))
  .sort((left, right) =>
    left.brand.localeCompare(right.brand, 'it')
    || left.model.localeCompare(right.model, 'it')
    || left.year_from - right.year_from
    || left.system_power_cv - right.system_power_cv);

function overlaps(apiItem, catalogRow) {
  const apiFrom = Number(apiItem.year_from ?? apiItem.display_year);
  const apiTo = Number(apiItem.year_to ?? apiItem.display_year);
  return apiFrom <= catalogRow.year_to && apiTo >= catalogRow.year_from;
}

function declaredPowerMatches(apiItem, catalogRow) {
  const apiKw = Number(apiItem.power_kw);
  const apiCv = Number(apiItem.power_cv);
  return (
    (Number.isFinite(apiKw)
      && (
        Math.abs(apiKw - catalogRow.thermal_power_kw) <= 2
        || Math.abs(apiKw - catalogRow.system_power_kw) <= 2
      ))
    || (Number.isFinite(apiCv)
      && (
        Math.abs(apiCv - catalogRow.thermal_power_cv) <= 3
        || Math.abs(apiCv - catalogRow.system_power_cv) <= 3
      ))
  );
}

const coverage = apiItems.map((apiItem) => {
  const overlapping = catalogRows.filter((row) =>
    row.model_id === apiItem.model_id
    && overlaps(apiItem, row));
  const exact = overlapping.filter((row) =>
    declaredPowerMatches(apiItem, row));
  const distinctPairs = new Set(
    overlapping.map((row) =>
      `${row.system_power_cv}|${row.thermal_power_cv}`),
  );
  const candidates = exact.length
    ? exact
    : (distinctPairs.size === 1 ? overlapping : []);

  return {
    vehicle_cluster_id: apiItem.vehicle_cluster_id,
    brand: apiItem.brand,
    model: apiItem.model,
    year_from: apiItem.year_from,
    year_to: apiItem.year_to,
    thermal_power_cv: apiItem.power_cv,
    system_powers_cv: [
      ...new Set(candidates.map((row) => row.system_power_cv)),
    ].sort((left, right) => left - right),
  };
});

const covered = coverage.filter((item) => item.system_powers_cv.length > 0);
const uncovered = coverage.filter((item) => item.system_powers_cv.length === 0);
const ambiguous = coverage.filter((item) => item.system_powers_cv.length > 1);

const output = {
  generated_at: new Date().toISOString(),
  source: sourceLabel,
  counts: {
    generation_pages: generationJobs.length,
    raw_phev_rows: rawRows.length,
    unique_detail_pages: uniqueDetailUrls.length,
    curated_power_rows: catalogRows.length,
    detail_parse_failures: detailParseFailures.length,
    api_phev_versions: apiItems.length,
    api_versions_covered: covered.length,
    api_versions_uncovered: uncovered.length,
    api_versions_with_multiple_system_powers: ambiguous.length,
  },
  rows: catalogRows,
  coverage: {
    uncovered,
    ambiguous,
    detail_parse_failures: detailParseFailures.slice(0, 100).map((row) => ({
      brand: row.brand,
      model: row.model,
      adac_title: row.adac_title,
      detail_url: row.technical_source_url,
      system_power_cv: row.system_power_cv,
      thermal_power_cv: row.thermal_power_cv,
    })),
  },
};

await fs.writeFile(outputPath, `${JSON.stringify(output, null, 2)}\n`, 'utf8');

function sqlText(value) {
  if (value === null || value === undefined) {
    return 'NULL';
  }
  return `'${String(value).replaceAll("'", "''")}'`;
}

const sqlValues = catalogRows.map((row) => `(
  ${sqlText(row.brand_key)},
  ${sqlText(row.model_id)},
  ${sqlText(row.brand)},
  ${sqlText(row.model)},
  ${row.year_from},
  ${row.year_to === 2099 ? 'NULL' : row.year_to},
  ${row.system_power_kw},
  ${row.system_power_cv},
  ${row.thermal_power_kw},
  ${row.thermal_power_cv},
  ${row.list_price_eur ?? 'NULL'},
  ${sqlText(row.source_name)},
  ${sqlText(row.source_url)},
  ${sqlText(row.confidence)}
)`).join(',\n');

await fs.writeFile(
  sqlDataPath,
  `-- Generato da scripts/build-adac-phev-system-power.mjs.\n`
  + `-- Non contiene HTML: solo dati tecnici fattuali e URL della fonte.\n`
  + `INSERT INTO mvp.phev_system_power_catalog_v1 (\n`
  + `  brand_key, model_catalog_id, brand, model,\n`
  + `  year_from, year_to, system_power_kw, system_power_cv,\n`
  + `  thermal_power_kw, thermal_power_cv, representative_list_price_eur,\n`
  + `  source_name, source_url, confidence\n`
  + `) VALUES\n${sqlValues};\n`,
  'utf8',
);

console.log(JSON.stringify(output.counts, null, 2));
if (uncovered.length) {
  console.log('Prime versioni API non coperte:');
  console.log(JSON.stringify(uncovered.slice(0, 20), null, 2));
}
console.log(`Creati:\n- ${outputPath}\n- ${sqlDataPath}`);
