-- Auto TCO - completa gli anni delle versioni usando il catalogo originale.
--
-- Priorità:
--   1. anno del profilo già collegato alla versione EEA;
--   2. anno del profilo originale compatibile per modello, alimentazione e potenza;
--   3. NULL: nessun anno viene inventato.

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
      COALESCE(
        direct_profile.representative_year,
        compatible_profile.representative_year
      ) AS representative_year,
      CASE
        WHEN direct_profile.representative_year IS NOT NULL
          THEN 'direct_profile'
        WHEN compatible_profile.representative_year IS NOT NULL
          THEN 'compatible_profile'
        ELSE 'missing'
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
    LEFT JOIN mvp.vehicle_profiles AS direct_profile
      ON direct_profile.id = catalog.vehicle_profile_id
    LEFT JOIN LATERAL (
      SELECT original.representative_year
      FROM mvp.site_vehicle_catalog AS original
      WHERE direct_profile.representative_year IS NULL
        AND original.representative_year IS NOT NULL
        AND (
          (
            catalog.seed_model_id IS NOT NULL
            AND original.seed_model_id = catalog.seed_model_id
          )
          OR (
            regexp_replace(
              upper(original.brand), '[^A-Z0-9]+', '', 'g'
            ) = catalog.brand_key
            AND regexp_replace(
              upper(original.model), '[^A-Z0-9]+', '', 'g'
            ) = catalog.model_key
          )
        )
        AND CASE
          WHEN original.fuel_type IN ('petrol/electric', 'petrol')
            THEN 'petrol'
          WHEN original.fuel_type IN ('diesel/electric', 'diesel')
            THEN 'diesel'
          ELSE original.fuel_type
        END = catalog.fuel_type
        AND original.hybrid_type = catalog.hybrid_type
        AND original.power_kw IS NOT NULL
        AND catalog.power_kw IS NOT NULL
        AND abs(original.power_kw - catalog.power_kw)
          <= greatest(5::numeric, catalog.power_kw * 0.10)
      ORDER BY
        CASE
          WHEN catalog.seed_model_id IS NOT NULL
           AND original.seed_model_id = catalog.seed_model_id THEN 0
          ELSE 1
        END,
        abs(original.power_kw - catalog.power_kw),
        original.representative_year DESC,
        CASE original.confidence
          WHEN 'high' THEN 0
          WHEN 'medium' THEN 1
          WHEN 'medium_low' THEN 2
          ELSE 3
        END,
        original.vehicle_profile_id
      LIMIT 1
    ) AS compatible_profile ON true
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

-- Verifica automatica dell'intero catalogo pubblico.
WITH model_ids AS (
  SELECT DISTINCT model_catalog_id
  FROM mvp.site_vehicle_catalog_eea_v2
  WHERE model_key NOT IN ('UNKNOWN', 'UNK', 'NA', 'NULL', 'NOTAVAILABLE')
    AND model_key <> 'GV80GENESISGV80'
), items AS (
  SELECT jsonb_array_elements(
    public.auto_tco_versions(model_ids.model_catalog_id) -> 'items'
  ) AS item
  FROM model_ids
), summary AS (
  SELECT
    count(*)::bigint AS versioni_totali,
    count(*) FILTER (
      WHERE item ->> 'year_source' = 'direct_profile'
    )::bigint AS anni_diretti,
    count(*) FILTER (
      WHERE item ->> 'year_source' = 'compatible_profile'
    )::bigint AS anni_recuperati,
    count(*) FILTER (
      WHERE item ->> 'year_source' = 'missing'
    )::bigint AS anni_mancanti
  FROM items
)
SELECT
  versioni_totali,
  anni_diretti,
  anni_recuperati,
  anni_mancanti,
  round(
    100.0 * (versioni_totali - anni_mancanti)
    / NULLIF(versioni_totali, 0),
    2
  ) AS copertura_percentuale,
  CASE
    WHEN versioni_totali > 0
     AND anni_mancanti < versioni_totali THEN 'ok'
    ELSE 'errore'
  END AS verifica
FROM summary;
