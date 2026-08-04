import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const cacheDir = path.join(scriptDir, '.cache');
const sitemapPath = path.join(cacheDir, 'adac-sitemap-autokatalog.xml');
const catalogPath = path.join(scriptDir, 'phev-api-catalog.json');
const outputPath = path.join(scriptDir, 'adac-phev-model-matches.json');
const sitemapUrl =
  'https://www.adac.de/sitemaps/sitemap-autokatalog.xml';

await fs.mkdir(cacheDir, { recursive: true });

async function ensureSitemap() {
  try {
    await fs.access(sitemapPath);
  } catch {
    const response = await fetch(sitemapUrl, {
      headers: {
        'User-Agent': 'CostoAuto data audit/1.0',
      },
    });

    if (!response.ok) {
      throw new Error(`Sitemap ADAC non disponibile: ${response.status}`);
    }

    await fs.writeFile(sitemapPath, await response.text(), 'utf8');
  }
}

function slugify(value) {
  return String(value || '')
    .normalize('NFD')
    .replace(/\p{Diacritic}/gu, '')
    .toLowerCase()
    .replace(/&/g, 'and')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-|-$/g, '');
}

function normalizeModel(value) {
  return slugify(value)
    .replace(/^([1-9])-series$/, '$1er-reihe')
    .replace(/^([a-z])-class$/, '$1-klasse')
    .replace(/^([a-z]{2,3})-class$/, '$1-klasse')
    .replace(/-series$/, '-reihe')
    .replace(/-class$/, '-klasse')
    .replace(/-crossback$/, '');
}

function levenshtein(left, right) {
  const previous = Array.from(
    { length: right.length + 1 },
    (_, index) => index,
  );

  for (let leftIndex = 1; leftIndex <= left.length; leftIndex += 1) {
    const current = [leftIndex];

    for (let rightIndex = 1; rightIndex <= right.length; rightIndex += 1) {
      const substitution =
        previous[rightIndex - 1]
        + (left[leftIndex - 1] === right[rightIndex - 1] ? 0 : 1);
      current[rightIndex] = Math.min(
        current[rightIndex - 1] + 1,
        previous[rightIndex] + 1,
        substitution,
      );
    }

    previous.splice(0, previous.length, ...current);
  }

  return previous[right.length];
}

function similarity(left, right) {
  if (left === right) {
    return 1;
  }

  if (
    Math.min(left.length, right.length) >= 4
    && (left.includes(right) || right.includes(left))
  ) {
    return 0.88;
  }

  return 1 - (
    levenshtein(left, right)
    / Math.max(left.length, right.length, 1)
  );
}

const brandAliases = new Map([
  ['volkswagen', 'vw'],
  ['ds', 'ds-automobiles'],
  ['mercedes-benz', 'mercedes-benz'],
  ['land-rover', 'land-rover'],
  ['alfa-romeo', 'alfa-romeo'],
  ['citroen', 'citroen'],
  ['skoda', 'skoda'],
]);

const modelAliases = new Map([
  ['mazda\u0000mazda-cx-60', 'cx-60'],
  ['mg\u0000ehs', 'hs-ehs'],
  ['mg\u0000hs', 'hs-ehs'],
  ['volvo\u0000s60', 's60-v60'],
  ['volvo\u0000v60', 's60-v60'],
  ['volvo\u0000s90', 's90-v90'],
  ['volvo\u0000v90', 's90-v90'],
  ['volkswagen\u0000california', 'transporter'],
  ['volkswagen\u0000multivan', 'transporter'],
]);

// Alcune voci ampie del catalogo EEA corrispondono a più famiglie
// commerciali ADAC. Le pagine aggiuntive vengono unite, non sostituite.
const additionalModelSlugs = new Map([
  ['bmw\u00002-series', ['2er-reihe-active-gran-tourer']],
]);

const volkswagenCommercialModels = new Set([
  'caddy',
  'california',
  'multivan',
]);

await ensureSitemap();

const [catalog, sitemap] = await Promise.all([
  fs.readFile(catalogPath, 'utf8').then(JSON.parse),
  fs.readFile(sitemapPath, 'utf8'),
]);

const sitemapUrls = Array.from(
  sitemap.matchAll(/<loc>(https:\/\/www\.adac\.de\/[^<]+)<\/loc>/g),
  (match) => match[1],
);

const adacModels = new Map();

for (const url of sitemapUrls) {
  const match = url.match(
    /\/marken-modelle\/([^/]+)\/([^/]+)\/([^/]+)\/\d+\/?$/,
  );

  if (!match) {
    continue;
  }

  const [, brandSlug, modelSlug, generationSlug] = match;
  const key = `${brandSlug}\u0000${modelSlug}`;
  const entry = adacModels.get(key) || {
    brand_slug: brandSlug,
    model_slug: modelSlug,
    generations: new Map(),
  };
  const generationUrl = url.replace(/\d+\/?$/, '');
  entry.generations.set(generationSlug, generationUrl);
  adacModels.set(key, entry);
}

const apiModels = Array.from(
  new Map(
    catalog.items.map((item) => [
      `${item.brand}\u0000${item.model}`,
      {
        brand: item.brand,
        model: item.model,
        brand_key: item.brand_key,
        model_id: item.model_id,
      },
    ]),
  ).values(),
);

const matches = apiModels.map((apiModel) => {
  const normalizedBrand = slugify(apiModel.brand);
  const rawModel = slugify(apiModel.model);
  const adacBrand =
    normalizedBrand === 'volkswagen'
      && volkswagenCommercialModels.has(rawModel)
      ? 'vw-nutzfahrzeuge'
      : brandAliases.get(normalizedBrand) || normalizedBrand;
  const normalizedModel = normalizeModel(apiModel.model);
  const expectedModel =
    modelAliases.get(`${normalizedBrand}\u0000${rawModel}`)
    || normalizedModel;

  const candidates = Array.from(adacModels.values())
    .filter((entry) => entry.brand_slug === adacBrand)
    .map((entry) => ({
      ...entry,
      score: similarity(
        expectedModel,
        normalizeModel(entry.model_slug),
      ),
    }))
    .sort((left, right) => (
      right.score - left.score
      || left.model_slug.localeCompare(right.model_slug)
    ));

  const best = candidates[0];
  const extraSlugs =
    additionalModelSlugs.get(`${normalizedBrand}\u0000${rawModel}`) || [];
  const extraEntries = extraSlugs
    .map((modelSlug) =>
      adacModels.get(`${adacBrand}\u0000${modelSlug}`))
    .filter(Boolean);
  const generationUrls = best
    ? [
      ...new Set([
        ...best.generations.values(),
        ...extraEntries.flatMap((entry) => [
          ...entry.generations.values(),
        ]),
      ]),
    ].sort()
    : [];

  return {
    ...apiModel,
    normalized_brand: normalizedBrand,
    normalized_model: normalizedModel,
    match_status:
      best?.score >= 0.82
        ? 'matched'
        : best?.score >= 0.65
          ? 'review'
          : 'missing',
    match_score: best?.score || 0,
    adac_brand_slug: best?.brand_slug || null,
    adac_model_slug: best?.model_slug || null,
    generation_urls: generationUrls,
    alternatives: candidates.slice(0, 3).map((candidate) => ({
      model_slug: candidate.model_slug,
      score: Number(candidate.score.toFixed(4)),
    })),
  };
});

const output = {
  generated_at: new Date().toISOString(),
  source: sitemapUrl,
  counts: {
    api_models: apiModels.length,
    matched: matches.filter((item) => item.match_status === 'matched').length,
    review: matches.filter((item) => item.match_status === 'review').length,
    missing: matches.filter((item) => item.match_status === 'missing').length,
    generation_pages: new Set(
      matches
        .filter((item) => item.match_status === 'matched')
        .flatMap((item) => item.generation_urls),
    ).size,
  },
  items: matches,
};

await fs.writeFile(
  outputPath,
  `${JSON.stringify(output, null, 2)}\n`,
  'utf8',
);

process.stdout.write(
  `Abbinamenti ADAC salvati: ${outputPath}\n`
  + `Automatici: ${output.counts.matched}; `
  + `da verificare: ${output.counts.review}; `
  + `mancanti: ${output.counts.missing}; `
  + `pagine generazione: ${output.counts.generation_pages}.\n`,
);
