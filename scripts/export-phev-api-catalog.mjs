import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const projectDir = path.resolve(scriptDir, '..');
const configSource = await fs.readFile(
  path.join(projectDir, 'config.js'),
  'utf8',
);

const supabaseUrl = configSource.match(
  /supabaseUrl:\s*['"]([^'"]+)['"]/,
)?.[1];
const publishableKey = configSource.match(
  /publishableKey:\s*['"]([^'"]+)['"]/,
)?.[1];

if (!supabaseUrl || !publishableKey) {
  throw new Error('Configurazione Supabase pubblica non trovata.');
}

async function rpc(functionName, parameters = {}, attempt = 1) {
  const response = await fetch(
    `${supabaseUrl.replace(/\/$/, '')}/rest/v1/rpc/${functionName}`,
    {
      method: 'POST',
      headers: {
        apikey: publishableKey,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(parameters),
    },
  );

  const payload = await response.json().catch(() => ({}));

  if (!response.ok) {
    const message =
      payload.message || payload.error || String(response.status);
    const isTransient =
      response.status >= 500
      || /timeout|temporar|connection/i.test(message);

    if (isTransient && attempt < 4) {
      await new Promise((resolve) => {
        setTimeout(resolve, 500 * (2 ** (attempt - 1)));
      });
      return rpc(functionName, parameters, attempt + 1);
    }

    throw new Error(`${functionName}: ${message}`);
  }

  return payload;
}

async function mapLimit(values, limit, callback) {
  const results = new Array(values.length);
  let nextIndex = 0;

  async function worker() {
    while (nextIndex < values.length) {
      const index = nextIndex;
      nextIndex += 1;
      results[index] = await callback(values[index], index);
    }
  }

  await Promise.all(
    Array.from({ length: Math.min(limit, values.length) }, worker),
  );
  return results;
}

const brandsPayload = await rpc('auto_tco_brands');
const brands = Array.isArray(brandsPayload.items) ? brandsPayload.items : [];

const modelsByBrand = await mapLimit(brands, 6, async (brand) => {
  const brandKey = brand.brand_key || brand.value || brand.id;
  const payload = await rpc('auto_tco_models', {
    p_brand_key: brandKey,
  });

  return (payload.items || []).map((model) => ({
    ...model,
    brand_key: brandKey,
    brand_label:
      brand.brand || brand.brand_label || brand.label || brandKey,
  }));
});

const models = modelsByBrand.flat();
const versionsByModel = await mapLimit(models, 4, async (model, index) => {
  if ((index + 1) % 50 === 0 || index + 1 === models.length) {
    process.stdout.write(
      `Modelli letti: ${index + 1}/${models.length}\n`,
    );
  }

  const modelId =
    model.model_catalog_id || model.model_id || model.value || model.id;
  const payload = await rpc('auto_tco_versions', {
    p_model_id: modelId,
  });

  return (payload.items || [])
    .filter((version) => version.hybrid_type === 'plug_in_hybrid')
    .map((version) => ({
      brand_key: model.brand_key,
      brand:
        version.brand
        || model.brand
        || model.brand_label,
      model_id: modelId,
      model:
        version.model
        || model.model
        || model.model_label
        || model.label,
      ...version,
    }));
});

const phevVersions = versionsByModel
  .flat()
  .sort((left, right) => (
    String(left.brand).localeCompare(String(right.brand), 'it')
    || String(left.model).localeCompare(String(right.model), 'it')
    || Number(right.year_to || 0) - Number(left.year_to || 0)
    || Number(left.power_cv || 0) - Number(right.power_cv || 0)
  ));

const output = {
  generated_at: new Date().toISOString(),
  source: `${supabaseUrl}/rest/v1/rpc/auto_tco_versions`,
  counts: {
    brands: brands.length,
    models: models.length,
    phev_versions: phevVersions.length,
    phev_models: new Set(
      phevVersions.map((item) => `${item.brand}\u0000${item.model}`),
    ).size,
  },
  items: phevVersions,
};

const outputPath = path.join(scriptDir, 'phev-api-catalog.json');
await fs.writeFile(
  outputPath,
  `${JSON.stringify(output, null, 2)}\n`,
  'utf8',
);

process.stdout.write(
  `Catalogo PHEV salvato: ${outputPath}\n`
  + `Versioni: ${output.counts.phev_versions}; `
  + `modelli: ${output.counts.phev_models}.\n`,
);
