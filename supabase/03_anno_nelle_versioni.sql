-- Auto TCO - mostra l'anno direttamente nel menu Versione.
--
-- Eseguire tutto il file nel SQL Editor di Supabase.
-- Non modifica profili, calcoli o catalogo: estende soltanto la risposta
-- pubblica con l'anno rappresentativo già presente nel database.

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

-- Verifica automatica: deve restituire una riga con verifica = ok.
WITH sample_model AS (
  SELECT catalog.model_catalog_id
  FROM mvp.site_vehicle_catalog_eea_v2 AS catalog
  JOIN mvp.vehicle_profiles AS profile
    ON profile.id = catalog.vehicle_profile_id
  WHERE profile.representative_year IS NOT NULL
  ORDER BY catalog.registrations_count DESC
  LIMIT 1
), response AS (
  SELECT public.auto_tco_versions(sample_model.model_catalog_id) AS payload
  FROM sample_model
), items AS (
  SELECT jsonb_array_elements(response.payload -> 'items') AS item
  FROM response
)
SELECT
  count(*)::bigint AS versioni_testate,
  count(*) FILTER (
    WHERE (item ->> 'representative_year') IS NOT NULL
  )::bigint AS versioni_con_anno,
  CASE
    WHEN count(*) > 0
     AND count(*) FILTER (
       WHERE (item ->> 'representative_year') IS NOT NULL
     ) > 0 THEN 'ok'
    ELSE 'errore'
  END AS verifica
FROM items;
