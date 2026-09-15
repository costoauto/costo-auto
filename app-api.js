(function initializeAutoTcoApi(global) {
  const config = global.AutoTcoConfig || {};
  const supabaseUrl = String(config.supabaseUrl || '').replace(/\/$/, '');
  const publishableKey = String(config.publishableKey || '');

  if (!supabaseUrl || !publishableKey) {
    throw new Error('Configurazione del servizio dati mancante');
  }

  async function rpc(functionName, parameters = {}, options = {}) {
    const response = await fetch(
      `${supabaseUrl}/rest/v1/rpc/${functionName}`,
      {
        method: 'POST',
        body: JSON.stringify(parameters),
        signal: options.signal,
        headers: {
          apikey: publishableKey,
          'Content-Type': 'application/json',
        },
      },
    );

    let payload;

    try {
      payload = await response.json();
    } catch (error) {
      if (error.name === 'AbortError' || options.signal?.aborted) {
        throw error;
      }

      if (response.ok) {
        throw new Error('Risposta non valida dal servizio dati');
      }

      payload = {};
    }

    if (!response.ok) {
      throw new Error(
        payload.message || payload.error || 'Richiesta non riuscita',
      );
    }

    return payload;
  }

  function getItems(payload) {
    if (!payload || !Array.isArray(payload.items)) {
      throw new Error('Risposta incompleta dal servizio dati');
    }

    return payload.items;
  }

  function getEstimate(payload) {
    if (
      !payload
      || typeof payload !== 'object'
      || Array.isArray(payload)
      || !payload.vehicle
      || !payload.monthly_costs
      || !payload.quality
    ) {
      throw new Error('Calcolo incompleto ricevuto dal servizio dati');
    }

    return payload;
  }

  global.AutoTcoApi = Object.freeze({
    async getBrands() {
      const payload = await rpc('auto_tco_brands');
      return getItems(payload);
    },

    async getModels(brandKey) {
      const payload = await rpc('auto_tco_models', {
        p_brand_key: brandKey,
      });
      return getItems(payload);
    },

    async getVersions(modelId) {
      const payload = await rpc('auto_tco_versions', {
        p_model_id: modelId,
      });
      return getItems(payload);
    },

    async getRegions() {
      const payload = await rpc('auto_tco_regions');
      return getItems(payload);
    },

    async estimate({
      modelCatalogId,
      vehicleClusterId,
      displayVariantId,
      annualKm,
      ownershipYears,
      regionCode,
      signal,
    }) {
      const payload = await rpc(
        'auto_tco_estimate_selection',
        {
          p_model_catalog_id: modelCatalogId,
          p_vehicle_cluster_id: vehicleClusterId,
          p_display_variant_id: displayVariantId || vehicleClusterId,
          p_annual_km: annualKm,
          p_ownership_years: ownershipYears,
          p_region_code: regionCode,
        },
        { signal },
      );

      return getEstimate(payload);
    },
  });
})(window);
