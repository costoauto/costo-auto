-- Auto TCO - ripristina nell'API gli anni presenti nel database originale.
--
-- Non modifica mvp.vehicle_profiles e non inventa nuovi anni. Annulla soltanto
-- il filtro introdotto da 06_corregge_anni_versioni.sql, tornando a esporre
-- representative_year esattamente come definito nel database di partenza.

BEGIN;

CREATE OR REPLACE FUNCTION public.auto_tco_versions(p_model_id text)
RETURNS jsonb
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public
AS $function$
  SELECT jsonb_build_object(
    'items',
    COALESCE(
      jsonb_agg(
        to_jsonb(item)
        ORDER BY
          item.representative_year DESC NULLS LAST,
          item.registrations_count DESC,
          item.fuel_type,
          item.power_cv NULLS LAST,
          item.vehicle_cluster_id
      ),
      '[]'::jsonb
    )
  )
  FROM (
    SELECT
      catalog.vehicle_cluster_id,
      catalog.model_catalog_id,
      catalog.vehicle_profile_id,
      catalog.seed_model_id,
      catalog.brand,
      catalog.model,
      catalog.version_label,
      profile.representative_year,
      CASE
        WHEN profile.representative_year IS NULL THEN NULL::text
        ELSE 'original_database'
      END AS year_source,
      catalog.fuel_type,
      catalog.hybrid_type,
      catalog.powertrain_type,
      catalog.power_kw,
      catalog.power_cv,
      catalog.energy_data_status,
      catalog.depreciation_data_status,
      catalog.observation_quality,
      catalog.registrations_count
    FROM mvp.site_vehicle_catalog_eea_v2 AS catalog
    LEFT JOIN mvp.vehicle_profiles AS profile
      ON profile.id = catalog.vehicle_profile_id
    WHERE catalog.model_catalog_id = left(trim(p_model_id), 64)
      AND catalog.model_key NOT IN (
        'UNKNOWN', 'UNK', 'NA', 'NULL', 'NOTAVAILABLE'
      )
      AND catalog.model_key <> 'GV80GENESISGV80'
  ) AS item;
$function$;

REVOKE ALL ON FUNCTION public.auto_tco_versions(text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.auto_tco_versions(text) TO anon;

COMMIT;

-- Verifica inclusa: deve terminare con verifica = ok.
WITH model_ids AS (
  SELECT DISTINCT model_catalog_id
  FROM mvp.site_vehicle_catalog_eea_v2
  WHERE model_key NOT IN ('UNKNOWN', 'UNK', 'NA', 'NULL', 'NOTAVAILABLE')
    AND model_key <> 'GV80GENESISGV80'
), api_items AS MATERIALIZED (
  SELECT jsonb_array_elements(
    public.auto_tco_versions(model_ids.model_catalog_id) -> 'items'
  ) AS item
  FROM model_ids
), checked AS (
  SELECT
    count(*)::integer AS versioni_api,
    count(*) FILTER (
      WHERE profile.representative_year IS NOT NULL
    )::integer AS anni_nel_database,
    count(*) FILTER (
      WHERE (api.item ->> 'representative_year') IS NOT NULL
    )::integer AS anni_esposti,
    count(*) FILTER (
      WHERE profile.representative_year IS DISTINCT FROM
            NULLIF(api.item ->> 'representative_year', '')::integer
    )::integer AS differenze
  FROM api_items AS api
  LEFT JOIN mvp.vehicle_profiles AS profile
    ON profile.id = NULLIF(api.item ->> 'vehicle_profile_id', '')::integer
)
SELECT
  versioni_api,
  anni_nel_database,
  anni_esposti,
  differenze,
  CASE
    WHEN versioni_api > 0
      AND anni_nel_database > 0
      AND anni_esposti = anni_nel_database
      AND differenze = 0
      THEN 'ok'
    ELSE 'controllare'
  END AS verifica
FROM checked;
