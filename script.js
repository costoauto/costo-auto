const elements = {
  brand: document.getElementById('brand'),
  model: document.getElementById('model'),
  version: document.getElementById('version'),
  vehicleTitle: document.getElementById('vehicleTitle'),
  primaryVehicleSummary: document.getElementById('primaryVehicleSummary'),
  primaryVehicleFields: document.getElementById('primaryVehicleFields'),
  togglePrimaryEdit: document.getElementById('togglePrimaryEdit'),
  primarySummaryName: document.getElementById('primarySummaryName'),
  primarySummaryVersion: document.getElementById('primarySummaryVersion'),
  addComparison: document.getElementById('addComparison'),
  comparisonVehicle: document.getElementById('comparisonVehicle'),
  removeComparison: document.getElementById('removeComparison'),
  brandCompare: document.getElementById('brandCompare'),
  modelCompare: document.getElementById('modelCompare'),
  versionCompare: document.getElementById('versionCompare'),
  viewComparison: document.getElementById('viewComparison'),
  usageTitle: document.getElementById('usageTitle'),
  usageComparisonHint: document.getElementById('usageComparisonHint'),
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
  comparisonActive: false,
  versions: {
    primary: new Map(),
    comparison: new Map(),
  },
  results: {
    primary: null,
    comparison: null,
  },
};

const vehicleControls = {
  primary: {
    brand: elements.brand,
    model: elements.model,
    version: elements.version,
  },
  comparison: {
    brand: elements.brandCompare,
    model: elements.modelCompare,
    version: elements.versionCompare,
  },
};

const costDescriptions = Object.freeze({
  maintenance:
    'Stima di tagliandi, materiali di consumo e usura prevedibile. Sono esclusi pneumatici, revisione, incidenti, batteria di trazione e guasti straordinari non prevedibili.',
  depreciation:
    'Perdita di valore stimata confrontando il valore attuale con quello previsto alla fine del periodo.',
  fuelOrEnergy:
    'Costo stimato in base ai chilometri annui, al consumo della versione e al prezzo medio di carburante o energia.',
  tax:
    'Bollo stimato con le regole fiscali oggi disponibili; eventuali modifiche legislative future non sono prevedibili.',
  insurance:
    'Media dei premi RC Auto effettivamente pagati nell’area selezionata; non è un preventivo personale né una stima specifica del modello.',
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
  ng: 'Metano',
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

function formatCommercialVariant(value) {
  const normalized = String(value ?? '')
    .trim()
    .toLowerCase()
    .replace(/\s+/g, ' ');

  if (!normalized) {
    return '';
  }

  if (/\b4x40\b/.test(normalized)) {
    return '4x40';
  }

  const isCross = /\bcross\b/.test(normalized);
  const isFourByFour = /\b4x4\b/.test(normalized);
  const isFourByTwo = /\b4x2\b/.test(normalized);

  if (isCross && isFourByFour) {
    return 'Cross 4x4';
  }

  if (isCross && isFourByTwo) {
    return 'Cross 4x2';
  }

  if (isCross) {
    return 'Cross';
  }

  if (isFourByFour) {
    return '4x4';
  }

  if (isFourByTwo) {
    return '4x2';
  }

  return '';
}

function formatVersionLabel(vehicle, showYear = true) {
  const yearFrom = Number(
    showYear ? (vehicle.year_from ?? vehicle.display_year) : null,
  );
  const yearTo = Number(
    showYear ? (vehicle.year_to ?? vehicle.display_year) : null,
  );
  const hasValidRange = Number.isInteger(yearFrom)
    && Number.isInteger(yearTo)
    && yearFrom >= 1900
    && yearTo <= 2100
    && yearFrom <= yearTo;
  const yearLabel = hasValidRange
    ? (yearFrom === yearTo ? `${yearFrom}` : `${yearFrom}-${yearTo}`)
    : '';
  const yearPrefix = yearLabel ? `${yearLabel} · ` : '';
  const powerCv = Number(vehicle.power_cv);
  const roundedCv = Number.isFinite(powerCv) ? Math.round(powerCv) : null;
  const systemPowerCv = Number(vehicle.system_power_cv);
  const roundedSystemCv = Number.isFinite(systemPowerCv)
    ? Math.round(systemPowerCv)
    : null;
  const thermalPowerCv = Number(vehicle.thermal_power_cv);
  const roundedThermalCv = Number.isFinite(thermalPowerCv)
    ? Math.round(thermalPowerCv)
    : null;
  const fuel = vehicle.fuel_type;
  const commercialVariant = formatCommercialVariant(vehicle.commercial_name);
  const withCommercialVariant = (label) => (
    commercialVariant ? `${label} · ${commercialVariant}` : label
  );

  if (vehicle.hybrid_type === 'plug_in_hybrid') {
    let powerLabel = '';
    if (roundedSystemCv && roundedThermalCv) {
      powerLabel =
        `${roundedSystemCv} CV (${roundedThermalCv} CV termici)`;
    } else if (roundedSystemCv) {
      powerLabel = `${roundedSystemCv} CV`;
    } else if (roundedCv) {
      // Il dato EEA non ha semantica uniforme per tutte le PHEV:
      // senza una fonte verificata non lo definiamo "termico".
      powerLabel = `${roundedCv} CV`;
    }

    const details = [
      `Plug-in ${fuelLabels[fuel] || ''}`.trim(),
      powerLabel,
    ].filter(Boolean).join(' · ');
    return withCommercialVariant(`${yearPrefix}${details}`);
  }

  if (vehicle.hybrid_type === 'hybrid') {
    const details = roundedCv
      ? `Ibrida ${fuelLabels[fuel] || ''} · ${roundedCv} CV termici`
      : `Ibrida ${fuelLabels[fuel] || ''}`.trim();
    return withCommercialVariant(`${yearPrefix}${details}`);
  }

  const fuelLabel = fuelLabels[fuel];

  if (fuelLabel && roundedCv) {
    return withCommercialVariant(
      `${yearPrefix}${fuelLabel} · ${roundedCv} CV`,
    );
  }

  const fallback = vehicle.version_label || 'Versione';
  const fallbackWithYear = /^\d{4}(?:-\d{4})?\s*·/.test(fallback)
    ? fallback
    : `${yearPrefix}${fallback}`;
  return withCommercialVariant(fallbackWithYear);
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

function renderEmptyState() {
  clearLoadingState();
  elements.result.setAttribute('aria-busy', 'false');
  elements.result.replaceChildren();
}

function renderLoading() {
  elements.result.setAttribute('aria-busy', 'true');

  clearLoadingState();

  if (
    elements.result.querySelector('.resultHeader')
    || elements.result.querySelector('.comparisonHeader')
  ) {
    elements.result.classList.add('isUpdating');
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

function getInsuranceDescription(payload, regionLabel) {
  const descriptions = payload.descriptions || {};
  const details = payload.calculation_details?.insurance || {};
  const baseDescription = descriptions.insurance
    || costDescriptions.insurance;

  if (details.annual_average_premium_eur === null
      || details.annual_average_premium_eur === undefined) {
    return baseDescription;
  }

  const reference = [
    `${formatEuro(details.annual_average_premium_eur)}/anno`,
    details.area_name || regionLabel,
    details.reference_period_label,
    details.source_name || 'IVASS',
  ].filter(Boolean);

  return `${baseDescription} Riferimento utilizzato: ${reference.join(' · ')}.`;
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
  const insuranceDescription = getInsuranceDescription(
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
        'RC Auto media',
        insuranceDescription,
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

function getDisplayedTotal(payload) {
  const costs = payload.monthly_costs || {};
  const ready = payload.quality?.status === 'ready'
    && costs.total_monthly_eur !== null;

  return {
    ready,
    value: ready ? costs.total_monthly_eur : costs.available_subtotal_eur,
  };
}

function createComparisonTotal(payload, label, isBest) {
  const vehicle = payload.vehicle || {};
  const total = getDisplayedTotal(payload);

  return `
    <div class="comparisonTotal${isBest ? ' isBest' : ''}">
      <div class="comparisonBadgeSlot">
        ${isBest ? '<div class="comparisonBestBadge">Più conveniente</div>' : ''}
      </div>
      <div class="comparisonCarLabel">${escapeHtml(label)}</div>
      <div class="comparisonCarName">
        ${escapeHtml(formatVehicleName(vehicle.brand, vehicle.model))}
      </div>
      <div class="comparisonCarVersion">
        ${escapeHtml(formatVersionLabel(vehicle))}
      </div>
      <div class="comparisonCarTotal">${escapeHtml(formatEuro(total.value))}</div>
      <div class="comparisonCarUnit">
        ${total.ready ? 'al mese' : 'subtotale mensile'}
      </div>
    </div>
  `;
}

function createComparisonRow(name, firstValue, secondValue) {
  return `
    <div class="comparisonBreakdownRow">
      <div class="comparisonBreakdownName">${escapeHtml(name)}</div>
      <div class="comparisonBreakdownValue">${escapeHtml(formatEuro(firstValue))}</div>
      <div class="comparisonBreakdownValue">${escapeHtml(formatEuro(secondValue))}</div>
    </div>
  `;
}

function renderComparison(firstPayload, secondPayload) {
  const firstTotal = getDisplayedTotal(firstPayload);
  const secondTotal = getDisplayedTotal(secondPayload);
  const firstVehicle = firstPayload.vehicle || {};
  const secondVehicle = secondPayload.vehicle || {};
  const firstCosts = firstPayload.monthly_costs || {};
  const secondCosts = secondPayload.monthly_costs || {};
  const years = Number(firstPayload.inputs?.ownership_years || elements.years.value);
  const bothReady = firstTotal.ready && secondTotal.ready;
  const difference = bothReady
    ? Math.abs(Number(firstTotal.value) - Number(secondTotal.value))
    : null;
  const sameCost = bothReady && difference < 0.5;
  const firstIsBest = bothReady
    && !sameCost
    && Number(firstTotal.value) < Number(secondTotal.value);
  const secondIsBest = bothReady
    && !sameCost
    && Number(secondTotal.value) < Number(firstTotal.value);
  const bestVehicle = firstIsBest ? firstVehicle : secondVehicle;
  const bestLabel = firstIsBest ? 'Auto 1' : 'Auto 2';
  const savingPeriod = difference === null ? null : difference * 12 * years;
  const savingMessage = !bothReady
    ? 'Il confronto è parziale perché per almeno una delle auto mancano alcune componenti.'
    : sameCost
      ? 'Le due auto hanno un costo mensile stimato sostanzialmente equivalente.'
      : `${bestLabel} · ${formatVehicleName(bestVehicle.brand, bestVehicle.model)} costa circa ${formatEuro(difference)} in meno al mese, pari a ${formatEuro(savingPeriod)} in ${years === 1 ? '1 anno' : `${years} anni`}.`;
  const regionLabel = elements.region.selectedOptions[0]?.textContent || '';

  clearLoadingState();
  elements.viewComparison.hidden = false;
  elements.result.setAttribute('aria-busy', 'false');
  elements.result.innerHTML = `
    <div class="comparisonHeader">
      <h2>Confronto dei costi</h2>
      <p>
        ${escapeHtml(formatNumber(elements.km.value))} km/anno ·
        ${escapeHtml(years === 1 ? '1 anno' : `${years} anni`)} ·
        ${escapeHtml(regionLabel)}
      </p>
    </div>

    <div class="comparisonTotals">
      ${createComparisonTotal(firstPayload, 'Auto 1', firstIsBest)}
      ${createComparisonTotal(secondPayload, 'Auto 2', secondIsBest)}
    </div>

    <div class="comparisonSaving">${escapeHtml(savingMessage)}</div>

    <div class="comparisonBreakdown">
      <div class="comparisonBreakdownHeader" aria-hidden="true">
        <span>Voce mensile</span>
        <span>Auto 1</span>
        <span>Auto 2</span>
      </div>
      ${createComparisonRow(
        'Svalutazione',
        firstCosts.depreciation_eur,
        secondCosts.depreciation_eur,
      )}
      ${createComparisonRow(
        'Carburante / energia',
        firstCosts.fuel_or_energy_eur,
        secondCosts.fuel_or_energy_eur,
      )}
      ${createComparisonRow('Bollo', firstCosts.tax_eur, secondCosts.tax_eur)}
      ${createComparisonRow(
        'RC Auto media',
        firstCosts.insurance_eur,
        secondCosts.insurance_eur,
      )}
      ${createComparisonRow(
        'Manutenzione',
        firstCosts.maintenance_eur,
        secondCosts.maintenance_eur,
      )}
    </div>

    <div class="note">
      Le stime non rappresentano preventivi o valori di rivendita garantiti.
    </div>
  `;
}

async function loadBrands() {
  const brands = await window.AutoTcoApi.getBrands();
  [elements.brand, elements.brandCompare].forEach((select) => {
    replaceOptions(
      select,
      'Seleziona marca',
      brands,
      (item) => ({
        value: item.brand_key,
        label: formatBrandName(item.brand, item.brand_key),
      }),
    );
  });
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

function updatePrimarySummary(payload = state.results.primary) {
  const vehicle = payload?.vehicle;

  if (vehicle) {
    elements.primarySummaryName.textContent = formatVehicleName(
      vehicle.brand,
      vehicle.model,
    );
    elements.primarySummaryVersion.textContent = formatVersionLabel(vehicle);
    return;
  }

  const brand = elements.brand.selectedOptions[0]?.textContent || '';
  const model = elements.model.selectedOptions[0]?.textContent || '';
  const version = elements.version.selectedOptions[0]?.textContent || '';

  elements.primarySummaryName.textContent = `${brand} ${model}`.trim();
  elements.primarySummaryVersion.textContent = version;
}

function getSelectedVersion(slot) {
  const selectedId = vehicleControls[slot].version.value;
  return state.versions[slot].get(selectedId) || null;
}

function applySelectedVersion(payload, selectedVersion) {
  if (!payload || !selectedVersion) {
    return payload;
  }

  return {
    ...payload,
    vehicle: {
      ...payload.vehicle,
      display_variant_id: selectedVersion.display_variant_id,
      year_from: selectedVersion.year_from,
      year_to: selectedVersion.year_to,
      display_year: selectedVersion.display_year,
      commercial_name: selectedVersion.commercial_name,
      system_power_kw: selectedVersion.system_power_kw,
      system_power_cv: selectedVersion.system_power_cv,
      thermal_power_kw: selectedVersion.thermal_power_kw,
      thermal_power_cv: selectedVersion.thermal_power_cv,
      power_data_status: selectedVersion.power_data_status,
      power_data_confidence: selectedVersion.power_data_confidence,
      power_data_source: selectedVersion.power_data_source,
      power_data_source_url: selectedVersion.power_data_source_url,
    },
  };
}

function setComparisonModeUi(active) {
  elements.vehicleTitle.textContent = active ? 'Confronto auto' : 'Auto';
  elements.primaryVehicleSummary.hidden = !active;
  elements.primaryVehicleFields.hidden = active;
  elements.primaryVehicleFields.classList.remove('isComparisonEdit');
  elements.togglePrimaryEdit.textContent = 'Modifica';
  elements.togglePrimaryEdit.setAttribute('aria-expanded', 'false');
  elements.usageTitle.textContent = active
    ? 'Utilizzo per entrambe'
    : 'Utilizzo';
  elements.usageComparisonHint.hidden = !active;

  if (active) {
    updatePrimarySummary();
  } else {
    elements.viewComparison.hidden = true;
  }
}

function togglePrimaryEdit() {
  const shouldOpen = elements.primaryVehicleFields.hidden;
  elements.primaryVehicleFields.hidden = !shouldOpen;
  elements.primaryVehicleFields.classList.toggle(
    'isComparisonEdit',
    shouldOpen,
  );
  elements.togglePrimaryEdit.textContent = shouldOpen ? 'Chiudi' : 'Modifica';
  elements.togglePrimaryEdit.setAttribute(
    'aria-expanded',
    String(shouldOpen),
  );

  if (shouldOpen) {
    elements.brand.focus();
  }
}

function renderCurrentResults() {
  if (
    state.comparisonActive
    && state.results.primary
    && state.results.comparison
  ) {
    renderComparison(state.results.primary, state.results.comparison);
    return;
  }

  if (state.results.primary) {
    renderResult(state.results.primary);
    return;
  }

  renderEmptyState();
}

async function handleBrandChange(slot) {
  const controls = vehicleControls[slot];
  state.requestSequence += 1;
  state.results[slot] = null;
  state.versions[slot] = new Map();
  elements.viewComparison.hidden = true;
  if (slot === 'primary') {
    elements.addComparison.disabled = true;
  }
  resetSelect(controls.model, 'Caricamento modelli…');
  resetSelect(controls.version, 'Prima seleziona un modello');

  if (!controls.brand.value) {
    resetSelect(controls.model, 'Prima seleziona una marca');
    renderCurrentResults();
    return;
  }

  renderCurrentResults();

  try {
    const selectedBrand = controls.brand.value;
    const models = await window.AutoTcoApi.getModels(selectedBrand);

    if (controls.brand.value !== selectedBrand) {
      return;
    }

    const validModels = models.filter(
      (item) => !invalidModelKeys.has(compactKey(item.model_key || item.model)),
    );
    replaceOptions(
      controls.model,
      'Seleziona modello',
      validModels,
      (item) => ({
        value: item.model_catalog_id,
        label: formatModelName(item.model, item.brand, item.brand_key),
      }),
    );
  } catch (error) {
    resetSelect(controls.model, 'Modelli non disponibili');
    renderError(error.message);
  }
}

async function handleModelChange(slot) {
  const controls = vehicleControls[slot];
  state.requestSequence += 1;
  state.results[slot] = null;
  state.versions[slot] = new Map();
  elements.viewComparison.hidden = true;
  if (slot === 'primary') {
    elements.addComparison.disabled = true;
  }
  resetSelect(controls.version, 'Caricamento versioni…');

  if (!controls.model.value) {
    resetSelect(controls.version, 'Prima seleziona un modello');
    renderCurrentResults();
    return;
  }

  renderCurrentResults();

  try {
    const selectedModel = controls.model.value;
    const versions = await window.AutoTcoApi.getVersions(selectedModel);

    if (controls.model.value !== selectedModel) {
      return;
    }

    const showYears = versions.length > 0 && versions.every((item) => {
      const yearFrom = Number(item.year_from ?? item.display_year);
      const yearTo = Number(item.year_to ?? item.display_year);
      return Number.isInteger(yearFrom)
        && Number.isInteger(yearTo)
        && yearFrom >= 1900
        && yearTo <= 2100
        && yearFrom <= yearTo;
    });

    state.versions[slot] = new Map(
      versions.map((item) => [
        String(item.display_variant_id || item.vehicle_cluster_id),
        item,
      ]),
    );

    replaceOptions(
      controls.version,
      'Seleziona versione',
      versions,
      (item) => ({
        value: item.display_variant_id || item.vehicle_cluster_id,
        label: formatVersionLabel(item, showYears),
      }),
    );
  } catch (error) {
    resetSelect(controls.version, 'Versioni non disponibili');
    renderError(error.message);
  }
}

function handleVersionChange(slot) {
  state.results[slot] = null;
  elements.viewComparison.hidden = true;

  if (slot === 'primary') {
    updatePrimarySummary();
    elements.addComparison.disabled = !elements.version.value;
    elements.addComparison.hidden = state.comparisonActive;
  }

  updateResult();
}

async function updateResult() {
  updateSliderLabels();

  if (!elements.version.value) {
    state.results.primary = null;
    renderCurrentResults();
    return;
  }

  const sequence = ++state.requestSequence;
  renderLoading();

  try {
    const primaryVersion = getSelectedVersion('primary');
    const comparisonVersion = getSelectedVersion('comparison');
    const commonInputs = {
      annualKm: Number(elements.km.value),
      ownershipYears: Number(elements.years.value),
      regionCode: elements.region.value || 'italia',
    };
    const primaryRequest = window.AutoTcoApi.estimate({
      vehicleClusterId:
        primaryVersion?.vehicle_cluster_id || elements.version.value,
      displayVariantId:
        primaryVersion?.display_variant_id || elements.version.value,
      ...commonInputs,
    });
    const comparisonRequest = state.comparisonActive
      && elements.versionCompare.value
      ? window.AutoTcoApi.estimate({
        vehicleClusterId:
          comparisonVersion?.vehicle_cluster_id
          || elements.versionCompare.value,
        displayVariantId:
          comparisonVersion?.display_variant_id
          || elements.versionCompare.value,
        ...commonInputs,
      })
      : Promise.resolve(null);
    const [primaryPayload, comparisonPayload] = await Promise.all([
      primaryRequest,
      comparisonRequest,
    ]);

    if (sequence === state.requestSequence) {
      state.results.primary = applySelectedVersion(
        primaryPayload,
        primaryVersion,
      );
      state.results.comparison = applySelectedVersion(
        comparisonPayload,
        comparisonVersion,
      );
      updatePrimarySummary(state.results.primary);
      renderCurrentResults();
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

function openComparison() {
  state.comparisonActive = true;
  setComparisonModeUi(true);
  elements.comparisonVehicle.hidden = false;
  elements.addComparison.hidden = true;
  elements.addComparison.setAttribute('aria-expanded', 'true');
  elements.brandCompare.focus();
}

function closeComparison() {
  state.requestSequence += 1;
  state.comparisonActive = false;
  state.results.comparison = null;
  setComparisonModeUi(false);
  elements.comparisonVehicle.hidden = true;
  elements.addComparison.hidden = false;
  elements.addComparison.disabled = !elements.version.value;
  elements.addComparison.setAttribute('aria-expanded', 'false');
  elements.brandCompare.value = '';
  resetSelect(elements.modelCompare, 'Prima seleziona una marca');
  resetSelect(elements.versionCompare, 'Prima seleziona un modello');
  renderCurrentResults();
  elements.addComparison.focus();
}

function viewComparison() {
  const reduceMotion = window.matchMedia(
    '(prefers-reduced-motion: reduce)',
  ).matches;

  elements.result.scrollIntoView({
    behavior: reduceMotion ? 'auto' : 'smooth',
    block: 'start',
  });
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

  elements.brand.addEventListener(
    'change',
    () => handleBrandChange('primary'),
  );
  elements.model.addEventListener(
    'change',
    () => handleModelChange('primary'),
  );
  elements.version.addEventListener(
    'change',
    () => handleVersionChange('primary'),
  );
  elements.brandCompare.addEventListener(
    'change',
    () => handleBrandChange('comparison'),
  );
  elements.modelCompare.addEventListener(
    'change',
    () => handleModelChange('comparison'),
  );
  elements.versionCompare.addEventListener(
    'change',
    () => handleVersionChange('comparison'),
  );
  elements.addComparison.addEventListener('click', openComparison);
  elements.removeComparison.addEventListener('click', closeComparison);
  elements.togglePrimaryEdit.addEventListener('click', togglePrimaryEdit);
  elements.viewComparison.addEventListener('click', viewComparison);
  elements.km.addEventListener('input', scheduleCalculation);
  elements.years.addEventListener('input', scheduleCalculation);
  elements.region.addEventListener('change', updateResult);
}

document.addEventListener('DOMContentLoaded', initialize);
