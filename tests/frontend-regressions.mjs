import assert from 'node:assert/strict';
import fs from 'node:fs/promises';
import path from 'node:path';
import vm from 'node:vm';
import { fileURLToPath } from 'node:url';

const testDirectory = path.dirname(fileURLToPath(import.meta.url));
const repository = path.resolve(testDirectory, '..');
const apiSource = await fs.readFile(
  path.join(repository, 'app-api.js'),
  'utf8',
);
const scriptSource = await fs.readFile(
  path.join(repository, 'script.js'),
  'utf8',
);

function deferred() {
  let resolve;
  let reject;
  const promise = new Promise((resolvePromise, rejectPromise) => {
    resolve = resolvePromise;
    reject = rejectPromise;
  });
  return { promise, resolve, reject };
}

function extractFunction(source, name) {
  const expression = new RegExp(
    `(?:^|\\n)(?:async )?function ${name}\\(`,
  );
  const match = expression.exec(source);
  assert.ok(match, `Funzione ${name} non trovata`);
  const start = match.index + (match[0].startsWith('\n') ? 1 : 0);
  const rest = source.slice(start + 1);
  const next = rest.search(/\n(?:async )?function [A-Za-z0-9_]+\(/);
  return next < 0 ? source.slice(start) : source.slice(start, start + 1 + next);
}

function control(value = '') {
  return {
    value,
    hidden: false,
    disabled: false,
    textContent: '',
    setAttribute() {},
    focus() {},
  };
}

function validEstimate() {
  return {
    vehicle: { brand: 'Fiat', model: 'Panda' },
    monthly_costs: { total_monthly_eur: 300 },
    quality: { status: 'ready' },
  };
}

async function testApiContract() {
  const requests = [];
  const context = {
    window: {
      AutoTcoConfig: {
        supabaseUrl: 'https://example.invalid',
        publishableKey: 'public-test-key',
      },
    },
    fetch: async (url, options) => {
      requests.push({ url, options });
      return { ok: true, json: async () => validEstimate() };
    },
  };

  vm.runInNewContext(apiSource, context);
  const payload = await context.window.AutoTcoApi.estimate({
    modelCatalogId: 'curated:fiat:panda-2012',
    vehicleClusterId: 'profile:100',
    displayVariantId: 'profile:100',
    annualKm: 15000,
    ownershipYears: 5,
    regionCode: 'italia',
  });

  assert.equal(payload.quality.status, 'ready');
  assert.match(requests[0].url, /auto_tco_estimate_selection$/);
  assert.deepEqual(
    JSON.parse(requests[0].options.body),
    {
      p_model_catalog_id: 'curated:fiat:panda-2012',
      p_vehicle_cluster_id: 'profile:100',
      p_display_variant_id: 'profile:100',
      p_annual_km: 15000,
      p_ownership_years: 5,
      p_region_code: 'italia',
    },
  );
}

async function testBodyAbortIsNotSwallowed() {
  const abort = new Error('body aborted');
  abort.name = 'AbortError';
  const context = {
    window: {
      AutoTcoConfig: {
        supabaseUrl: 'https://example.invalid',
        publishableKey: 'public-test-key',
      },
    },
    fetch: async () => ({
      ok: true,
      json: async () => {
        throw abort;
      },
    }),
  };

  vm.runInNewContext(apiSource, context);
  await assert.rejects(
    context.window.AutoTcoApi.estimate({
      modelCatalogId: 'model',
      vehicleClusterId: 'profile:1',
      displayVariantId: 'profile:1',
      annualKm: 15000,
      ownershipYears: 5,
      regionCode: 'italia',
    }),
    (error) => error.name === 'AbortError',
  );
}

async function testMalformedResponsesAreRejected() {
  const context = {
    window: {
      AutoTcoConfig: {
        supabaseUrl: 'https://example.invalid',
        publishableKey: 'public-test-key',
      },
    },
    fetch: async () => ({ ok: true, json: async () => ({}) }),
  };

  vm.runInNewContext(apiSource, context);
  await assert.rejects(
    context.window.AutoTcoApi.getBrands(),
    /Risposta incompleta/,
  );
  await assert.rejects(
    context.window.AutoTcoApi.estimate({
      modelCatalogId: 'model',
      vehicleClusterId: 'profile:1',
      displayVariantId: 'profile:1',
      annualKm: 15000,
      ownershipYears: 5,
      regionCode: 'italia',
    }),
    /Calcolo incompleto/,
  );
}

async function testStaleBrandErrorCannotReplaceNewModels() {
  const first = deferred();
  const second = deferred();
  const third = deferred();
  let requestCount = 0;
  const events = [];
  const brand = control('brand-a');
  const controls = {
    brand,
    model: control(),
    version: control(),
  };
  const context = {
    state: {
      catalogRequestSequence: {
        primary: { models: 0, versions: 0 },
      },
      requestSequence: 0,
      results: { primary: null },
      versions: { primary: new Map() },
    },
    vehicleControls: { primary: controls },
    elements: {
      viewComparison: control(),
      addComparison: control(),
    },
    window: {
      AutoTcoApi: {
        getModels() {
          requestCount += 1;
          return [first.promise, second.promise, third.promise][
            requestCount - 1
          ];
        },
      },
    },
    invalidModelKeys: new Set(),
    compactKey: (value) => String(value),
    cancelPendingCalculation() {},
    resetSelect(select, label) {
      events.push(`reset:${label}`);
      select.textContent = label;
    },
    renderCurrentResults() {},
    renderError(message) {
      events.push(`error:${message}`);
    },
    replaceOptions(select, label, items) {
      events.push(`models:${items.map((item) => item.model).join(',')}`);
      select.textContent = label;
    },
    formatModelName: (model) => model,
  };

  vm.runInNewContext(
    extractFunction(scriptSource, 'handleBrandChange'),
    context,
  );

  const obsoleteRequest = vm.runInNewContext(
    "handleBrandChange('primary')",
    context,
  );
  brand.value = 'brand-b';
  const middleRequest = vm.runInNewContext(
    "handleBrandChange('primary')",
    context,
  );
  brand.value = 'brand-a';
  const currentRequest = vm.runInNewContext(
    "handleBrandChange('primary')",
    context,
  );
  third.resolve([
    {
      model: 'Modello A corrente',
      model_key: 'modello-a-corrente',
      model_catalog_id: 'current-model',
    },
  ]);
  await currentRequest;
  first.resolve([
    {
      model: 'Modello A vecchio',
      model_key: 'modello-a-vecchio',
      model_catalog_id: 'obsolete-model',
    },
  ]);
  await obsoleteRequest;
  second.reject(new Error('Errore vecchio'));
  await middleRequest;

  assert.ok(events.includes('models:Modello A corrente'));
  assert.ok(!events.includes('models:Modello A vecchio'));
  assert.ok(!events.includes('error:Errore vecchio'));
  assert.ok(!events.includes('reset:Modelli non disponibili'));
}

async function testStaleVersionErrorCannotReplaceNewVersions() {
  const first = deferred();
  const second = deferred();
  const third = deferred();
  let requestCount = 0;
  const events = [];
  const model = control('model-a');
  const controls = {
    brand: control('brand'),
    model,
    version: control(),
  };
  const context = {
    state: {
      catalogRequestSequence: {
        primary: { models: 0, versions: 0 },
      },
      requestSequence: 0,
      results: { primary: null },
      versions: { primary: new Map() },
    },
    vehicleControls: { primary: controls },
    elements: {
      viewComparison: control(),
      addComparison: control(),
    },
    window: {
      AutoTcoApi: {
        getVersions() {
          requestCount += 1;
          return [first.promise, second.promise, third.promise][
            requestCount - 1
          ];
        },
      },
    },
    cancelPendingCalculation() {},
    resetSelect(select, label) {
      events.push(`reset:${label}`);
      select.textContent = label;
    },
    renderCurrentResults() {},
    renderError(message) {
      events.push(`error:${message}`);
    },
    replaceOptions(select, label, items) {
      events.push(`versions:${items.length}`);
      select.textContent = label;
    },
    formatVersionLabel: () => 'Versione',
  };

  vm.runInNewContext(
    extractFunction(scriptSource, 'handleModelChange'),
    context,
  );

  const obsoleteRequest = vm.runInNewContext(
    "handleModelChange('primary')",
    context,
  );
  model.value = 'model-b';
  const middleRequest = vm.runInNewContext(
    "handleModelChange('primary')",
    context,
  );
  model.value = 'model-a';
  const currentRequest = vm.runInNewContext(
    "handleModelChange('primary')",
    context,
  );
  third.resolve([
    {
      model_catalog_id: 'model-a',
      vehicle_cluster_id: 'profile:3',
      display_variant_id: 'profile:3',
      year_from: 2025,
      year_to: 2025,
    },
  ]);
  await currentRequest;
  first.resolve([
    {
      model_catalog_id: 'model-a',
      vehicle_cluster_id: 'profile:1',
      display_variant_id: 'profile:1',
      year_from: 2020,
      year_to: 2020,
    },
  ]);
  await obsoleteRequest;
  second.reject(new Error('Errore versione vecchio'));
  await middleRequest;

  assert.ok(events.includes('versions:1'));
  assert.equal(context.state.versions.primary.has('profile:3'), true);
  assert.equal(context.state.versions.primary.has('profile:1'), false);
  assert.ok(!events.includes('error:Errore versione vecchio'));
  assert.ok(!events.includes('reset:Versioni non disponibili'));
}

function testClosingComparisonQueuesFreshCalculation() {
  const events = [];
  const context = {
    state: {
      requestSequence: 1,
      catalogRequestSequence: {
        comparison: { models: 4, versions: 7 },
      },
      calculationTimer: 123,
      calculationController: {
        abort() {
          events.push('abort');
        },
      },
      comparisonActive: true,
      results: { primary: {}, comparison: {} },
      versions: { comparison: new Map([['old', {}]]) },
    },
    elements: {
      version: control('profile:1'),
      comparisonVehicle: control(),
      addComparison: control(),
      brandCompare: control(),
      modelCompare: control(),
      versionCompare: control(),
    },
    window: {
      clearTimeout(id) {
        events.push(`clear:${id}`);
      },
      setTimeout(callback, delay) {
        events.push(`timer:${delay}`);
        return 999;
      },
    },
    updateSliderLabels() {},
    renderLoading() {
      events.push('loading');
    },
    updateResult() {},
    setComparisonModeUi() {},
    resetSelect() {},
    renderCurrentResults() {
      events.push('render');
    },
  };

  for (const name of [
    'cancelScheduledCalculation',
    'cancelActiveCalculation',
    'cancelPendingCalculation',
    'scheduleCalculation',
    'closeComparison',
  ]) {
    vm.runInNewContext(extractFunction(scriptSource, name), context);
  }

  vm.runInNewContext('closeComparison()', context);
  assert.ok(events.includes('timer:250'));
  assert.equal(context.state.calculationTimer, 999);
  assert.equal(context.state.catalogRequestSequence.comparison.models, 5);
  assert.equal(context.state.catalogRequestSequence.comparison.versions, 8);
  assert.equal(context.state.versions.comparison.size, 0);
  assert.ok(events.includes('loading'));
}

function testSelectedIdentityWinsOverCalculationProfile() {
  const context = {};
  vm.runInNewContext(
    extractFunction(scriptSource, 'applySelectedVersion'),
    context,
  );
  const selected = {
    model_catalog_id: 'grande-panda',
    display_variant_id: 'display-grande',
    vehicle_cluster_id: 'profile-grande',
    brand: 'Fiat',
    model: 'Grande Panda',
    version_label: '2026 · Benzina · 100 CV',
    year_from: 2026,
    year_to: 2026,
    display_year: 2026,
    fuel_type: 'petrol',
    hybrid_type: 'none',
    power_kw: 74,
    power_cv: 100,
  };
  const result = vm.runInNewContext(
    'applySelectedVersion(payload, selected)',
    {
      ...context,
      payload: {
        vehicle: { brand: 'Fiat', model: 'Panda', display_year: 2008 },
      },
      selected,
    },
  );

  assert.equal(result.vehicle.model, 'Grande Panda');
  assert.equal(result.vehicle.display_year, 2026);
  assert.equal(result.vehicle.vehicle_cluster_id, 'profile-grande');
}

await testApiContract();
await testBodyAbortIsNotSwallowed();
await testMalformedResponsesAreRejected();
await testStaleBrandErrorCannotReplaceNewModels();
await testStaleVersionErrorCannotReplaceNewVersions();
testClosingComparisonQueuesFreshCalculation();
testSelectedIdentityWinsOverCalculationProfile();

console.log('Frontend regressions: 7/7 ok');
