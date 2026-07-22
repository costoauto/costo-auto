-- Auto TCO - amplia il catalogo storico con osservazioni EEA 2010-2024.
--
-- Le righe tecniche EEA vengono raggruppate per modello, anno,
-- alimentazione e potenza. Restano fuori le osservazioni senza potenza,
-- quelle isolate e i duplicati gia presenti nel database originale.

\set ON_ERROR_STOP on

BEGIN;

SET LOCAL statement_timeout = '30min';

CREATE TABLE IF NOT EXISTS mvp.eea_historical_versions_compact_v1 (
  historical_version_id text PRIMARY KEY,
  seed_model_id integer NOT NULL,
  brand text NOT NULL,
  model text NOT NULL,
  representative_year integer NOT NULL,
  fuel_type text NOT NULL,
  hybrid_type text NOT NULL,
  power_kw numeric,
  power_cv integer,
  euro_class integer NOT NULL,
  consumption_l_100km numeric,
  electric_consumption_kwh_100km numeric,
  registrations_count bigint NOT NULL,
  source_records_count integer NOT NULL,
  confidence text NOT NULL,
  energy_method text NOT NULL,
  imported_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT eea_historical_versions_year_check
    CHECK (representative_year BETWEEN 2010 AND 2024),
  CONSTRAINT eea_historical_versions_power_check
    CHECK (power_kw > 0),
  CONSTRAINT eea_historical_versions_registrations_check
    CHECK (registrations_count >= 3)
);

COMMENT ON TABLE mvp.eea_historical_versions_compact_v1 IS
'Versioni storiche compatte ricavate dalle immatricolazioni italiane EEA 2010-2024; non contiene le righe grezze di omologazione.';

REVOKE ALL ON TABLE mvp.eea_historical_versions_compact_v1
  FROM PUBLIC, anon, authenticated;

TRUNCATE TABLE mvp.eea_historical_versions_compact_v1;

\ir 14_catalogo_storico_eea_data.sql

CREATE INDEX IF NOT EXISTS idx_eea_historical_versions_seed_year
  ON mvp.eea_historical_versions_compact_v1 (
    seed_model_id,
    representative_year DESC
  );

ANALYZE mvp.eea_historical_versions_compact_v1;

-- Rende inattiva soltanto un'eventuale generazione precedente di questa
-- stessa importazione. I profili originali e quelli recenti non si toccano.
UPDATE mvp.vehicle_profiles
SET profile_status = 'superseded'
WHERE profile_kind = 'eea_historical_compact_v1'
  AND profile_status = 'active';

WITH candidate AS (
  SELECT
    source.*,
    seed.brand AS canonical_brand,
    seed.model AS canonical_model
  FROM mvp.eea_historical_versions_compact_v1 AS source
  JOIN mvp.italy_popular_models_seed AS seed
    ON seed.id = source.seed_model_id
  WHERE source.power_kw IS NOT NULL
    AND NOT EXISTS (
      SELECT 1
      FROM mvp.vehicle_profiles AS existing
      WHERE existing.profile_status = 'active'
        AND existing.profile_kind <> 'eea_historical_compact_v1'
        AND existing.seed_model_id = source.seed_model_id
        AND existing.representative_year = source.representative_year
        AND existing.fuel_type = source.fuel_type
        AND COALESCE(existing.hybrid_type, 'none') = source.hybrid_type
        AND (
          existing.power_kw IS NOT NULL
          AND abs(existing.power_kw - source.power_kw) <= 1
        )
    )
), comparable AS (
  SELECT
    candidate.*,
    same_model.id AS same_model_reference_id,
    same_brand.id AS same_brand_reference_id,
    COALESCE(
      same_model.estimated_new_price_eur,
      same_brand.estimated_new_price_eur
    ) AS estimated_new_price_eur,
    COALESCE(same_model.segment, same_brand.segment) AS segment,
    COALESCE(same_model.body_type, same_brand.body_type) AS body_type,
    COALESCE(same_model.brand_tier, same_brand.brand_tier) AS brand_tier,
    COALESCE(
      same_model.depreciation_category,
      same_brand.depreciation_category
    ) AS depreciation_category,
    COALESCE(
      same_model.depreciation_brand_factor,
      same_brand.depreciation_brand_factor,
      1
    ) AS depreciation_brand_factor
  FROM candidate
  LEFT JOIN LATERAL (
    SELECT profile.*
    FROM mvp.vehicle_profiles AS profile
    WHERE profile.profile_status = 'active'
      AND profile.profile_kind <> 'eea_historical_compact_v1'
      AND profile.seed_model_id = candidate.seed_model_id
      AND profile.estimated_new_price_eur > 0
    ORDER BY
      CASE WHEN profile.fuel_type = candidate.fuel_type THEN 0 ELSE 1 END,
      CASE
        WHEN COALESCE(profile.hybrid_type, 'none') = candidate.hybrid_type
          THEN 0
        ELSE 1
      END,
      abs(COALESCE(profile.representative_year, candidate.representative_year)
        - candidate.representative_year),
      abs(COALESCE(profile.power_kw, candidate.power_kw) - candidate.power_kw),
      profile.id
    LIMIT 1
  ) AS same_model ON true
  LEFT JOIN LATERAL (
    SELECT profile.*
    FROM mvp.vehicle_profiles AS profile
    WHERE same_model.id IS NULL
      AND profile.profile_status = 'active'
      AND profile.profile_kind <> 'eea_historical_compact_v1'
      AND lower(profile.brand) = lower(candidate.canonical_brand)
      AND profile.estimated_new_price_eur > 0
    ORDER BY
      CASE WHEN profile.fuel_type = candidate.fuel_type THEN 0 ELSE 1 END,
      CASE
        WHEN COALESCE(profile.hybrid_type, 'none') = candidate.hybrid_type
          THEN 0
        ELSE 1
      END,
      abs(COALESCE(profile.power_kw, candidate.power_kw) - candidate.power_kw),
      profile.id
    LIMIT 1
  ) AS same_brand ON true
)
INSERT INTO mvp.vehicle_profiles (
  display_name,
  brand,
  model,
  representative_year,
  year_from,
  year_to,
  fuel_type,
  hybrid_type,
  power_kw,
  power_cv,
  segment,
  body_type,
  brand_tier,
  consumption_l_100km,
  electric_consumption_kwh_100km,
  electric_range_km,
  phev_electric_share_default,
  annual_tax_estimate_eur,
  annual_insurance_estimate_eur,
  annual_maintenance_estimate_eur,
  confidence,
  source_notes,
  seed_model_id,
  profile_kind,
  source_type,
  source_records_count,
  popularity_score,
  profile_status,
  euro_class,
  phev_thermal_consumption_l_100km,
  annual_depreciation_estimate_eur,
  estimated_new_price_eur,
  depreciation_category,
  depreciation_brand_factor,
  depreciation_notes,
  uncertainty_profile_kind
)
SELECT
  concat_ws(
    ' ',
    comparable.canonical_brand,
    comparable.canonical_model,
    comparable.representative_year::text,
    CASE
      WHEN comparable.fuel_type = 'electric' THEN 'elettrica'
      WHEN comparable.hybrid_type = 'plug_in_hybrid' THEN 'plug-in'
      WHEN comparable.hybrid_type = 'hybrid' THEN 'ibrida'
      WHEN comparable.fuel_type = 'diesel' THEN 'diesel'
      WHEN comparable.fuel_type = 'petrol' THEN 'benzina'
      WHEN comparable.fuel_type = 'lpg' THEN 'GPL'
      WHEN comparable.fuel_type = 'ng' THEN 'metano'
      ELSE comparable.fuel_type
    END,
    comparable.power_cv::text || ' CV'
  ),
  comparable.canonical_brand,
  comparable.canonical_model,
  comparable.representative_year,
  comparable.representative_year,
  comparable.representative_year,
  comparable.fuel_type,
  comparable.hybrid_type,
  comparable.power_kw,
  comparable.power_cv,
  comparable.segment,
  comparable.body_type,
  comparable.brand_tier,
  comparable.consumption_l_100km,
  comparable.electric_consumption_kwh_100km,
  NULL,
  0.40,
  NULL,
  NULL,
  NULL,
  CASE
    WHEN comparable.same_model_reference_id IS NOT NULL
      AND comparable.confidence IN ('high', 'medium_high') THEN 'medium'
    WHEN comparable.same_model_reference_id IS NOT NULL THEN 'medium_low'
    ELSE 'low'
  END,
  format(
    'Profilo storico compatto da %s righe EEA e %s immatricolazioni italiane; energia: %s.',
    comparable.source_records_count,
    comparable.registrations_count,
    comparable.energy_method
  ),
  comparable.seed_model_id,
  'eea_historical_compact_v1',
  'eea_co2_monitoring_italy_2010_2024_compact',
  comparable.source_records_count,
  comparable.registrations_count,
  'active',
  comparable.euro_class,
  CASE
    WHEN comparable.hybrid_type = 'plug_in_hybrid'
      THEN comparable.consumption_l_100km
    ELSE NULL
  END,
  NULL,
  comparable.estimated_new_price_eur,
  comparable.depreciation_category,
  comparable.depreciation_brand_factor,
  format(
    'Prezzo da nuovo ereditato dal profilo comparabile %s; la curva di svalutazione resta quella interna gia usata dal sito.',
    COALESCE(
      comparable.same_model_reference_id,
      comparable.same_brand_reference_id
    )
  ),
  'historical_semiauto_mvp'
FROM comparable
WHERE comparable.estimated_new_price_eur > 0;

COMMENT ON COLUMN mvp.vehicle_profiles.profile_kind IS
'Tipo di profilo; eea_historical_compact_v1 identifica le versioni storiche EEA raggruppate e non sostituisce i profili originali.';

-- Nasconde i duplicati visivi: a parita di anno/alimentazione/potenza,
-- precedenza al cluster recente, poi al profilo originale, infine al nuovo
-- profilo storico EEA.
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
    FROM mvp.site_vehicle_catalog_unified_v1 AS catalog
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

REVOKE ALL ON FUNCTION public.auto_tco_versions(text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.auto_tco_versions(text) TO anon;

COMMIT;

NOTIFY pgrst, 'reload schema';

-- Verifica inclusa: copertura generale, Serie 3 e un calcolo storico reale.
WITH profile_stats AS (
  SELECT
    count(*)::integer AS profili_storici_aggiunti,
    count(DISTINCT seed_model_id)::integer AS modelli_ampliati,
    count(*) FILTER (
      WHERE consumption_l_100km IS NOT NULL
         OR electric_consumption_kwh_100km IS NOT NULL
    )::integer AS profili_con_energia,
    count(*) FILTER (
      WHERE estimated_new_price_eur IS NOT NULL
    )::integer AS profili_con_svalutazione
  FROM mvp.vehicle_profiles
  WHERE profile_kind = 'eea_historical_compact_v1'
    AND profile_status = 'active'
), bmw_model AS (
  SELECT item ->> 'model_catalog_id' AS model_catalog_id
  FROM LATERAL jsonb_array_elements(
    public.auto_tco_models('BMW') -> 'items'
  ) AS models(item)
  WHERE lower(item ->> 'model') IN ('3 series', 'serie 3')
  LIMIT 1
), bmw_versions AS (
  SELECT item
  FROM bmw_model
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(model_catalog_id) -> 'items'
  ) AS versions(item)
), bmw_stats AS (
  SELECT
    count(*)::integer AS versioni_serie_3_totali,
    count(*) FILTER (
      WHERE (item ->> 'display_year')::integer BETWEEN 2013 AND 2024
    )::integer AS versioni_serie_3_2013_2024,
    count(DISTINCT (item ->> 'display_year')::integer) FILTER (
      WHERE (item ->> 'display_year')::integer BETWEEN 2013 AND 2024
    )::integer AS anni_serie_3_coperti
  FROM bmw_versions
), sample_profile AS (
  SELECT id
  FROM mvp.vehicle_profiles
  WHERE profile_kind = 'eea_historical_compact_v1'
    AND profile_status = 'active'
    AND seed_model_id = 14
    AND representative_year = 2020
  ORDER BY popularity_score DESC, id
  LIMIT 1
), sample_result AS (
  SELECT public.auto_tco_estimate(
    'profile:' || id::text,
    15000,
    5,
    'italia'
  ) AS payload
  FROM sample_profile
)
SELECT
  profile_stats.*,
  bmw_stats.*,
  (SELECT payload #>> '{vehicle,brand}' FROM sample_result)
    AS esempio_marca,
  (SELECT payload #>> '{vehicle,model}' FROM sample_result)
    AS esempio_modello,
  (SELECT payload #>> '{vehicle,representative_year}' FROM sample_result)
    AS esempio_anno,
  (SELECT payload #>> '{quality,status}' FROM sample_result)
    AS esempio_stato,
  (SELECT payload #>> '{monthly_costs,total_monthly_eur}' FROM sample_result)
    AS esempio_totale_mensile,
  CASE
    WHEN profile_stats.profili_storici_aggiunti >= 5000
      AND profile_stats.modelli_ampliati >= 200
      AND profile_stats.profili_con_energia
        = profile_stats.profili_storici_aggiunti
      AND profile_stats.profili_con_svalutazione
        = profile_stats.profili_storici_aggiunti
      AND bmw_stats.versioni_serie_3_2013_2024 >= 80
      AND bmw_stats.anni_serie_3_coperti = 12
      AND (SELECT payload #>> '{quality,status}' FROM sample_result) = 'ready'
      THEN 'ok'
    ELSE 'controllare'
  END AS verifica
FROM profile_stats
CROSS JOIN bmw_stats;

