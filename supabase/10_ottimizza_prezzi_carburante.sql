-- Auto TCO - rende veloce la lettura dei prezzi medi carburante.
--
-- La vista originale ricalcola le medie su oltre due milioni di rilevazioni
-- ogni volta che viene chiamato il motore. Qui il suo piccolo risultato finale
-- viene salvato in una cache interna e indicizzata. Fonti, valori e formule non
-- cambiano. Quando si importano nuovi prezzi basta rieseguire questo file.

BEGIN;

SET LOCAL statement_timeout = '15min';

CREATE TABLE IF NOT EXISTS mvp.fuel_prices_site_cache_v1 (
  region_code text NOT NULL,
  region_name text NOT NULL,
  fuel_type text NOT NULL,
  service_mode text NOT NULL,
  unit text NOT NULL,
  average_price_eur numeric NOT NULL,
  period_start date NOT NULL,
  period_end date NOT NULL,
  observations bigint NOT NULL,
  coverage_ratio numeric NOT NULL,
  calculation_method text NOT NULL,
  confidence text NOT NULL,
  cached_at timestamptz NOT NULL DEFAULT now()
);

COMMENT ON TABLE mvp.fuel_prices_site_cache_v1 IS
  'Cache interna dei prezzi medi a 12 mesi gia calcolati dalla vista MIMIT; aggiornata rieseguendo la migration 10.';

REVOKE ALL ON TABLE mvp.fuel_prices_site_cache_v1
  FROM PUBLIC, anon, authenticated;

GRANT SELECT ON TABLE mvp.fuel_prices_site_cache_v1
  TO auto_tco_web;

TRUNCATE TABLE mvp.fuel_prices_site_cache_v1;

INSERT INTO mvp.fuel_prices_site_cache_v1 (
  region_code,
  region_name,
  fuel_type,
  service_mode,
  unit,
  average_price_eur,
  period_start,
  period_end,
  observations,
  coverage_ratio,
  calculation_method,
  confidence,
  cached_at
)
SELECT
  region_code,
  region_name,
  fuel_type,
  service_mode,
  unit,
  average_price_eur,
  period_start,
  period_end,
  observations,
  coverage_ratio,
  calculation_method,
  confidence,
  now()
FROM mvp.fuel_prices_site_rolling_12m;

CREATE INDEX IF NOT EXISTS fuel_prices_site_cache_v1_lookup_idx
  ON mvp.fuel_prices_site_cache_v1 (
    region_code,
    fuel_type,
    service_mode,
    period_end DESC
  );

ANALYZE mvp.fuel_prices_site_cache_v1;

DO $block$
DECLARE
  function_definition text;
BEGIN
  SELECT pg_get_functiondef(
    'mvp.estimate_vehicle_cluster_energy_v1(text,integer,text,date)'
      ::regprocedure
  )
  INTO function_definition;

  IF function_definition IS NULL THEN
    RAISE EXCEPTION 'Funzione energia non trovata';
  END IF;

  IF position(
    'mvp.fuel_prices_site_rolling_12m'
    IN function_definition
  ) > 0 THEN
    function_definition := replace(
      function_definition,
      'mvp.fuel_prices_site_rolling_12m',
      'mvp.fuel_prices_site_cache_v1'
    );
    EXECUTE function_definition;
  ELSIF position(
    'mvp.fuel_prices_site_cache_v1'
    IN function_definition
  ) = 0 THEN
    RAISE EXCEPTION
      'La funzione energia non contiene la sorgente prezzi prevista';
  END IF;
END;
$block$;

REVOKE ALL ON FUNCTION mvp.estimate_vehicle_cluster_energy_v1(
  text, integer, text, date
) FROM PUBLIC;

GRANT EXECUTE ON FUNCTION mvp.estimate_vehicle_cluster_energy_v1(
  text, integer, text, date
) TO auto_tco_web;

COMMIT;

-- Verifica inclusa: deve terminare con verifica = ok.
WITH cache_summary AS (
  SELECT
    count(*)::integer AS prezzi_memorizzati,
    count(DISTINCT region_code)::integer AS aree,
    count(DISTINCT fuel_type)::integer AS carburanti,
    count(*) FILTER (
      WHERE average_price_eur <= 0
        OR period_end < period_start
    )::integer AS righe_non_valide
  FROM mvp.fuel_prices_site_cache_v1
), function_check AS (
  SELECT position(
    'mvp.fuel_prices_site_cache_v1'
    IN pg_get_functiondef(
      'mvp.estimate_vehicle_cluster_energy_v1(text,integer,text,date)'
        ::regprocedure
    )
  ) > 0 AS usa_cache
), sample AS (
  SELECT energy.*
  FROM mvp.site_vehicle_catalog_eea_v2 AS catalog
  CROSS JOIN LATERAL mvp.estimate_vehicle_cluster_energy_v1(
    catalog.vehicle_cluster_id,
    15000,
    'italia',
    CURRENT_DATE
  ) AS energy
  WHERE catalog.model_key NOT IN (
    'UNKNOWN', 'UNK', 'NA', 'NULL', 'NOTAVAILABLE',
    'GV80GENESISGV80'
  )
  ORDER BY catalog.registrations_count DESC
  LIMIT 1
)
SELECT
  cache_summary.prezzi_memorizzati,
  cache_summary.aree,
  cache_summary.carburanti,
  cache_summary.righe_non_valide,
  function_check.usa_cache,
  sample.calculation_status AS esempio_stato,
  sample.monthly_energy_cost_eur AS esempio_euro_mese,
  CASE
    WHEN cache_summary.prezzi_memorizzati > 0
      AND cache_summary.aree >= 20
      AND cache_summary.carburanti >= 4
      AND cache_summary.righe_non_valide = 0
      AND function_check.usa_cache
      AND sample.calculation_status = 'complete'
      AND sample.monthly_energy_cost_eur > 0
      THEN 'ok'
    ELSE 'controllare'
  END AS verifica
FROM cache_summary
CROSS JOIN function_check
CROSS JOIN sample;
