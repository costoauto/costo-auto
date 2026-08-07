\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - audit diagnostico delle sole versioni con consumo debole.
--
-- Non modifica oggetti permanenti e termina con ROLLBACK. Distingue i casi
-- correggibili con fonti pubbliche gia caricate dai casi per cui servirebbe
-- acquisire una nuova fonte. Nessuna confidenza viene promossa in base alla
-- sola somiglianza: gli abbinamenti EEA sono soltanto candidati da verificare.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

CREATE OR REPLACE FUNCTION pg_temp.safe_tco_residual_energy_v1(
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

\echo 'Audit energia residua: estrazione del catalogo pubblico...'

CREATE TEMP TABLE residual_energy_versions_v1
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
)
SELECT DISTINCT ON (
  public_model_id,
  item ->> 'display_variant_id',
  item ->> 'vehicle_cluster_id'
)
  public_model_id,
  item ->> 'brand' AS brand,
  item ->> 'model' AS model,
  item ->> 'version_label' AS version_label,
  item ->> 'display_variant_id' AS display_variant_id,
  item ->> 'vehicle_cluster_id' AS vehicle_cluster_id,
  NULLIF(item ->> 'vehicle_profile_id', '')::integer
    AS vehicle_profile_id,
  item ->> 'fuel_type' AS fuel_type,
  COALESCE(NULLIF(item ->> 'hybrid_type', ''), 'none') AS hybrid_type,
  NULLIF(item ->> 'year_from', '')::integer AS year_from,
  NULLIF(item ->> 'year_to', '')::integer AS year_to,
  NULLIF(item ->> 'power_kw', '')::numeric AS power_kw,
  NULLIF(item ->> 'power_cv', '')::numeric AS power_cv,
  NULLIF(item ->> 'thermal_power_kw', '')::numeric AS thermal_power_kw,
  item
FROM version_item
WHERE NULLIF(item ->> 'display_variant_id', '') IS NOT NULL
  AND NULLIF(item ->> 'vehicle_cluster_id', '') IS NOT NULL
ORDER BY
  public_model_id,
  item ->> 'display_variant_id',
  item ->> 'vehicle_cluster_id',
  NULLIF(item ->> 'year_to', '')::integer DESC NULLS LAST;

CREATE UNIQUE INDEX ON residual_energy_versions_v1 (
  public_model_id,
  display_variant_id,
  vehicle_cluster_id
);
ANALYZE residual_energy_versions_v1;

\echo 'Audit energia residua: calcolo delle versioni...'

CREATE TEMP TABLE residual_energy_results_v1
ON COMMIT DROP
AS
SELECT
  version.*,
  pg_temp.safe_tco_residual_energy_v1(
    version.vehicle_cluster_id,
    version.display_variant_id
  ) AS payload
FROM residual_energy_versions_v1 AS version;

CREATE INDEX ON residual_energy_results_v1 (brand, model);
ANALYZE residual_energy_results_v1;

CREATE TEMP TABLE residual_energy_parsed_v1
ON COMMIT DROP
AS
SELECT
  result.*,
  NULLIF(result.payload ->> '_audit_error', '') AS request_error,
  result.payload #>> '{quality,status}' AS quality_status,
  NULLIF(
    result.payload #>> '{monthly_costs,fuel_or_energy_eur}',
    ''
  )::numeric AS energy_monthly_eur,
  COALESCE(
    NULLIF(
      result.payload #>> '{quality,energy_variant_confidence}',
      ''
    ),
    NULLIF(
      result.payload #>> '{quality,energy_source_confidence}',
      ''
    ),
    NULLIF(
      result.payload #>>
        '{calculation_details,fuel_or_energy,variant_energy_confidence}',
      ''
    ),
    NULLIF(input.confidence, ''),
    NULLIF(profile.energy_input_confidence, ''),
    NULLIF(profile.confidence, ''),
    item ->> 'observation_quality',
    'missing'
  ) AS energy_confidence,
  COALESCE(
    NULLIF(
      result.payload #>> '{calculation_details,fuel_or_energy,method}',
      ''
    ),
    NULLIF(
      result.payload #>> '{quality,energy_source_method}',
      ''
    ),
    NULLIF(input.thermal_method, ''),
    NULLIF(input.electric_method, ''),
    NULLIF(profile.energy_input_source, ''),
    NULLIF(profile.source_type, ''),
    'unknown'
  ) AS energy_method,
  NULLIF(
    result.payload #>>
      '{calculation_details,fuel_or_energy,thermal_consumption_per_100km}',
    ''
  )::numeric AS thermal_consumption_per_100km,
  NULLIF(
    result.payload #>>
      '{calculation_details,fuel_or_energy,electric_consumption_kwh_100km}',
    ''
  )::numeric AS electric_consumption_kwh_100km,
  profile.seed_model_id,
  input.thermal_reference_count,
  input.electric_reference_count,
  input.confidence AS cache_confidence,
  input.thermal_method AS cache_thermal_method,
  input.electric_method AS cache_electric_method
FROM residual_energy_results_v1 AS result
LEFT JOIN mvp.vehicle_profiles AS profile
  ON profile.id = result.vehicle_profile_id
LEFT JOIN mvp.vehicle_cluster_energy_inputs_v1 AS input
  ON input.vehicle_cluster_id = result.vehicle_cluster_id;

CREATE INDEX ON residual_energy_parsed_v1 (
  energy_confidence,
  energy_method
);
ANALYZE residual_energy_parsed_v1;

CREATE TEMP TABLE residual_energy_weak_v1
ON COMMIT DROP
AS
SELECT
  parsed.*,
  provenance.energy_confidence AS historical_provenance_confidence,
  provenance.energy_method AS historical_provenance_method,
  phev.confidence AS phev_verified_confidence,
  phev.source_records AS phev_source_records,
  candidate.energy_method AS candidate_eea_method,
  candidate.confidence AS candidate_eea_confidence,
  candidate.source_records_count AS candidate_eea_records,
  candidate.registrations_count AS candidate_eea_registrations,
  candidate.representative_year AS candidate_eea_year,
  candidate.power_kw AS candidate_eea_power_kw,
  CASE
    WHEN provenance.energy_confidence IN ('high', 'medium')
      THEN 'regressione_provenienza_storica'
    WHEN phev.confidence IN ('high', 'medium')
      THEN 'plugin_verificata_non_applicata'
    WHEN parsed.cache_confidence IN ('high', 'medium')
      THEN 'cache_migliore_non_applicata'
    WHEN candidate.confidence IN ('high', 'medium')
      THEN 'candidato_eea_stesso_modello'
    WHEN parsed.energy_method IN (
      'semiauto_historical_estimate',
      'manual_historical_estimate'
    ) THEN 'storica_da_nuova_fonte'
    WHEN parsed.energy_method = 'modelled_from_existing_vehicle_profiles'
      THEN 'stima_modellata_da_rivedere'
    ELSE 'nessuna_fonte_migliore_gia_presente'
  END AS resolution_path
FROM residual_energy_parsed_v1 AS parsed
LEFT JOIN mvp.historical_energy_provenance_v1 AS provenance
  ON provenance.vehicle_profile_id = parsed.vehicle_profile_id
LEFT JOIN mvp.phev_display_variant_energy_v1 AS phev
  ON phev.display_variant_id = parsed.display_variant_id
LEFT JOIN LATERAL (
  SELECT source.*
  FROM mvp.eea_historical_versions_compact_v1 AS source
  WHERE lower(source.brand) = lower(parsed.brand)
    AND lower(source.model) = lower(parsed.model)
    AND source.fuel_type = parsed.fuel_type
    AND source.hybrid_type = parsed.hybrid_type
    AND source.confidence IN ('high', 'medium')
    AND (
      coalesce(parsed.thermal_power_kw, parsed.power_kw) IS NULL
      OR abs(
        source.power_kw
          - coalesce(parsed.thermal_power_kw, parsed.power_kw)
      ) <= 1.5
    )
    AND source.representative_year BETWEEN
      coalesce(parsed.year_from, parsed.year_to, 2010) - 1
      AND coalesce(parsed.year_to, parsed.year_from, 2025)
  ORDER BY
    CASE source.confidence WHEN 'high' THEN 1 ELSE 2 END,
    CASE
      WHEN source.representative_year BETWEEN
        coalesce(parsed.year_from, source.representative_year)
        AND coalesce(parsed.year_to, source.representative_year)
        THEN 0
      ELSE 1
    END,
    abs(
      source.power_kw
        - coalesce(
          parsed.thermal_power_kw,
          parsed.power_kw,
          source.power_kw
        )
    ),
    source.registrations_count DESC,
    source.source_records_count DESC
  LIMIT 1
) AS candidate ON true
WHERE parsed.energy_confidence IN (
  'medium_low', 'semiauto_low', 'low', 'missing'
);

CREATE INDEX ON residual_energy_weak_v1 (resolution_path);
CREATE INDEX ON residual_energy_weak_v1 (brand, model);
ANALYZE residual_energy_weak_v1;

DO $verification$
DECLARE
  v_versions integer;
  v_failed integer;
  v_not_ready integer;
  v_weak integer;
BEGIN
  SELECT
    count(*),
    count(*) FILTER (WHERE request_error IS NOT NULL),
    count(*) FILTER (WHERE quality_status IS DISTINCT FROM 'ready')
  INTO v_versions, v_failed, v_not_ready
  FROM residual_energy_parsed_v1;

  SELECT count(*) INTO v_weak
  FROM residual_energy_weak_v1;

  IF v_versions < 4500
    OR v_failed <> 0
    OR v_not_ready <> 0
    OR v_weak < 400
    OR v_weak > 700
  THEN
    RAISE EXCEPTION
      'Audit energia residua non valido: versioni %, errori %, non ready %, deboli %',
      v_versions,
      v_failed,
      v_not_ready,
      v_weak;
  END IF;
END;
$verification$;

\echo 'Quadro delle stime energetiche residue'

SELECT
  count(*) AS consumi_deboli,
  count(*) FILTER (
    WHERE resolution_path IN (
      'regressione_provenienza_storica',
      'plugin_verificata_non_applicata',
      'cache_migliore_non_applicata'
    )
  ) AS correzioni_dirette_gia_disponibili,
  count(*) FILTER (
    WHERE resolution_path = 'candidato_eea_stesso_modello'
  ) AS candidati_eea_da_validare,
  count(*) FILTER (
    WHERE resolution_path IN (
      'storica_da_nuova_fonte',
      'stima_modellata_da_rivedere',
      'nessuna_fonte_migliore_gia_presente'
    )
  ) AS richiedono_nuova_fonte_o_restano_stime,
  'ok' AS verifica
FROM residual_energy_weak_v1;

\echo 'Ripartizione per percorso di risoluzione'

SELECT
  resolution_path,
  energy_confidence AS affidabilita_attuale,
  energy_method AS metodo_attuale,
  count(*) AS versioni,
  count(DISTINCT brand || chr(31) || model) AS modelli,
  round(avg(energy_monthly_eur), 2) AS costo_medio_mese
FROM residual_energy_weak_v1
GROUP BY resolution_path, energy_confidence, energy_method
ORDER BY
  CASE resolution_path
    WHEN 'regressione_provenienza_storica' THEN 1
    WHEN 'plugin_verificata_non_applicata' THEN 2
    WHEN 'cache_migliore_non_applicata' THEN 3
    WHEN 'candidato_eea_stesso_modello' THEN 4
    WHEN 'stima_modellata_da_rivedere' THEN 5
    WHEN 'storica_da_nuova_fonte' THEN 6
    ELSE 7
  END,
  versioni DESC;

\echo 'Ripartizione per alimentazione'

SELECT
  fuel_type,
  hybrid_type,
  energy_confidence AS affidabilita,
  count(*) AS versioni,
  round(avg(energy_monthly_eur), 2) AS costo_medio_mese
FROM residual_energy_weak_v1
GROUP BY fuel_type, hybrid_type, energy_confidence
ORDER BY versioni DESC, fuel_type, hybrid_type;

\echo 'Modelli con piu stime residue'

SELECT
  brand,
  model,
  count(*) AS versioni_deboli,
  string_agg(
    DISTINCT energy_method,
    ', ' ORDER BY energy_method
  ) AS metodi,
  string_agg(
    DISTINCT resolution_path,
    ', ' ORDER BY resolution_path
  ) AS percorsi
FROM residual_energy_weak_v1
GROUP BY brand, model
ORDER BY versioni_deboli DESC, brand, model
LIMIT 40;

\echo 'Esempi operativi delle versioni residue'

WITH ranked AS (
  SELECT
    weak.*,
    row_number() OVER (
      PARTITION BY resolution_path
      ORDER BY brand, model, year_from, version_label
    ) AS path_rank
  FROM residual_energy_weak_v1 AS weak
)
SELECT
  brand,
  model,
  version_label,
  fuel_type,
  hybrid_type,
  energy_method AS metodo_attuale,
  energy_confidence AS affidabilita_attuale,
  resolution_path AS percorso,
  candidate_eea_year,
  candidate_eea_power_kw,
  candidate_eea_method,
  candidate_eea_confidence,
  candidate_eea_records,
  candidate_eea_registrations
FROM ranked
WHERE path_rank <= 12
ORDER BY
  CASE resolution_path
    WHEN 'regressione_provenienza_storica' THEN 1
    WHEN 'plugin_verificata_non_applicata' THEN 2
    WHEN 'cache_migliore_non_applicata' THEN 3
    WHEN 'candidato_eea_stesso_modello' THEN 4
    WHEN 'stima_modellata_da_rivedere' THEN 5
    WHEN 'storica_da_nuova_fonte' THEN 6
    ELSE 7
  END,
  brand,
  model,
  year_from,
  version_label;

ROLLBACK;
