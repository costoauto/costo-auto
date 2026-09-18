import fs from 'node:fs/promises';
import path from 'node:path';
import vm from 'node:vm';
import { fileURLToPath } from 'node:url';

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const repoDir = path.dirname(scriptDir);
const workspaceDir = path.dirname(repoDir);
const outputDir = path.join(workspaceDir, 'pipeline_review_output_v2');

const configContext = { window: {} };
vm.runInNewContext(
  await fs.readFile(path.join(repoDir, 'config.js'), 'utf8'),
  configContext,
);
const { supabaseUrl, publishableKey } = configContext.window.AutoTcoConfig;

const delay = (milliseconds) => new Promise((resolve) => {
  setTimeout(resolve, milliseconds);
});

async function rpc(name, parameters = {}, attempt = 1) {
  const response = await fetch(`${supabaseUrl}/rest/v1/rpc/${name}`, {
    method: 'POST',
    headers: {
      apikey: publishableKey,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(parameters),
    signal: AbortSignal.timeout(25000),
  });
  const payload = await response.json().catch(() => ({}));
  if (!response.ok) {
    const message = payload.message || payload.error || `HTTP ${response.status}`;
    if (attempt < 4 && (response.status >= 500 || /timeout|connection/i.test(message))) {
      await delay(400 * (2 ** attempt));
      return rpc(name, parameters, attempt + 1);
    }
    throw new Error(`${name}: ${message}`);
  }
  if (!payload || !Array.isArray(payload.items)) {
    throw new Error(`${name}: payload senza items`);
  }
  return payload.items;
}

async function mapLimit(values, limit, callback) {
  const output = new Array(values.length);
  let nextIndex = 0;
  async function worker() {
    while (nextIndex < values.length) {
      const index = nextIndex;
      nextIndex += 1;
      output[index] = await callback(values[index], index);
    }
  }
  await Promise.all(Array.from({ length: Math.min(limit, values.length) }, worker));
  return output;
}

function identityKey(item) {
  return [
    Number(item.seed_model_id),
    item.fuel_type,
    item.hybrid_type || 'none',
  ].join('|');
}

function powerMatches(left, right) {
  const a = Number(left.power_kw);
  const b = Number(right.power_kw ?? right.power_kw_min);
  const bMax = Number(right.power_kw_max ?? right.power_kw);
  if (![a, b, bMax].every(Number.isFinite)) return false;
  return a >= b - 3 && a <= bMax + 3;
}

function overlap(leftFrom, leftTo, rightFrom, rightTo) {
  return leftFrom <= rightTo && leftTo >= rightFrom;
}

function compactVersion(item) {
  return {
    brand: item.brand,
    model: item.model,
    version_label: item.version_label,
    seed_model_id: Number(item.seed_model_id),
    year_from: Number(item.year_from),
    year_to: Number(item.year_to),
    fuel_type: item.fuel_type,
    hybrid_type: item.hybrid_type || 'none',
    power_kw: Number(item.power_kw),
    power_cv: Number(item.power_cv),
    display_variant_id: item.display_variant_id,
    vehicle_cluster_id: item.vehicle_cluster_id,
    year_source: item.year_source ?? null,
    data_source: item.data_source ?? null,
  };
}

function tableRows(items, limit = 25) {
  return items.slice(0, limit).map((item) => {
    const version = item.version ?? item;
    const suggestion = (item.suggested_ranges ?? [])
      .map((range) => `${range.year_from}-${range.year_to}`)
      .join(', ');
    return `| ${version.brand} | ${version.model} | ${version.version_label ?? ''} | ${item.classification ?? ''} | ${suggestion} |`;
  }).join('\n') || '| - | - | - | - | - |';
}

const offline = process.argv.includes('--offline');
let brands;
let models;
let onlineVersions;
if (offline) {
  const previous = JSON.parse(await fs.readFile(
    path.join(outputDir, 'catalog-reconciliation.json'),
    'utf8',
  ));
  brands = Array.from({ length: previous.counts.brands });
  models = Array.from({ length: previous.counts.models });
  onlineVersions = previous.current_versions.map((item) => item.version);
  process.stdout.write('Uso lo snapshot pubblico dell audit precedente.\n');
} else {
  process.stdout.write('Lettura del catalogo pubblico...\n');
  brands = await rpc('auto_tco_brands');
  models = (await mapLimit(brands, 6, async (brand) => (
    (await rpc('auto_tco_models', { p_brand_key: brand.brand_key }))
  ))).flat();
  const versionGroups = await mapLimit(models, 6, async (model, index) => {
    if ((index + 1) % 75 === 0 || index + 1 === models.length) {
      process.stdout.write(`Modelli letti: ${index + 1}/${models.length}\n`);
    }
    const items = await rpc('auto_tco_versions', {
      p_model_id: model.model_catalog_id,
    });
    return items.map((item) => ({
      ...item,
      brand: item.brand ?? model.brand,
      model: item.model ?? model.model,
      seed_model_id: item.seed_model_id ?? model.seed_model_id,
    }));
  });
  onlineVersions = versionGroups.flat();
}

const canonicalProfiles = JSON.parse(await fs.readFile(
  path.join(workspaceDir, 'historical_catalog_output_v2', 'historical-versions.json'),
  'utf8',
)).filter((item) => item.publication_status === 'publishable');
const commercialObservations = JSON.parse(await fs.readFile(
  path.join(workspaceDir, 'historical_catalog_output_v2', 'commercial-observations.json'),
  'utf8',
));
const canonicalRanges = JSON.parse(await fs.readFile(
  path.join(workspaceDir, 'catalog_audit_output_v2', 'tvv-gap-continuity-proposed-ranges.json'),
  'utf8',
));

const profilesByIdentity = new Map();
for (const profile of canonicalProfiles) {
  const key = identityKey(profile);
  if (!profilesByIdentity.has(key)) profilesByIdentity.set(key, []);
  profilesByIdentity.get(key).push(profile);
}
const rangesByIdentity = new Map();
for (const range of canonicalRanges) {
  const key = identityKey(range);
  if (!rangesByIdentity.has(key)) rangesByIdentity.set(key, []);
  rangesByIdentity.get(key).push(range);
}
const observationsByIdentity = new Map();
for (const observation of commercialObservations) {
  const key = identityKey(observation);
  if (!observationsByIdentity.has(key)) observationsByIdentity.set(key, []);
  observationsByIdentity.get(key).push(observation);
}

const classified = onlineVersions.map((rawVersion) => {
  const version = compactVersion(rawVersion);
  const key = identityKey(version);
  const matchingRanges = (rangesByIdentity.get(key) ?? [])
    .filter((range) => powerMatches(version, range));
  const coveringRanges = matchingRanges.filter((range) => (
    range.year_from <= version.year_from && range.year_to >= version.year_to
  ));
  const overlappingRanges = matchingRanges.filter((range) => overlap(
    version.year_from,
    version.year_to,
    range.year_from,
    range.year_to,
  ));
  const annualProfiles = (profilesByIdentity.get(key) ?? [])
    .filter((profile) => powerMatches(version, profile));
  const observedYears = [...new Set(annualProfiles
    .map((profile) => Number(profile.year ?? profile.representative_year))
    .filter((year) => year >= version.year_from && year <= version.year_to))]
    .sort((a, b) => a - b);
  const rawObservedYears = [...new Set((observationsByIdentity.get(key) ?? [])
    .filter((observation) => powerMatches(version, observation))
    .map((observation) => Number(observation.year))
    .filter((year) => year >= version.year_from && year <= version.year_to))]
    .sort((a, b) => a - b);
  const curated = version.year_source === 'curated_commercial_catalog'
    || (
      Boolean(version.data_source)
      && !/^EEA CO2 monitoring/i.test(String(version.data_source))
    );

  let classification;
  if (curated) {
    classification = 'preserve_curated';
  } else if (version.year_to < 2010) {
    classification = 'outside_eea_scope';
  } else if (coveringRanges.length > 0) {
    classification = 'confirmed_by_tvv';
  } else if (version.year_to > version.year_from && overlappingRanges.length > 0) {
    classification = 'split_or_rebuild';
  } else if (observedYears.length > 0) {
    classification = 'partially_supported';
  } else if (rawObservedYears.length > 0) {
    classification = 'observed_below_publication_threshold';
  } else {
    classification = 'not_supported_by_canonical_eea';
  }

  return {
    classification,
    version,
    observed_years: observedYears,
    raw_observed_years: rawObservedYears,
    suggested_ranges: overlappingRanges.map((range) => ({
      range_id: range.range_id,
      year_from: range.year_from,
      year_to: range.year_to,
      display_power_cv: range.power_cv_representative,
      minimum_tvv_coverage: range.minimum_tvv_coverage,
    })),
  };
});

const currentKeys = new Map();
for (const version of onlineVersions) {
  const key = identityKey(version);
  if (!currentKeys.has(key)) currentKeys.set(key, []);
  currentKeys.get(key).push(version);
}
const newConfirmedRanges = canonicalRanges.filter((range) => !(
  currentKeys.get(identityKey(range)) ?? []
).some((version) => (
  powerMatches(version, range)
  && Number(version.year_from) === Number(range.year_from)
  && Number(version.year_to) === Number(range.year_to)
)));

const counts = Object.fromEntries(
  [...new Set(classified.map((item) => item.classification))].sort().map((classification) => [
    classification,
    classified.filter((item) => item.classification === classification).length,
  ]),
);
const result = {
  generated_at: new Date().toISOString(),
  source: `${supabaseUrl}/rest/v1/rpc/auto_tco_versions`,
  policy: {
    curated: 'preserve until separately superseded by documented commercial evidence',
    exact_tvv: 'eligible to remain published',
    approximate_or_missing: 'candidate only; never automatically published',
  },
  counts: {
    brands: brands.length,
    models: models.length,
    online_versions: onlineVersions.length,
    canonical_profiles: canonicalProfiles.length,
    canonical_commercial_observations: commercialObservations.length,
    canonical_ranges: canonicalRanges.length,
    new_confirmed_ranges: newConfirmedRanges.length,
    ...counts,
  },
  current_versions: classified,
  new_confirmed_ranges: newConfirmedRanges,
};

await fs.mkdir(outputDir, { recursive: true });
await fs.writeFile(
  path.join(outputDir, 'catalog-reconciliation.json'),
  `${JSON.stringify(result, null, 2)}\n`,
  'utf8',
);

const splitRows = classified
  .filter((item) => item.classification === 'split_or_rebuild')
  .sort((left, right) => (
    (right.version.year_to - right.version.year_from)
    - (left.version.year_to - left.version.year_from)
  ));
const unsupportedRows = classified.filter(
  (item) => item.classification === 'not_supported_by_canonical_eea',
);
const report = `# Riconciliazione catalogo online con pipeline EEA canonica

Generato: ${result.generated_at}

## Esito

- Versioni online: ${onlineVersions.length}
- Versioni curate da preservare: ${counts.preserve_curated ?? 0}
- Intervalli online confermati da continuita TVV ad alta affidabilita: ${counts.confirmed_by_tvv ?? 0}
- Intervalli da spezzare o ricostruire: ${counts.split_or_rebuild ?? 0}
- Versioni con supporto annuale soltanto parziale: ${counts.partially_supported ?? 0}
- Versioni osservate nei dati definitivi ma sotto le soglie di pubblicazione: ${counts.observed_below_publication_threshold ?? 0}
- Versioni nel periodo EEA senza riscontro canonico: ${counts.not_supported_by_canonical_eea ?? 0}
- Versioni antecedenti al 2010, fuori dallo scopo di questo audit: ${counts.outside_eea_scope ?? 0}
- Nuovi intervalli EEA confermati non identici a una riga online: ${newConfirmedRanges.length}

Le versioni senza riscontro non vengono dichiarate false in automatico: l'assenza dalle nuove immatricolazioni EEA non prova da sola l'inesistenza commerciale. Tuttavia non possono piu essere rigenerate o mantenute come certe dalla pipeline automatica; vanno preservate come curate se hanno una fonte commerciale, altrimenti messe in attesa del Passo 3.

## Intervalli online da spezzare o ricostruire

| Marca | Modello | Versione online | Classe | Intervalli tecnici suggeriti |
|---|---|---|---|---|
${tableRows(splitRows)}

## Versioni senza riscontro EEA canonico

| Marca | Modello | Versione online | Classe | Intervalli tecnici suggeriti |
|---|---|---|---|---|
${tableRows(unsupportedRows)}

Il dettaglio integrale, inclusi ID, anni osservati e copertura TVV, e in catalog-reconciliation.json. Nessuna modifica e stata applicata al database.
`;
await fs.writeFile(path.join(outputDir, 'catalog-reconciliation.md'), report, 'utf8');

console.log(JSON.stringify({ ...result.counts, verification: 'ok' }, null, 2));
