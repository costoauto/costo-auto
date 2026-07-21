(function initializeAutoTcoApi(global) {
  const baseUrl = '/api/v1';

  async function request(path, options = {}) {
    const response = await fetch(`${baseUrl}${path}`, {
      ...options,
      headers: {
        'Content-Type': 'application/json',
        ...(options.headers || {}),
      },
    });

    const payload = await response.json().catch(() => ({}));

    if (!response.ok) {
      throw new Error(payload.error || 'Richiesta non riuscita');
    }

    return payload;
  }

  global.AutoTcoApi = Object.freeze({
    async getBrands() {
      const payload = await request('/brands');
      return payload.items;
    },

    async getModels(brandKey) {
      const payload = await request(
        `/models?brand_key=${encodeURIComponent(brandKey)}`,
      );
      return payload.items;
    },

    async getVersions(modelId) {
      const payload = await request(
        `/versions?model_id=${encodeURIComponent(modelId)}`,
      );
      return payload.items;
    },

    async getRegions() {
      const payload = await request('/regions');
      return payload.items;
    },

    async estimate({ vehicleClusterId, annualKm, ownershipYears, regionCode }) {
      return request('/tco/estimate', {
        method: 'POST',
        body: JSON.stringify({
          vehicle_cluster_id: vehicleClusterId,
          annual_km: annualKm,
          ownership_years: ownershipYears,
          region_code: regionCode,
        }),
      });
    },
  });
})(window);
