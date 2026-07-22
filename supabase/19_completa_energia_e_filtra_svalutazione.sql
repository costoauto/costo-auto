-- Auto TCO - completa i consumi dei profili collegati e pubblica solo
-- versioni per cui il costo totale puo essere calcolato.
--
-- Energia: usa gli input gia risolti e tracciati del cluster EEA collegato.
-- Svalutazione: non crea confronti fra marche diverse, gia giudicati troppo
-- imprecisi dal backtest; le versioni senza un prezzo comparabile affidabile
-- restano nel database ma non vengono proposte nel menu del sito.

\set ON_ERROR_STOP on

BEGIN;

ALTER TABLE mvp.vehicle_profiles
  ADD COLUMN IF NOT EXISTS energy_input_source text;

ALTER TABLE mvp.vehicle_profiles
  ADD COLUMN IF NOT EXISTS energy_input_confidence text;

COMMENT ON COLUMN mvp.vehicle_profiles.energy_input_source IS
  'Provenienza dell eventuale consumo energetico integrato nel profilo.';

COMMENT ON COLUMN mvp.vehicle_profiles.energy_input_confidence IS
  'Affidabilita dell eventuale consumo energetico integrato nel profilo.';

WITH resolved AS (
  SELECT DISTINCT ON (mapping.vehicle_profile_id)
    mapping.vehicle_profile_id,
    inputs.thermal_consumption_per_100km,
    inputs.electric_consumption_kwh_100km,
    inputs.thermal_method,
    inputs.electric_method,
    inputs.confidence
  FROM mvp.vehicle_cluster_depreciation_profile_v1 AS mapping
  JOIN mvp.vehicle_cluster_energy_inputs_v1 AS inputs
    ON inputs.vehicle_cluster_id = mapping.vehicle_cluster_id
  WHERE inputs.input_status = 'ready'
  ORDER BY
    mapping.vehicle_profile_id,
    CASE inputs.confidence
      WHEN 'high' THEN 1
      WHEN 'medium' THEN 2
      WHEN 'medium_low' THEN 3
      WHEN 'low' THEN 4
      ELSE 5
    END,
    mapping.vehicle_cluster_id
)
UPDATE mvp.vehicle_profiles AS profile
SET
  consumption_l_100km = CASE
    WHEN profile.hybrid_type = 'plug_in_hybrid' THEN COALESCE(
      profile.consumption_l_100km,
      resolved.thermal_consumption_per_100km
    )
    ELSE profile.consumption_l_100km
  END,
  phev_thermal_consumption_l_100km = CASE
    WHEN profile.hybrid_type = 'plug_in_hybrid' THEN COALESCE(
      profile.phev_thermal_consumption_l_100km,
      profile.consumption_l_100km,
      resolved.thermal_consumption_per_100km
    )
    ELSE profile.phev_thermal_consumption_l_100km
  END,
  electric_consumption_kwh_100km = CASE
    WHEN profile.fuel_type = 'electric'
      OR profile.hybrid_type = 'plug_in_hybrid' THEN COALESCE(
        profile.electric_consumption_kwh_100km,
        resolved.electric_consumption_kwh_100km
      )
    ELSE profile.electric_consumption_kwh_100km
  END,
  energy_input_source = 'vehicle_cluster_energy_inputs_v1',
  energy_input_confidence = resolved.confidence,
  source_notes = concat_ws(
    ' ',
    NULLIF(btrim(profile.source_notes), ''),
    format(
      'Consumi mancanti integrati dal cluster EEA collegato: termico=%s, elettrico=%s, affidabilita=%s.',
      COALESCE(resolved.thermal_method, 'non applicabile'),
      COALESCE(resolved.electric_method, 'non applicabile'),
      resolved.confidence
    )
  )
FROM resolved
WHERE profile.id = resolved.vehicle_profile_id
  AND profile.profile_status = 'active'
  AND (
    (
      profile.fuel_type = 'electric'
      AND profile.electric_consumption_kwh_100km IS NULL
      AND resolved.electric_consumption_kwh_100km IS NOT NULL
    )
    OR (
      profile.hybrid_type = 'plug_in_hybrid'
      AND (
        COALESCE(
          profile.phev_thermal_consumption_l_100km,
          profile.consumption_l_100km
        ) IS NULL
        OR profile.electric_consumption_kwh_100km IS NULL
      )
      AND resolved.thermal_consumption_per_100km IS NOT NULL
      AND resolved.electric_consumption_kwh_100km IS NOT NULL
    )
  );

-- Una versione recente e pubblicabile solo se possiede una svalutazione
-- originale oppure un collegamento a una stima costruita da stessa marca o
-- stesso modello. I profili originali e lo storico EEA restano pubblicabili.
CREATE OR REPLACE VIEW mvp.site_vehicle_catalog_publishable_v1 AS
SELECT catalog.*
FROM mvp.site_vehicle_catalog_unified_v1 AS catalog
WHERE catalog.source_kind <> 'eea_current'
   OR catalog.depreciation_data_status <> 'missing'
   OR EXISTS (
     SELECT 1
     FROM mvp.vehicle_cluster_depreciation_profile_v1 AS mapping
     WHERE mapping.vehicle_cluster_id = catalog.vehicle_cluster_id
   );

COMMENT ON VIEW mvp.site_vehicle_catalog_publishable_v1 IS
  'Catalogo del sito limitato alle versioni con dati sufficienti a calcolare un totale TCO completo.';

REVOKE ALL ON mvp.site_vehicle_catalog_publishable_v1
  FROM PUBLIC, anon, authenticated;

CREATE OR REPLACE FUNCTION public.auto_tco_brands()
RETURNS jsonb
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public
AS $function$
  SELECT jsonb_build_object(
    'items',
    COALESCE(jsonb_agg(to_jsonb(item) ORDER BY item.brand), '[]'::jsonb)
  )
  FROM (
    SELECT brand_key, min(brand) AS brand
    FROM mvp.site_vehicle_catalog_publishable_v1
    GROUP BY brand_key
  ) AS item;
$function$;

CREATE OR REPLACE FUNCTION public.auto_tco_models(p_brand_key text)
RETURNS jsonb
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public
AS $function$
  SELECT jsonb_build_object(
    'items',
    COALESCE(jsonb_agg(to_jsonb(item) ORDER BY item.model), '[]'::jsonb)
  )
  FROM (
    SELECT
      model_catalog_id,
      brand_key,
      min(seed_model_id) AS seed_model_id,
      min(brand) AS brand,
      model_key,
      min(model) AS model
    FROM mvp.site_vehicle_catalog_publishable_v1
    WHERE brand_key = left(trim(p_brand_key), 60)
    GROUP BY model_catalog_id, brand_key, model_key
  ) AS item;
$function$;

CREATE OR REPLACE FUNCTION public.auto_tco_versions(p_model_id text)
RETURNS jsonb
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public
AS $function$
  WITH ranked AS (
    SELECT
      catalog.*,
      row_number() OVER (
        PARTITION BY
          catalog.model_catalog_id,
          catalog.display_year,
          catalog.fuel_type,
          catalog.hybrid_type,
          COALESCE(round(catalog.power_kw)::integer, -1)
        ORDER BY
          CASE
            WHEN catalog.source_kind = 'eea_current' THEN 0
            WHEN profile.profile_kind = 'eea_historical_compact_v1' THEN 2
            ELSE 1
          END,
          catalog.registrations_count DESC,
          catalog.vehicle_cluster_id
      ) AS duplicate_rank
    FROM mvp.site_vehicle_catalog_publishable_v1 AS catalog
    LEFT JOIN mvp.vehicle_profiles AS profile
      ON profile.id = catalog.vehicle_profile_id
    WHERE catalog.model_catalog_id = left(trim(p_model_id), 64)
  ), item AS (
    SELECT
      vehicle_cluster_id,
      model_catalog_id,
      vehicle_profile_id,
      seed_model_id,
      brand,
      model,
      version_label,
      representative_year,
      display_year,
      year_source,
      year_confidence,
      fuel_type,
      hybrid_type,
      powertrain_type,
      power_kw,
      power_cv,
      energy_data_status,
      depreciation_data_status,
      observation_quality,
      registrations_count
    FROM ranked
    WHERE duplicate_rank = 1
  )
  SELECT jsonb_build_object(
    'items',
    COALESCE(
      jsonb_agg(
        to_jsonb(item)
        ORDER BY
          item.display_year DESC,
          item.registrations_count DESC,
          item.fuel_type,
          item.power_cv NULLS LAST,
          item.vehicle_cluster_id
      ),
      '[]'::jsonb
    )
  )
  FROM item;
$function$;

REVOKE ALL ON FUNCTION public.auto_tco_brands() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.auto_tco_models(text) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.auto_tco_versions(text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.auto_tco_brands() TO anon;
GRANT EXECUTE ON FUNCTION public.auto_tco_models(text) TO anon;
GRANT EXECUTE ON FUNCTION public.auto_tco_versions(text) TO anon;

COMMIT;

NOTIFY pgrst, 'reload schema';

-- Verifica integrata.
CREATE TEMP TABLE auto_tco_migration_19_check AS
WITH coverage AS (
  SELECT
    count(*)::integer AS catalogo_completo,
    count(*) FILTER (
      WHERE source_kind = 'eea_current'
        AND depreciation_data_status = 'missing'
        AND NOT EXISTS (
          SELECT 1
          FROM mvp.vehicle_cluster_depreciation_profile_v1 AS mapping
          WHERE mapping.vehicle_cluster_id = catalog.vehicle_cluster_id
        )
    )::integer AS versioni_nascoste_senza_svalutazione
  FROM mvp.site_vehicle_catalog_unified_v1 AS catalog
), published AS (
  SELECT count(*)::integer AS versioni_pubblicate
  FROM mvp.site_vehicle_catalog_publishable_v1
), energy AS (
  SELECT
    count(*) FILTER (
      WHERE energy_input_source = 'vehicle_cluster_energy_inputs_v1'
    )::integer AS profili_energia_integrata,
    count(*) FILTER (
      WHERE profile_status = 'active'
        AND (
          (fuel_type = 'electric' AND electric_consumption_kwh_100km IS NULL)
          OR (
            hybrid_type = 'plug_in_hybrid'
            AND (
              COALESCE(
                phev_thermal_consumption_l_100km,
                consumption_l_100km
              ) IS NULL
              OR electric_consumption_kwh_100km IS NULL
            )
          )
        )
        AND id IN (
          SELECT vehicle_profile_id
          FROM mvp.vehicle_cluster_depreciation_profile_v1
        )
    )::integer AS profili_energia_ancora_mancante
  FROM mvp.vehicle_profiles
), sample_results AS (
  SELECT
    public.auto_tco_estimate('profile:1957', 15000, 5, 'italia')
      AS junior,
    public.auto_tco_estimate('profile:1377', 15000, 5, 'italia')
      AS tonale
)
SELECT
  coverage.catalogo_completo,
  published.versioni_pubblicate,
  coverage.versioni_nascoste_senza_svalutazione,
  energy.profili_energia_integrata,
  energy.profili_energia_ancora_mancante,
  sample_results.junior #>> '{vehicle,version_label}' AS esempio_elettrica,
  sample_results.junior #>> '{monthly_costs,fuel_or_energy_eur}'
    AS energia_elettrica_mese,
  sample_results.junior #>> '{monthly_costs,total_monthly_eur}'
    AS totale_elettrica,
  sample_results.tonale #>> '{vehicle,version_label}' AS esempio_plugin,
  sample_results.tonale #>> '{monthly_costs,fuel_or_energy_eur}'
    AS energia_plugin_mese,
  sample_results.tonale #>> '{monthly_costs,total_monthly_eur}'
    AS totale_plugin,
  CASE
    WHEN coverage.versioni_nascoste_senza_svalutazione > 0
      AND published.versioni_pubblicate
        = coverage.catalogo_completo
          - coverage.versioni_nascoste_senza_svalutazione
      AND energy.profili_energia_integrata >= 48
      AND energy.profili_energia_ancora_mancante = 0
      AND sample_results.junior #>> '{monthly_costs,total_monthly_eur}'
        IS NOT NULL
      AND sample_results.tonale #>> '{monthly_costs,total_monthly_eur}'
        IS NOT NULL
    THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM coverage
CROSS JOIN published
CROSS JOIN energy
CROSS JOIN sample_results;

DO $verify$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM auto_tco_migration_19_check
    WHERE verifica = 'ok'
  ) THEN
    RAISE EXCEPTION 'Verifica copertura componenti TCO fallita';
  END IF;
END;
$verify$;

TABLE auto_tco_migration_19_check;

DROP TABLE auto_tco_migration_19_check;
