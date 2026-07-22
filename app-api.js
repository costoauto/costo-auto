(function initializeAutoTcoApi(global) {
  const config = global.AutoTcoConfig || {};
  const supabaseUrl = String(config.supabaseUrl || '').replace(/\/$/, '');
  const publishableKey = String(config.publishableKey || '');

  if (!supabaseUrl || !publishableKey) {
    throw new Error('Configurazione del servizio dati mancante');
  }

  async function rpc(functionName, parameters = {}) {
    const response = await fetch(
      `${supabaseUrl}/rest/v1/rpc/${functionName}`,
      {
        method: 'POST',
        body: JSON.stringify(parameters),
        headers: {
          apikey: publishableKey,
          'Content-Type': 'application/json',
        },
      },
    );

    const payload = await response.json().catch(() => ({}));

    if (!response.ok) {
      throw new Error(
        payload.message || payload.error || 'Richiesta non riuscita',
      );
    }

    return payload;
  }

  global.AutoTcoApi = Object.freeze({
    async getBrands() {
      const payload = await rpc('auto_tco_brands');
      return payload.items;
    },

    async getModels(brandKey) {
      const payload = await rpc('auto_tco_models', {
        p_brand_key: brandKey,
      });
      return payload.items;
    },

    async getVersions(modelId) {
      const payload = await rpc('auto_tco_versions', {
        p_model_id: modelId,
      });
      return payload.items;
    },

    async getRegions() {
      const payload = await rpc('auto_tco_regions');
      return payload.items;
    },

    async estimate({ vehicleClusterId, annualKm, ownershipYears, regionCode }) {
      return rpc('auto_tco_estimate', {
        p_vehicle_cluster_id: vehicleClusterId,
        p_annual_km: annualKm,
        p_ownership_years: ownershipYears,
        p_region_code: regionCode,
      });
    },
  });
})(window);
