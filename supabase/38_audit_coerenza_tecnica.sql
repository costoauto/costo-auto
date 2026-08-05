\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - audit diagnostico della coerenza tecnica del catalogo pubblico.
--
-- Non modifica dati o funzioni permanenti e termina con ROLLBACK.
-- Controlla tutte le versioni realmente distinguibili nel dropdown:
--   * conversione kW/CV e potenze PHEV totale/termica;
--   * coerenza tra alimentazione, tipo ibrido e powertrain;
--   * presenza e plausibilita dei consumi usati dal calcolo;
--   * duplicati visibili che l'utente non potrebbe distinguere;
--   * riuscita e quadratura del calcolo TCO.
-- Le soglie di plausibilita generano casi da esaminare, non correzioni.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

CREATE OR REPLACE FUNCTION pg_temp.safe_auto_tco_technical_v1(
  p_vehicle_cluster_id text,
  p_display_variant_id text
)
RETURNS jsonb
LANGUAGE plpgsql
VOLATILE
AS $function$
BEGIN
  RETURN public.auto_tco_estimate_variant(
    p_vehicle_cluster_id,
    p_display_variant_id,
    15000,
    5,
    'italia'
  );
EXCEPTION WHEN OTHERS THEN
  RETURN jsonb_build_object(
    '_audit_error', SQLSTATE || ': ' || SQLERRM
  );
END;
$function$;

\echo 'Audit tecnico: estrazione delle versioni pubbliche...'

CREATE TEMP TABLE audit_technical_versions_v1
ON COMMIT DROP
AS
WITH brand_item AS (
  SELECT brand.item
  FROM jsonb_array_elements(
    public.auto_tco_brands() -> 'items'
  ) AS brand(item)
), model_item AS (
  SELECT DISTINCT ON (model.item ->> 'model_catalog_id')
    model.item
  FROM brand_item AS brand
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_models(brand.item ->> 'brand_key') -> 'items'
  ) AS model(item)
  WHERE NULLIF(model.item ->> 'model_catalog_id', '') IS NOT NULL
  ORDER BY model.item ->> 'model_catalog_id'
), version_item AS (
  SELECT
    model.item ->> 'model_catalog_id' AS public_model_id,
    version.item
  FROM model_item AS model
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(
      model.item ->> 'model_catalog_id'
    ) -> 'items'
  ) AS version(item)
), normalized AS (
  SELECT
    public_model_id,
    COALESCE(
      NULLIF(item ->> 'model_catalog_id', ''),
      public_model_id
    ) AS source_model_id,
    COALESCE(NULLIF(item ->> 'brand', ''), '(mancante)') AS brand,
    COALESCE(NULLIF(item ->> 'model', ''), '(mancante)') AS model,
    COALESCE(
      NULLIF(item ->> 'display_variant_id', ''),
      NULLIF(item ->> 'vehicle_cluster_id', '')
    ) AS display_variant_id,
    NULLIF(item ->> 'vehicle_cluster_id', '') AS vehicle_cluster_id,
    NULLIF(item ->> 'vehicle_profile_id', '')::integer
      AS vehicle_profile_id,
    NULLIF(item ->> 'version_label', '') AS version_label,
    NULLIF(item ->> 'year_from', '')::integer AS year_from,
    NULLIF(item ->> 'year_to', '')::integer AS year_to,
    NULLIF(item ->> 'display_year', '')::integer AS display_year,
    NULLIF(item ->> 'fuel_type', '') AS fuel_type,
    COALESCE(NULLIF(item ->> 'hybrid_type', ''), 'none')
      AS hybrid_type,
    NULLIF(item ->> 'powertrain_type', '') AS powertrain_type,
    NULLIF(item ->> 'power_kw', '')::numeric AS power_kw,
    NULLIF(item ->> 'power_cv', '')::numeric AS power_cv,
    NULLIF(item ->> 'system_power_kw', '')::numeric AS system_power_kw,
    NULLIF(item ->> 'system_power_cv', '')::numeric AS system_power_cv,
    NULLIF(item ->> 'thermal_power_kw', '')::numeric AS thermal_power_kw,
    NULLIF(item ->> 'thermal_power_cv', '')::numeric AS thermal_power_cv,
    NULLIF(item ->> 'power_data_status', '') AS power_data_status,
    NULLIF(item ->> 'power_data_source', '') AS power_data_source,
    NULLIF(item ->> 'energy_data_status', '') AS energy_data_status,
    NULLIF(item ->> 'observation_quality', '') AS observation_quality,
    item
  FROM version_item
), deduplicated AS (
  SELECT DISTINCT ON (
    public_model_id,
    display_variant_id,
    vehicle_cluster_id
  )
    *
  FROM normalized
  WHERE display_variant_id IS NOT NULL
    AND vehicle_cluster_id IS NOT NULL
  ORDER BY
    public_model_id,
    display_variant_id,
    vehicle_cluster_id,
    year_to DESC NULLS LAST,
    year_from DESC NULLS LAST
)
SELECT
  deduplicated.*,
  count(*) OVER (
    PARTITION BY public_model_id, version_label
  )::integer AS identical_visible_label_count
FROM deduplicated;

CREATE UNIQUE INDEX ON audit_technical_versions_v1 (
  public_model_id,
  display_variant_id,
  vehicle_cluster_id
);
CREATE INDEX ON audit_technical_versions_v1 (
  fuel_type,
  hybrid_type
);
ANALYZE audit_technical_versions_v1;

\echo 'Audit tecnico: calcolo TCO di tutte le versioni...'

CREATE TEMP TABLE audit_technical_results_v1
ON COMMIT DROP
AS
SELECT
  version.*,
  pg_temp.safe_auto_tco_technical_v1(
    version.vehicle_cluster_id,
    version.display_variant_id
  ) AS payload
FROM audit_technical_versions_v1 AS version;

CREATE INDEX ON audit_technical_results_v1 (
  public_model_id,
  display_variant_id
);
ANALYZE audit_technical_results_v1;

CREATE TEMP TABLE audit_technical_parsed_v1
ON COMMIT DROP
AS
SELECT
  result.*,
  NULLIF(payload ->> '_audit_error', '') AS request_error,
  payload #>> '{quality,status}' AS quality_status,
  NULLIF(
    payload #>> '{monthly_costs,total_monthly_eur}', ''
  )::numeric AS total_monthly_eur,
  NULLIF(
    payload #>> '{monthly_costs,depreciation_eur}', ''
  )::numeric AS depreciation_eur,
  NULLIF(
    payload #>> '{monthly_costs,fuel_or_energy_eur}', ''
  )::numeric AS energy_monthly_eur,
  NULLIF(
    payload #>> '{monthly_costs,tax_eur}', ''
  )::numeric AS tax_eur,
  NULLIF(
    payload #>> '{monthly_costs,insurance_eur}', ''
  )::numeric AS insurance_eur,
  NULLIF(
    payload #>> '{monthly_costs,maintenance_eur}', ''
  )::numeric AS maintenance_eur,
  NULLIF(
    payload #>>
      '{calculation_details,fuel_or_energy,thermal_consumption_per_100km}',
    ''
  )::numeric AS thermal_consumption_per_100km,
  NULLIF(
    payload #>>
      '{calculation_details,fuel_or_energy,electric_consumption_kwh_100km}',
    ''
  )::numeric AS electric_consumption_kwh_100km,
  NULLIF(
    payload #>>
      '{calculation_details,fuel_or_energy,thermal_consumption_empty_battery_l_100km}',
    ''
  )::numeric AS thermal_empty_battery_l_100km,
  NULLIF(
    payload #>> '{calculation_details,fuel_or_energy,thermal_price_eur}',
    ''
  )::numeric AS thermal_price_eur,
  NULLIF(
    payload #>>
      '{calculation_details,fuel_or_energy,electricity_price_eur_kwh}',
    ''
  )::numeric AS electricity_price_eur_kwh,
  COALESCE(
    NULLIF(
      payload #>> '{calculation_details,fuel_or_energy,method}', ''
    ),
    NULLIF(energy_input.thermal_method, ''),
    NULLIF(energy_input.electric_method, '')
  ) AS energy_method,
  NULLIF(
    payload #>> '{calculation_details,fuel_or_energy,source_name}', ''
  ) AS energy_source_name,
  COALESCE(
    NULLIF(payload #>> '{quality,energy_variant_confidence}', ''),
    NULLIF(energy_input.confidence, '')
  ) AS energy_confidence
FROM audit_technical_results_v1 AS result
LEFT JOIN mvp.vehicle_cluster_energy_inputs_v1 AS energy_input
  ON energy_input.vehicle_cluster_id = result.vehicle_cluster_id;

CREATE INDEX ON audit_technical_parsed_v1 (
  public_model_id,
  version_label
);
ANALYZE audit_technical_parsed_v1;

CREATE TEMP TABLE audit_technical_classified_v1
ON COMMIT DROP
AS
SELECT
  parsed.*,
  concat_ws(
    ', ',
    CASE WHEN version_label IS NULL THEN 'missing_version_label' END,
    CASE WHEN year_from IS NULL OR year_to IS NULL
      THEN 'missing_year' END,
    CASE WHEN fuel_type IS NULL THEN 'missing_fuel_type' END,
    CASE WHEN power_kw IS NULL OR power_cv IS NULL
      THEN 'missing_declared_power' END,
    CASE WHEN power_kw <= 0 OR power_cv <= 0
      THEN 'nonpositive_declared_power' END,
    CASE WHEN power_kw > 0 AND power_cv > 0
        AND abs(power_cv - power_kw * 1.359621617) > 3.0
      THEN 'declared_kw_cv_mismatch' END,
    CASE WHEN fuel_type = 'electric'
        AND COALESCE(hybrid_type, 'none') <> 'none'
      THEN 'electric_with_hybrid_type' END,
    CASE WHEN fuel_type = 'electric'
        AND powertrain_type IS DISTINCT FROM 'electric'
      THEN 'electric_powertrain_mismatch' END,
    CASE WHEN hybrid_type = 'plug_in_hybrid'
        AND fuel_type NOT IN ('petrol', 'diesel')
      THEN 'plugin_invalid_thermal_fuel' END,
    CASE WHEN hybrid_type = 'hybrid'
        AND fuel_type NOT IN ('petrol', 'diesel')
      THEN 'hybrid_invalid_thermal_fuel' END,
    CASE WHEN hybrid_type = 'plug_in_hybrid'
        AND powertrain_type IS DISTINCT FROM 'plug_in_hybrid'
      THEN 'plugin_powertrain_mismatch' END,
    CASE WHEN hybrid_type = 'plug_in_hybrid'
        AND power_data_status = 'verified'
        AND (
          system_power_kw IS NULL
          OR system_power_cv IS NULL
          OR thermal_power_kw IS NULL
          OR thermal_power_cv IS NULL
        )
      THEN 'verified_plugin_missing_power' END,
    CASE WHEN power_data_status = 'verified'
        AND system_power_kw > 0
        AND system_power_cv > 0
        AND abs(system_power_cv - system_power_kw * 1.359621617) > 3.0
      THEN 'plugin_system_kw_cv_mismatch' END,
    CASE WHEN power_data_status = 'verified'
        AND thermal_power_kw > 0
        AND thermal_power_cv > 0
        AND abs(thermal_power_cv - thermal_power_kw * 1.359621617) > 3.0
      THEN 'plugin_thermal_kw_cv_mismatch' END,
    CASE WHEN power_data_status = 'verified'
        AND (
          system_power_kw < thermal_power_kw
          OR system_power_cv < thermal_power_cv
        )
      THEN 'plugin_system_power_below_thermal' END,
    CASE WHEN power_data_status = 'verified'
        AND version_label NOT LIKE (
          '%' || round(system_power_cv)::integer::text
          || ' CV (' || round(thermal_power_cv)::integer::text
          || ' CV termici)%'
        )
      THEN 'plugin_label_power_mismatch' END,
    CASE WHEN identical_visible_label_count > 1
      THEN 'duplicate_visible_label' END,
    CASE WHEN request_error IS NOT NULL
      THEN 'request_failed' END,
    CASE WHEN request_error IS NULL
        AND quality_status IS DISTINCT FROM 'ready'
      THEN 'status_not_ready' END,
    CASE WHEN request_error IS NULL AND (
        total_monthly_eur IS NULL
        OR depreciation_eur IS NULL
        OR energy_monthly_eur IS NULL
        OR tax_eur IS NULL
        OR insurance_eur IS NULL
        OR maintenance_eur IS NULL
      )
      THEN 'missing_cost_component' END,
    CASE WHEN least(
        depreciation_eur,
        energy_monthly_eur,
        tax_eur,
        insurance_eur,
        maintenance_eur
      ) < 0
      THEN 'negative_cost_component' END,
    CASE WHEN total_monthly_eur IS NOT NULL
        AND depreciation_eur IS NOT NULL
        AND energy_monthly_eur IS NOT NULL
        AND tax_eur IS NOT NULL
        AND insurance_eur IS NOT NULL
        AND maintenance_eur IS NOT NULL
        AND abs(
          total_monthly_eur - (
            depreciation_eur
            + energy_monthly_eur
            + tax_eur
            + insurance_eur
            + maintenance_eur
          )
        ) > 0.10
      THEN 'total_cost_mismatch' END,
    CASE WHEN fuel_type = 'electric'
        AND electric_consumption_kwh_100km IS NULL
      THEN 'electric_consumption_missing' END,
    CASE WHEN fuel_type = 'electric'
        AND thermal_consumption_per_100km IS NOT NULL
        AND thermal_consumption_per_100km > 0
      THEN 'electric_has_thermal_consumption' END,
    CASE WHEN fuel_type <> 'electric'
        AND hybrid_type <> 'plug_in_hybrid'
        AND thermal_consumption_per_100km IS NULL
      THEN 'thermal_consumption_missing' END,
    CASE WHEN fuel_type <> 'electric'
        AND hybrid_type <> 'plug_in_hybrid'
        AND electric_consumption_kwh_100km IS NOT NULL
        AND electric_consumption_kwh_100km > 0
      THEN 'non_plugin_has_grid_consumption' END,
    CASE WHEN hybrid_type = 'plug_in_hybrid'
        AND (
          thermal_consumption_per_100km IS NULL
          OR electric_consumption_kwh_100km IS NULL
        )
      THEN 'plugin_consumption_missing' END,
    CASE WHEN energy_monthly_eur IS NOT NULL
        AND energy_monthly_eur <= 0
      THEN 'nonpositive_energy_cost' END,
    CASE WHEN fuel_type = 'electric'
        AND electricity_price_eur_kwh IS NULL
      THEN 'electricity_price_missing' END,
    CASE WHEN hybrid_type = 'plug_in_hybrid'
        AND electricity_price_eur_kwh IS NULL
      THEN 'plugin_electricity_price_missing' END,
    CASE WHEN fuel_type <> 'electric'
        AND thermal_price_eur IS NULL
      THEN 'thermal_price_missing' END
  ) AS certain_anomaly_codes,
  concat_ws(
    ', ',
    CASE WHEN COALESCE(system_power_kw, power_kw) < 20
        OR COALESCE(system_power_kw, power_kw) > 1000
      THEN 'power_outside_review_range' END,
    CASE WHEN fuel_type = 'electric'
        AND electric_consumption_kwh_100km IS NOT NULL
        AND electric_consumption_kwh_100km NOT BETWEEN 5 AND 60
      THEN 'electric_consumption_outlier' END,
    CASE WHEN hybrid_type = 'plug_in_hybrid'
        AND thermal_consumption_per_100km IS NOT NULL
        AND thermal_consumption_per_100km NOT BETWEEN 0.1 AND 15
      THEN 'plugin_thermal_consumption_outlier' END,
    CASE WHEN hybrid_type = 'plug_in_hybrid'
        AND electric_consumption_kwh_100km IS NOT NULL
        AND electric_consumption_kwh_100km NOT BETWEEN 5 AND 50
      THEN 'plugin_electric_consumption_outlier' END,
    CASE WHEN fuel_type <> 'electric'
        AND hybrid_type <> 'plug_in_hybrid'
        AND thermal_consumption_per_100km IS NOT NULL
        AND thermal_consumption_per_100km NOT BETWEEN 2 AND 35
      THEN 'thermal_consumption_outlier' END,
    CASE WHEN energy_monthly_eur IS NOT NULL
        AND energy_monthly_eur > 800
      THEN 'monthly_energy_cost_outlier' END,
    CASE WHEN energy_method IS NULL
      THEN 'energy_method_missing' END,
    CASE WHEN energy_confidence IS NULL
      THEN 'energy_confidence_missing' END
  ) AS review_codes
FROM audit_technical_parsed_v1 AS parsed;

CREATE INDEX ON audit_technical_classified_v1 (
  certain_anomaly_codes
);
ANALYZE audit_technical_classified_v1;

-- 1. Esito generale.
SELECT
  count(*)::integer AS versioni_controllate,
  count(*) FILTER (
    WHERE certain_anomaly_codes = ''
  )::integer AS versioni_senza_errori,
  count(*) FILTER (
    WHERE certain_anomaly_codes <> ''
  )::integer AS versioni_con_errori_certi,
  count(*) FILTER (
    WHERE review_codes <> ''
  )::integer AS versioni_da_esaminare,
  count(*) FILTER (
    WHERE request_error IS NOT NULL
  )::integer AS richieste_fallite,
  count(*) FILTER (
    WHERE identical_visible_label_count > 1
  )::integer AS righe_con_etichetta_duplicata,
  count(DISTINCT public_model_id) FILTER (
    WHERE identical_visible_label_count > 1
  )::integer AS modelli_con_duplicati,
  count(*) FILTER (
    WHERE hybrid_type = 'plug_in_hybrid'
      AND power_data_status = 'verified'
  )::integer AS plugin_verificate,
  CASE
    WHEN count(*) > 0 THEN 'audit_completato'
    ELSE 'errore'
  END AS verifica
FROM audit_technical_classified_v1;

-- 2. Ripartizione tecnica e distribuzioni utili per leggere gli outlier.
SELECT
  fuel_type,
  hybrid_type,
  count(*)::integer AS versioni,
  round(min(COALESCE(system_power_cv, power_cv)), 1) AS cv_minimi,
  round(
    percentile_cont(0.5) WITHIN GROUP (
      ORDER BY COALESCE(system_power_cv, power_cv)
    )::numeric,
    1
  ) AS cv_mediani,
  round(max(COALESCE(system_power_cv, power_cv)), 1) AS cv_massimi,
  round(min(thermal_consumption_per_100km), 2)
    AS consumo_termico_minimo,
  round(max(thermal_consumption_per_100km), 2)
    AS consumo_termico_massimo,
  round(min(electric_consumption_kwh_100km), 2)
    AS consumo_elettrico_minimo,
  round(max(electric_consumption_kwh_100km), 2)
    AS consumo_elettrico_massimo,
  count(*) FILTER (
    WHERE certain_anomaly_codes <> ''
  )::integer AS errori_certi,
  count(*) FILTER (
    WHERE review_codes <> ''
  )::integer AS da_esaminare
FROM audit_technical_classified_v1
GROUP BY fuel_type, hybrid_type
ORDER BY versioni DESC, fuel_type, hybrid_type;

-- 3. Errori certi, ordinati per marca e modello.
SELECT
  brand,
  model,
  version_label,
  fuel_type,
  hybrid_type,
  power_kw,
  power_cv,
  system_power_cv,
  thermal_power_cv,
  thermal_consumption_per_100km,
  electric_consumption_kwh_100km,
  certain_anomaly_codes,
  request_error
FROM audit_technical_classified_v1
WHERE certain_anomaly_codes <> ''
ORDER BY brand, model, year_from, version_label
LIMIT 150;

-- 4. Valori estremi da esaminare senza correzione automatica.
SELECT
  brand,
  model,
  version_label,
  fuel_type,
  hybrid_type,
  COALESCE(system_power_cv, power_cv) AS displayed_power_cv,
  thermal_consumption_per_100km,
  electric_consumption_kwh_100km,
  energy_monthly_eur,
  energy_method,
  energy_confidence,
  review_codes
FROM audit_technical_classified_v1
WHERE review_codes <> ''
ORDER BY brand, model, year_from, version_label
LIMIT 150;

-- 5. Duplicati esattamente indistinguibili nel dropdown.
SELECT
  public_model_id,
  brand,
  model,
  version_label,
  count(*)::integer AS occorrenze,
  array_agg(
    display_variant_id ORDER BY display_variant_id
  ) AS display_variant_ids,
  array_agg(
    vehicle_cluster_id ORDER BY vehicle_cluster_id
  ) AS vehicle_cluster_ids
FROM audit_technical_classified_v1
WHERE identical_visible_label_count > 1
GROUP BY public_model_id, brand, model, version_label
ORDER BY brand, model, version_label
LIMIT 100;

-- 6. Metodi e affidabilita dell'energia effettivamente usata.
SELECT
  COALESCE(energy_method, '(mancante)') AS metodo_energia,
  COALESCE(energy_confidence, '(mancante)') AS affidabilita,
  count(*)::integer AS versioni,
  count(*) FILTER (
    WHERE certain_anomaly_codes <> ''
  )::integer AS con_errori_certi,
  count(*) FILTER (
    WHERE review_codes <> ''
  )::integer AS da_esaminare
FROM audit_technical_classified_v1
GROUP BY energy_method, energy_confidence
ORDER BY versioni DESC, metodo_energia, affidabilita;

ROLLBACK;
