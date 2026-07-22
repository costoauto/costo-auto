const elements = {
  brand: document.getElementById('brand'),
  model: document.getElementById('model'),
  version: document.getElementById('version'),
  km: document.getElementById('km'),
  kmValue: document.getElementById('kmValue'),
  years: document.getElementById('years'),
  yearsValue: document.getElementById('yearsValue'),
  region: document.getElementById('region'),
  result: document.getElementById('result'),
};

const state = {
  requestSequence: 0,
  calculationTimer: null,
};

const costDescriptions = Object.freeze({
  maintenance:
    'Stima di tagliandi, materiali di consumo e usura prevedibile basata su chilometri, età, alimentazione e potenza. Sono esclusi pneumatici e interventi straordinari.',
  depreciation:
    'Perdita di valore stimata confrontando il valore attuale con quello previsto alla fine del periodo.',
  fuelOrEnergy:
    'Costo stimato in base ai chilometri annui, al consumo della versione e al prezzo medio di carburante o energia.',
  tax:
    'Bollo stimato con le regole fiscali oggi disponibili; eventuali modifiche legislative future non sono prevedibili.',
  insurance:
    'Premio RC Auto medio dell’area selezionata; non è un preventivo personale.',
});

const brandNameOverrides = Object.freeze({
  ALFAROMEO: 'Alfa Romeo',
  ASTONMARTIN: 'Aston Martin',
  BMW: 'BMW',
  BYD: 'BYD',
  CITROEN: 'Citroën',
  DFSKSERES: 'DFSK / Seres',
  DR: 'DR',
  DS: 'DS',
  EMC: 'EMC',
  EVO: 'EVO',
  KGMSSANGYONG: 'KGM / SsangYong',
  LANDROVER: 'Land Rover',
  LYNKCO: 'Lynk & Co',
  MCLAREN: 'McLaren',
  MERCEDESBENZ: 'Mercedes-Benz',
  MG: 'MG',
  ROLLSROYCE: 'Rolls-Royce',
  SKODA: 'Škoda',
  SWM: 'SWM',
  XPENG: 'XPeng',
});

const modelNameOverrides = Object.freeze({
  FIAT500: '500',
  FIATDUCATO: 'Ducato',
  FIATDUCATOF: 'Ducato F',
  LYNKCO01: '01',
  LYNKCO02: '02',
  LYNKCO08: '08',
  G05KMCA6KMCA6: 'G05',
  TIGERG03F: 'G03F',
  CIRELLISPORTCOUPE: 'Cirelli Sport Coupé',
  MAZDA2: 'Mazda2',
  MAZDA3: 'Mazda3',
  MAZDA6E: 'Mazda6e',
});

const invalidModelKeys = new Set([
  'UNKNOWN',
  'UNK',
  'NA',
  'NULL',
  'NOTAVAILABLE',
  'GV80GENESISGV80',
]);

const stripBrandFromModel = new Set([
  'AUDI',
  'BYD',
  'DALLARA',
  'FIAT',
  'GEELY',
  'INEOS',
  'JAGUAR',
  'LEXUS',
  'MAHINDRA',
  'MAXUS',
  'MAZDA',
  'NISSAN',
  'SUZUKI',
  'TOYOTA',
]);

const modelTokenOverrides = Object.freeze({
  'BIFUEL': 'Bi-Fuel',
  'COUPE': 'Coupé',
  'DUAL-FUEL': 'Dual-Fuel',
  'E-MOTION': 'e-Motion',
  'E-TECH': 'E-Tech',
  'E-TRON': 'e-tron',
  'PLUGIN': 'Plug-in',
  'PLUG-IN': 'Plug-in',
});

const fuelLabels = Object.freeze({
  petrol: 'Benzina',
  diesel: 'Diesel',
  lpg: 'GPL',
  e85: 'E85',
  electric: 'Elettrica',
  hydrogen: 'Idrogeno',
  'petrol/electric': 'benzina',
  'diesel/electric': 'diesel',
});

function compactKey(value) {
  return String(value ?? '')
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toUpperCase()
    .replace(/[^A-Z0-9]/g, '');
}

function formatBrandName(value, brandKey = '') {
  const key = brandKey || compactKey(value);

  if (brandNameOverrides[key]) {
    return brandNameOverrides[key];
  }

  const text = String(value ?? '').trim();

  if (!text || text !== text.toUpperCase()) {
    return text;
  }

  return text
    .toLocaleLowerCase('it-IT')
    .replace(/(^|[\s/-])\p{L}/gu, (match) => match.toLocaleUpperCase('it-IT'));
}

function formatUppercaseModelToken(token) {
  if (modelTokenOverrides[token]) {
    return modelTokenOverrides[token];
  }

  if (/^\d+[A-Z]{4,}$/.test(token)) {
    const [, digits, letters] = token.match(/^(\d+)([A-Z]+)$/);
    return `${digits}${letters.charAt(0)}${letters.slice(1).toLocaleLowerCase('it-IT')}`;
  }

  if (/\d/.test(token) || token.length <= 3) {
    return token;
  }

  return `${token.charAt(0)}${token.slice(1).toLocaleLowerCase('it-IT')}`;
}

function formatModelCase(value) {
  const text = String(value ?? '')
    .replace(/[;,]+/g, ' ')
    .replace(/\s+/g, ' ')
    .replace(/'+$/g, '')
    .trim();

  return text
    .split(' ')
    .map((token) => {
      if (!token || token !== token.toUpperCase()) {
        return token;
      }

      return formatUppercaseModelToken(token);
    })
    .join(' ');
}

function removeLeadingBrand(model, brand, brandKey) {
  if (!stripBrandFromModel.has(brandKey)) {
    return model;
  }

  const escapedBrand = String(brand)
    .replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  const withoutBrand = model.replace(
    new RegExp(`^${escapedBrand}(?:\\s+|[-–—]+\\s*)`, 'i'),
    '',
  ).trim();

  return withoutBrand || model;
}

function formatModelName(value, brandValue = '', brandKeyValue = '') {
  const brandKey = brandKeyValue || compactKey(brandValue);
  const modelKey = compactKey(value);

  if (modelNameOverrides[modelKey]) {
    return modelNameOverrides[modelKey];
  }

  const brand = formatBrandName(brandValue, brandKey);
  return formatModelCase(removeLeadingBrand(String(value ?? ''), brand, brandKey));
}

function formatVehicleName(brandValue, modelValue) {
  const brandKey = compactKey(brandValue);
  const brand = formatBrandName(brandValue, brandKey);
  const model = formatModelName(modelValue, brand, brandKey);
  const rawModelKey = compactKey(modelValue);
  const formattedModelKey = compactKey(model);

  if (
    (rawModelKey === brandKey || rawModelKey.startsWith(brandKey))
    && formattedModelKey.startsWith(brandKey)
  ) {
    return model;
  }

  return `${brand} ${model}`.trim();
}

function formatVersionLabel(vehicle, showYear = true) {
  const representativeYear = Number(
    showYear ? vehicle.display_year : null,
  );
  const yearPrefix = Number.isInteger(representativeYear)
    && representativeYear >= 1900
    && representativeYear <= 2100
    ? `${representativeYear} · `
    : '';
  const powerCv = Number(vehicle.power_cv);
  const roundedCv = Number.isFinite(powerCv) ? Math.round(powerCv) : null;
  const fuel = vehicle.fuel_type;

  if (vehicle.hybrid_type === 'plug_in_hybrid') {
    const details = roundedCv
      ? `Plug-in ${fuelLabels[fuel] || ''} · ${roundedCv} CV termici`
      : `Plug-in ${fuelLabels[fuel] || ''}`.trim();
    return `${yearPrefix}${details}`;
  }

  if (vehicle.hybrid_type === 'hybrid') {
    const details = roundedCv
      ? `Ibrida ${fuelLabels[fuel] || ''} · ${roundedCv} CV termici`
      : `Ibrida ${fuelLabels[fuel] || ''}`.trim();
    return `${yearPrefix}${details}`;
  }

  const fuelLabel = fuelLabels[fuel];

  if (fuelLabel && roundedCv) {
    return `${yearPrefix}${fuelLabel} · ${roundedCv} CV`;
  }

  const fallback = vehicle.version_label || 'Versione';
  return /^\d{4}\s*·/.test(fallback)
    ? fallback
    : `${yearPrefix}${fallback}`;
}

function clearLoadingState() {
  elements.result.classList.remove('isUpdating');
}

function formatEuro(value) {
  if (value === null || value === undefined || Number.isNaN(Number(value))) {
    return 'Non disponibile';
  }

  return new Intl.NumberFormat('it-IT', {
    style: 'currency',
    currency: 'EUR',
    maximumFractionDigits: 0,
  }).format(Number(value));
}

function formatNumber(value) {
  return new Intl.NumberFormat('it-IT').format(Number(value));
}

function escapeHtml(value) {
  return String(value ?? '')
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#039;');
}

function replaceOptions(select, placeholder, items, mapItem) {
  const fragment = document.createDocumentFragment();
  const firstOption = document.createElement('option');
  firstOption.value = '';
  firstOption.textContent = placeholder;
  fragment.appendChild(firstOption);

  items.forEach((item) => {
    const mapped = mapItem(item);
    const option = document.createElement('option');
    option.value = String(mapped.value);
    option.textContent = mapped.label;
    fragment.appendChild(option);
  });

  select.replaceChildren(fragment);
  select.disabled = items.length === 0;
}

function resetSelect(select, message) {
  const option = document.createElement('option');
  option.value = '';
  option.textContent = message;
  select.replaceChildren(option);
  select.disabled = true;
}

function updateSliderLabels() {
  const km = Number(elements.km.value);
  const years = Number(elements.years.value);

  elements.kmValue.textContent = `${formatNumber(km)} km`;
  elements.yearsValue.textContent = years === 1 ? '1 anno' : `${years} anni`;
}

function renderEmptyState(
  title = 'Seleziona marca, modello e versione',
  message = 'La stima verrà calcolata automaticamente usando 15.000 km annui, 5 anni di possesso e l’area “Tutta Italia”.',
) {
  clearLoadingState();
  elements.result.setAttribute('aria-busy', 'false');
  elements.result.innerHTML = `
    <div class="emptyState">
      <div class="emptyIcon">€</div>
      <h2>${escapeHtml(title)}</h2>
      <p>${escapeHtml(message)}</p>
    </div>
  `;
}

function renderLoading() {
  elements.result.setAttribute('aria-busy', 'true');

  clearLoadingState();

  if (elements.result.querySelector('.resultHeader')) {
    const label = elements.result.querySelector('.totalLabel');

    if (label) {
      label.textContent = 'Aggiornamento della stima\u2026';
    }

    return;
  }

  elements.result.innerHTML = `
    <div class="stateMessage">
      <div class="loadingDot" aria-hidden="true"></div>
      <h2>Aggiornamento della stima</h2>
      <p>Stiamo calcolando i costi con i parametri selezionati.</p>
    </div>
  `;
}

function renderError(message) {
  clearLoadingState();
  elements.result.setAttribute('aria-busy', 'false');
  elements.result.innerHTML = `
    <div class="stateMessage">
      <h2>Non è stato possibile calcolare la stima</h2>
      <div class="errorNote">${escapeHtml(message)}</div>
    </div>
  `;
}

function createCostRow(name, description, value) {
  return `
    <div class="row">
      <div class="rowMain">
        <div class="rowName">${escapeHtml(name)}</div>
        <div class="rowDescription">${escapeHtml(description)}</div>
      </div>
      <div class="rowValue">${escapeHtml(formatEuro(value))}</div>
    </div>
  `;
}

function translateMissingComponent(component) {
  const labels = {
    depreciation: 'svalutazione',
    fuel_or_energy: 'carburante o energia',
    tax: 'bollo',
    insurance: 'assicurazione',
    maintenance: 'manutenzione',
  };

  return labels[component] || component;
}

function getDepreciationDescription(costs, quality) {
  if (costs.depreciation_eur === null || costs.depreciation_eur === undefined) {
    return 'Non disponibile: mancano riferimenti sufficientemente affidabili.';
  }

  if (quality.depreciation_price_method) {
    return 'Stima ricavata da veicoli comparabili della stessa marca o dello stesso modello.';
  }

  return 'Perdita di valore stimata usando i dati disponibili per questa versione.';
}

function formatEnergyUnitPrice(value, unit) {
  return `${new Intl.NumberFormat('it-IT', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 3,
  }).format(Number(value))} ${unit}`;
}

function getFuelOrEnergyDescription(payload, regionLabel) {
  const descriptions = payload.descriptions || {};
  const details = payload.calculation_details?.fuel_or_energy || {};
  const baseDescription = descriptions.fuel_or_energy
    || costDescriptions.fuelOrEnergy;
  const prices = [];

  if (details.thermal_price_eur !== null
      && details.thermal_price_eur !== undefined) {
    prices.push(
      `${formatEnergyUnitPrice(
        details.thermal_price_eur,
        details.thermal_price_unit || '€/l',
      )} · ${regionLabel}, media MIMIT ultimi 12 mesi`,
    );
  }

  if (details.electricity_price_eur_kwh !== null
      && details.electricity_price_eur_kwh !== undefined) {
    prices.push(
      `${formatEnergyUnitPrice(
        details.electricity_price_eur_kwh,
        '€/kWh',
      )} · Italia, riferimento domestico ARERA 2025`,
    );
  }

  if (prices.length === 0) {
    return baseDescription;
  }

  return `${baseDescription} Prezzo${prices.length > 1 ? 'i' : ''} utilizzat${prices.length > 1 ? 'i' : 'o'}: ${prices.join('; ')}.`;
}

function renderResult(payload) {
  const vehicle = payload.vehicle || {};
  const inputs = payload.inputs || {};
  const costs = payload.monthly_costs || {};
  const quality = payload.quality || {};
  const descriptions = payload.descriptions || {};
  const missing = quality.missing_required_components || [];
  const ready = quality.status === 'ready' && costs.total_monthly_eur !== null;
  const displayedTotal = ready
    ? costs.total_monthly_eur
    : costs.available_subtotal_eur;
  const regionLabel = elements.region.selectedOptions[0]?.textContent || '';
  const years = Number(inputs.ownership_years);
  const depreciationDescription = getDepreciationDescription(costs, quality);
  const fuelOrEnergyDescription = getFuelOrEnergyDescription(
    payload,
    regionLabel,
  );

  const note = ready
    ? 'La stima utilizza i dati disponibili per la versione selezionata. Non rappresenta un preventivo o un valore di rivendita garantito.'
    : `Subtotale parziale: mancano ${missing.map(translateMissingComponent).join(', ')}. Le componenti mancanti non sono state sostituite con valori inventati.`;

  clearLoadingState();
  elements.result.setAttribute('aria-busy', 'false');
  elements.result.innerHTML = `
    <div class="resultHeader">
      <div>
        <h2>${escapeHtml(formatVehicleName(vehicle.brand, vehicle.model))}</h2>
        <p>
          ${escapeHtml(formatVersionLabel(vehicle))} ·
          ${escapeHtml(formatNumber(inputs.annual_km))} km/anno ·
          ${escapeHtml(years === 1 ? '1 anno' : `${years} anni`)} ·
          ${escapeHtml(regionLabel)}
        </p>
      </div>

      <div class="totalBox${ready ? '' : ' isPartial'}">
        <div class="totalLabel">
          ${ready ? 'Costo mensile stimato' : 'Subtotale disponibile'}
        </div>
        <div class="total">${escapeHtml(formatEuro(displayedTotal))}</div>
      </div>
    </div>

    <div class="breakdown">
      ${createCostRow(
        'Svalutazione',
        depreciationDescription,
        costs.depreciation_eur,
      )}
      ${createCostRow(
        'Carburante / energia',
        fuelOrEnergyDescription,
        costs.fuel_or_energy_eur,
      )}
      ${createCostRow(
        'Bollo',
        descriptions.tax || costDescriptions.tax,
        costs.tax_eur,
      )}
      ${createCostRow(
        'Assicurazione',
        descriptions.insurance || costDescriptions.insurance,
        costs.insurance_eur,
      )}
      ${createCostRow(
        'Manutenzione',
        costDescriptions.maintenance,
        costs.maintenance_eur,
      )}
    </div>

    <div class="note">${escapeHtml(note)}</div>
  `;
}

async function loadBrands() {
  const brands = await window.AutoTcoApi.getBrands();
  replaceOptions(
    elements.brand,
    'Seleziona marca',
    brands,
    (item) => ({
      value: item.brand_key,
      label: formatBrandName(item.brand, item.brand_key),
    }),
  );
}

async function loadRegions() {
  const regions = await window.AutoTcoApi.getRegions();
  const fragment = document.createDocumentFragment();

  regions.forEach((region) => {
    const option = document.createElement('option');
    option.value = region.region_code;
    option.textContent = region.region_name;
    option.selected = region.region_code === 'italia';
    fragment.appendChild(option);
  });

  elements.region.replaceChildren(fragment);
  elements.region.disabled = false;
}

async function handleBrandChange() {
  state.requestSequence += 1;
  resetSelect(elements.model, 'Caricamento modelli…');
  resetSelect(elements.version, 'Prima seleziona un modello');

  if (!elements.brand.value) {
    resetSelect(elements.model, 'Prima seleziona una marca');
    renderEmptyState();
    return;
  }

  renderEmptyState(
    'Ora seleziona il modello',
    'Dopo il modello potrai scegliere la versione per anno, alimentazione e potenza.',
  );

  try {
    const models = await window.AutoTcoApi.getModels(elements.brand.value);
    const validModels = models.filter(
      (item) => !invalidModelKeys.has(compactKey(item.model_key || item.model)),
    );
    replaceOptions(
      elements.model,
      'Seleziona modello',
      validModels,
      (item) => ({
        value: item.model_catalog_id,
        label: formatModelName(item.model, item.brand, item.brand_key),
      }),
    );
  } catch (error) {
    resetSelect(elements.model, 'Modelli non disponibili');
    renderError(error.message);
  }
}

async function handleModelChange() {
  state.requestSequence += 1;
  resetSelect(elements.version, 'Caricamento versioni…');

  if (!elements.model.value) {
    resetSelect(elements.version, 'Prima seleziona un modello');
    renderEmptyState(
      'Ora seleziona il modello',
      'Dopo il modello potrai scegliere la versione per anno, alimentazione e potenza.',
    );
    return;
  }

  renderEmptyState(
    'Ora seleziona la versione',
    'Scegli la combinazione di anno, alimentazione e potenza.',
  );

  try {
    const versions = await window.AutoTcoApi.getVersions(elements.model.value);
    const showYears = versions.length > 0 && versions.every((item) => {
      const year = Number(item.display_year);
      return Number.isInteger(year) && year >= 1900 && year <= 2100;
    });

    replaceOptions(
      elements.version,
      'Seleziona versione',
      versions,
      (item) => ({
        value: item.vehicle_cluster_id,
        label: formatVersionLabel(item, showYears),
      }),
    );
  } catch (error) {
    resetSelect(elements.version, 'Versioni non disponibili');
    renderError(error.message);
  }
}

async function updateResult() {
  updateSliderLabels();

  if (!elements.version.value) {
    return;
  }

  const sequence = ++state.requestSequence;
  renderLoading();

  try {
    const payload = await window.AutoTcoApi.estimate({
      vehicleClusterId: elements.version.value,
      annualKm: Number(elements.km.value),
      ownershipYears: Number(elements.years.value),
      regionCode: elements.region.value || 'italia',
    });

    if (sequence === state.requestSequence) {
      renderResult(payload);
    }
  } catch (error) {
    if (sequence === state.requestSequence) {
      renderError(error.message);
    }
  }
}

function scheduleCalculation() {
  updateSliderLabels();
  window.clearTimeout(state.calculationTimer);
  state.calculationTimer = window.setTimeout(updateResult, 140);
}

async function initialize() {
  updateSliderLabels();
  renderEmptyState();

  try {
    await Promise.all([loadBrands(), loadRegions()]);
  } catch (error) {
    renderError(
      `Il sito non riesce a collegarsi al servizio dati. ${error.message}`,
    );
  }

  elements.brand.addEventListener('change', handleBrandChange);
  elements.model.addEventListener('change', handleModelChange);
  elements.version.addEventListener('change', updateResult);
  elements.km.addEventListener('input', scheduleCalculation);
  elements.years.addEventListener('input', scheduleCalculation);
  elements.region.addEventListener('change', updateResult);
}

document.addEventListener('DOMContentLoaded', initialize);
