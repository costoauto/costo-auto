\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - audit diagnostico conclusivo del motore di calcolo.
-- Non modifica dati o funzioni permanenti: usa soltanto oggetti temporanei
-- della sessione e termina con ROLLBACK.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

\echo 'Audit TCO: calcolo di tutte le versioni pubblicate...'

CREATE OR REPLACE FUNCTION pg_temp.safe_auto_tco_estimate_variant(
  p_vehicle_cluster_id text,
  p_display_variant_id text,
  p_annual_km integer,
  p_ownership_years integer,
  p_region_code text
)
RETURNS jsonb
LANGUAGE plpgsql
VOLATILE
AS $function$
BEGIN
  RETURN public.auto_tco_estimate_variant(
    p_vehicle_cluster_id,
    p_display_variant_id,
    p_annual_km,
    p_ownership_years,
    p_region_code
  );
EXCEPTION WHEN OTHERS THEN
  RETURN jsonb_build_object(
    '_audit_error', SQLSTATE || ': ' || SQLERRM
  );
END;
$function$;

CREATE TEMP TABLE audit_tco_all_v1 AS
SELECT
  input.display_variant_id,
  input.vehicle_cluster_id,
  input.model_catalog_id,
  input.brand,
  input.model,
  input.version_label,
  input.year_from,
  input.year_to,
  input.display_year,
  input.fuel_type,
  input.hybrid_type,
  input.power_basis,
  pg_temp.safe_auto_tco_estimate_variant(
    input.vehicle_cluster_id,
    input.display_variant_id,
    15000,
    5,
    'italia'
  ) AS payload
FROM mvp.maintenance_display_variant_inputs_v1 AS input;

CREATE INDEX ON audit_tco_all_v1 (display_variant_id);
ANALYZE audit_tco_all_v1;

CREATE TEMP VIEW audit_tco_parsed_v1 AS
SELECT
  audit.*,
  NULLIF(audit.payload ->> '_audit_error', '') AS request_error,
  audit.payload #>> '{quality,status}' AS quality_status,
  NULLIF(
    audit.payload #>> '{monthly_costs,total_monthly_eur}', ''
  )::numeric AS total_eur,
  NULLIF(
    audit.payload #>> '{monthly_costs,depreciation_eur}', ''
  )::numeric AS depreciation_eur,
  NULLIF(
    audit.payload #>> '{monthly_costs,fuel_or_energy_eur}', ''
  )::numeric AS energy_eur,
  NULLIF(
    audit.payload #>> '{monthly_costs,tax_eur}', ''
  )::numeric AS tax_eur,
  NULLIF(
    audit.payload #>> '{monthly_costs,insurance_eur}', ''
  )::numeric AS insurance_eur,
  NULLIF(
    audit.payload #>> '{monthly_costs,maintenance_eur}', ''
  )::numeric AS maintenance_eur,
  NULLIF(
    audit.payload #>>
      '{calculation_details,maintenance,representative_year_used}',
    ''
  )::integer AS maintenance_year_used,
  audit.payload #>>
    '{calculation_details,maintenance,power_basis}'
    AS maintenance_power_basis,
  audit.payload #>>
    '{quality,confidence,maintenance}'
    AS maintenance_confidence
FROM audit_tco_all_v1 AS audit;

CREATE TEMP VIEW audit_tco_anomalies_v1 AS
SELECT
  parsed.*,
  concat_ws(
    ', ',
    CASE WHEN request_error IS NOT NULL
      THEN 'request_failed' END,
    CASE WHEN request_error IS NULL
        AND quality_status IS DISTINCT FROM 'ready'
      THEN 'status_not_ready' END,
    CASE WHEN request_error IS NULL AND (
        total_eur IS NULL
        OR depreciation_eur IS NULL
        OR energy_eur IS NULL
        OR tax_eur IS NULL
        OR insurance_eur IS NULL
        OR maintenance_eur IS NULL
      ) THEN 'missing_cost' END,
    CASE WHEN least(
        depreciation_eur,
        energy_eur,
        tax_eur,
        insurance_eur,
        maintenance_eur
      ) < 0 THEN 'negative_cost' END,
    CASE WHEN total_eur IS NOT NULL
        AND depreciation_eur IS NOT NULL
        AND energy_eur IS NOT NULL
        AND tax_eur IS NOT NULL
        AND insurance_eur IS NOT NULL
        AND maintenance_eur IS NOT NULL
        AND abs(
          total_eur - (
            depreciation_eur
            + energy_eur
            + tax_eur
            + insurance_eur
            + maintenance_eur
          )
        ) > 0.10
      THEN 'total_mismatch' END,
    CASE WHEN request_error IS NULL
        AND maintenance_year_used IS DISTINCT FROM display_year
      THEN 'maintenance_year_mismatch' END,
    CASE WHEN hybrid_type = 'plug_in_hybrid'
        AND power_basis = 'thermal_engine_power'
        AND maintenance_power_basis IS DISTINCT FROM 'thermal_engine_power'
      THEN 'plugin_power_mismatch' END,
    CASE WHEN request_error IS NULL
        AND tax_eur = 0
        AND fuel_type <> 'electric'
        AND hybrid_type <> 'electric'
      THEN 'zero_tax_non_electric' END,
    CASE WHEN request_error IS NULL
        AND maintenance_confidence IS NULL
      THEN 'maintenance_confidence_missing' END
  ) AS anomaly_codes
FROM audit_tco_parsed_v1 AS parsed;

\echo 'Audit TCO: controllo degli slider su un campione stratificato...'

CREATE TEMP TABLE audit_tco_slider_sample_v1 AS
WITH ranked AS (
  SELECT
    parsed.*,
    row_number() OVER (
      PARTITION BY
        parsed.fuel_type,
        parsed.hybrid_type,
        floor(parsed.display_year / 5.0)
      ORDER BY md5(
        parsed.display_variant_id || ':' || parsed.vehicle_cluster_id
      )
    ) AS sample_rank
  FROM audit_tco_parsed_v1 AS parsed
  WHERE parsed.request_error IS NULL
    AND parsed.quality_status = 'ready'
)
SELECT
  ranked.*,
  pg_temp.safe_auto_tco_estimate_variant(
    ranked.vehicle_cluster_id,
    ranked.display_variant_id,
    30000,
    5,
    'italia'
  ) AS payload_30000_km,
  pg_temp.safe_auto_tco_estimate_variant(
    ranked.vehicle_cluster_id,
    ranked.display_variant_id,
    15000,
    10,
    'italia'
  ) AS payload_10_years
FROM ranked
WHERE ranked.sample_rank <= 2;

CREATE TEMP VIEW audit_tco_slider_anomalies_v1 AS
SELECT
  sample.*,
  concat_ws(
    ', ',
    CASE WHEN sample.payload_30000_km ? '_audit_error'
      THEN 'km_request_failed' END,
    CASE WHEN sample.payload_10_years ? '_audit_error'
      THEN 'years_request_failed' END,
    CASE WHEN NOT (sample.payload_30000_km ? '_audit_error')
        AND NULLIF(
          sample.payload_30000_km #>>
            '{monthly_costs,total_monthly_eur}', ''
        )::numeric <= sample.total_eur
      THEN 'total_not_increasing_with_km' END,
    CASE WHEN NOT (sample.payload_30000_km ? '_audit_error')
        AND abs(
          NULLIF(
            sample.payload_30000_km #>>
              '{monthly_costs,fuel_or_energy_eur}', ''
          )::numeric - 2 * sample.energy_eur
        ) > 0.05
      THEN 'energy_not_linear_with_km' END,
    CASE WHEN NOT (sample.payload_30000_km ? '_audit_error')
        AND abs(
          NULLIF(
            sample.payload_30000_km #>>
              '{monthly_costs,maintenance_eur}', ''
          )::numeric - 2 * sample.maintenance_eur
        ) > 0.05
      THEN 'maintenance_not_linear_with_km' END,
    CASE WHEN NOT (sample.payload_30000_km ? '_audit_error')
        AND NULLIF(
          sample.payload_30000_km #>>
            '{monthly_costs,depreciation_eur}', ''
        )::numeric < sample.depreciation_eur - 0.01
      THEN 'depreciation_decreased_with_km' END,
    CASE WHEN NOT (sample.payload_30000_km ? '_audit_error')
        AND NULLIF(
          sample.payload_30000_km #>> '{monthly_costs,tax_eur}', ''
        )::numeric IS DISTINCT FROM sample.tax_eur
      THEN 'tax_changed_with_km' END,
    CASE WHEN NOT (sample.payload_30000_km ? '_audit_error')
        AND NULLIF(
          sample.payload_30000_km #>>
            '{monthly_costs,insurance_eur}', ''
        )::numeric IS DISTINCT FROM sample.insurance_eur
      THEN 'insurance_changed_with_km' END,
    CASE WHEN NOT (sample.payload_10_years ? '_audit_error')
        AND NULLIF(
          sample.payload_10_years #>>
            '{monthly_costs,maintenance_eur}', ''
        )::numeric < sample.maintenance_eur - 0.01
      THEN 'maintenance_decreased_with_years' END
  ) AS anomaly_codes
FROM audit_tco_slider_sample_v1 AS sample;

-- Prime anomalie operative, se presenti.
SELECT
  brand,
  model,
  version_label,
  anomaly_codes,
  request_error
FROM audit_tco_anomalies_v1
WHERE anomaly_codes <> ''
ORDER BY brand, model, version_label
LIMIT 50;

-- Prime anomalie degli slider, se presenti.
SELECT
  brand,
  model,
  version_label,
  anomaly_codes
FROM audit_tco_slider_anomalies_v1
WHERE anomaly_codes <> ''
ORDER BY brand, model, version_label
LIMIT 50;

-- Valori estremi da leggere, senza considerarli automaticamente errori.
SELECT
  brand,
  model,
  version_label,
  total_eur
FROM audit_tco_anomalies_v1
WHERE total_eur < 50 OR total_eur > 5000
ORDER BY total_eur DESC
LIMIT 20;

WITH main_metrics AS (
  SELECT
    count(*)::integer AS versioni_controllate,
    count(*) FILTER (WHERE request_error IS NULL)::integer
      AS richieste_riuscite,
    count(*) FILTER (WHERE request_error IS NOT NULL)::integer
      AS richieste_fallite,
    count(*) FILTER (WHERE quality_status = 'ready')::integer
      AS risultati_ready,
    count(*) FILTER (WHERE anomaly_codes <> '')::integer
      AS risultati_con_anomalie,
    count(*) FILTER (
      WHERE total_eur < 50 OR total_eur > 5000
    )::integer AS totali_da_esaminare,
    round(min(total_eur), 2) AS totale_minimo,
    round(
      (
        percentile_cont(0.5)
          WITHIN GROUP (ORDER BY total_eur)
      )::numeric,
      2
    ) AS totale_mediano,
    round(
      (
        percentile_cont(0.95)
          WITHIN GROUP (ORDER BY total_eur)
      )::numeric,
      2
    ) AS totale_p95,
    round(max(total_eur), 2) AS totale_massimo
  FROM audit_tco_anomalies_v1
), slider_metrics AS (
  SELECT
    count(*)::integer AS versioni_test_slider,
    count(*) FILTER (WHERE anomaly_codes <> '')::integer
      AS problemi_slider
  FROM audit_tco_slider_anomalies_v1
), security_metrics AS (
  SELECT
    NOT has_table_privilege(
      'anon',
      'mvp.maintenance_display_variant_inputs_v1',
      'SELECT'
    ) AS dati_privati_protetti,
    has_function_privilege(
      'anon',
      'public.auto_tco_estimate_variant(text,text,integer,integer,text)',
      'EXECUTE'
    ) AS endpoint_pubblico_disponibile,
    NOT has_function_privilege(
      'anon',
      'mvp.auto_tco_estimate_variant_before_maintenance_year_v1(text,text,integer,integer,text)',
      'EXECUTE'
    ) AS motore_precedente_protetto
)
SELECT
  main_metrics.*,
  slider_metrics.*,
  security_metrics.*,
  CASE
    WHEN main_metrics.versioni_controllate > 0
      AND main_metrics.richieste_fallite = 0
      AND main_metrics.risultati_ready = main_metrics.versioni_controllate
      AND main_metrics.risultati_con_anomalie = 0
      AND slider_metrics.problemi_slider = 0
      AND security_metrics.dati_privati_protetti
      AND security_metrics.endpoint_pubblico_disponibile
      AND security_metrics.motore_precedente_protetto
    THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM main_metrics
CROSS JOIN slider_metrics
CROSS JOIN security_metrics;

DO $block$
DECLARE
  v_main_anomalies integer;
  v_slider_anomalies integer;
  v_total integer;
BEGIN
  SELECT count(*), count(*) FILTER (WHERE anomaly_codes <> '')
  INTO v_total, v_main_anomalies
  FROM audit_tco_anomalies_v1;

  SELECT count(*) FILTER (WHERE anomaly_codes <> '')
  INTO v_slider_anomalies
  FROM audit_tco_slider_anomalies_v1;

  IF v_total = 0
    OR v_total <> (
      SELECT count(*)
      FROM mvp.maintenance_display_variant_inputs_v1
    )
    OR v_main_anomalies <> 0
    OR v_slider_anomalies <> 0
    OR has_table_privilege(
      'anon',
      'mvp.maintenance_display_variant_inputs_v1',
      'SELECT'
    )
    OR has_function_privilege(
      'anon',
      'mvp.auto_tco_estimate_variant_before_maintenance_year_v1(text,text,integer,integer,text)',
      'EXECUTE'
    )
    OR NOT has_function_privilege(
      'anon',
      'public.auto_tco_estimate_variant(text,text,integer,integer,text)',
      'EXECUTE'
    )
  THEN
    RAISE EXCEPTION
      'Audit TCO non superato: esaminare le anomalie mostrate sopra';
  END IF;
END;
$block$;

ROLLBACK;
