-- Auto TCO - accorpa nel dropdown gli anni consecutivi della stessa versione.
--
-- Esempio:
--   2012 · Benzina · 50 CV
--   2013 · Benzina · 50 CV
--   2014 · Benzina · 50 CV
-- diventa:
--   2012-2014 · Benzina · 50 CV
--
-- Il calcolo continua a ricevere un vehicle_cluster_id reale. Per ogni
-- intervallo viene scelto il profilo completo piu vicino all'anno centrale.

BEGIN;

SET LOCAL statement_timeout = '15min';

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
      COALESCE(catalog.fuel_type, 'unknown') AS fuel_key,
      COALESCE(catalog.hybrid_type, 'none') AS hybrid_key,
      COALESCE(round(catalog.power_kw)::integer, -1) AS power_key,
      row_number() OVER (
        PARTITION BY
          catalog.model_catalog_id,
          catalog.display_year,
          COALESCE(catalog.fuel_type, 'unknown'),
          COALESCE(catalog.hybrid_type, 'none'),
          COALESCE(round(catalog.power_kw)::integer, -1)
        ORDER BY
          CASE
            WHEN catalog.source_kind = 'eea_current' THEN 0
            WHEN profile.profile_kind = 'eea_historical_compact_v1' THEN 2
            ELSE 1
          END,
          CASE WHEN catalog.energy_data_status = 'ready' THEN 0 ELSE 1 END,
          CASE
            WHEN catalog.depreciation_data_status <> 'missing' THEN 0
            ELSE 1
          END,
          catalog.registrations_count DESC,
          catalog.vehicle_cluster_id
      ) AS duplicate_rank
    FROM mvp.site_vehicle_catalog_publishable_v1 AS catalog
    LEFT JOIN mvp.vehicle_profiles AS profile
      ON profile.id = catalog.vehicle_profile_id
    WHERE catalog.model_catalog_id = left(trim(p_model_id), 64)
      AND catalog.display_year BETWEEN 1900 AND 2100
  ), yearly_versions AS (
    SELECT *
    FROM ranked
    WHERE duplicate_rank = 1
  ), sequenced AS (
    SELECT
      yearly_versions.*,
      display_year
        - row_number() OVER (
            PARTITION BY
              model_catalog_id,
              fuel_key,
              hybrid_key,
              power_key
            ORDER BY display_year
          )::integer AS year_island
    FROM yearly_versions
  ), ranged AS (
    SELECT
      sequenced.*,
      min(display_year) OVER (
        PARTITION BY
          model_catalog_id,
          fuel_key,
          hybrid_key,
          power_key,
          year_island
      ) AS year_from,
      max(display_year) OVER (
        PARTITION BY
          model_catalog_id,
          fuel_key,
          hybrid_key,
          power_key,
          year_island
      ) AS year_to,
      count(*) OVER (
        PARTITION BY
          model_catalog_id,
          fuel_key,
          hybrid_key,
          power_key,
          year_island
      )::integer AS years_in_range,
      sum(registrations_count) OVER (
        PARTITION BY
          model_catalog_id,
          fuel_key,
          hybrid_key,
          power_key,
          year_island
      ) AS registrations_in_range
    FROM sequenced
  ), representatives AS (
    SELECT
      ranged.*,
      row_number() OVER (
        PARTITION BY
          model_catalog_id,
          fuel_key,
          hybrid_key,
          power_key,
          year_island
        ORDER BY
          CASE WHEN energy_data_status = 'ready' THEN 0 ELSE 1 END,
          CASE
            WHEN depreciation_data_status <> 'missing' THEN 0
            ELSE 1
          END,
          abs(display_year - ((year_from + year_to) / 2.0)),
          CASE observation_quality
            WHEN 'high' THEN 0
            WHEN 'medium_high' THEN 1
            WHEN 'medium' THEN 2
            WHEN 'medium_low' THEN 3
            WHEN 'low' THEN 4
            ELSE 5
          END,
          registrations_count DESC,
          vehicle_cluster_id
      ) AS representative_rank
    FROM ranged
  ), item AS (
    SELECT
      vehicle_cluster_id,
      model_catalog_id,
      vehicle_profile_id,
      seed_model_id,
      brand,
      model,
      CASE
        WHEN year_from = year_to THEN year_from::text
        ELSE year_from::text || '-' || year_to::text
      END
        || ' · '
        || CASE
          WHEN hybrid_type = 'plug_in_hybrid' THEN
            'Ibrida plug-in '
            || CASE fuel_type
              WHEN 'diesel' THEN 'diesel'
              ELSE 'benzina'
            END
          WHEN hybrid_type = 'hybrid' THEN
            'Ibrida '
            || CASE fuel_type
              WHEN 'diesel' THEN 'diesel'
              ELSE 'benzina'
            END
          WHEN powertrain_type = 'electric' OR fuel_type = 'electric'
            THEN 'Elettrica'
          WHEN fuel_type = 'petrol' THEN 'Benzina'
          WHEN fuel_type = 'diesel' THEN 'Diesel'
          WHEN fuel_type = 'lpg' THEN 'GPL'
          WHEN fuel_type = 'ng' THEN 'Metano'
          ELSE initcap(COALESCE(fuel_type, 'Alimentazione non specificata'))
        END
        || CASE
          WHEN power_cv IS NULL THEN ''
          ELSE ' · ' || round(power_cv)::integer::text || ' CV'
        END AS version_label,
      representative_year,
      display_year,
      year_from,
      year_to,
      years_in_range,
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
      registrations_count,
      registrations_in_range
    FROM representatives
    WHERE representative_rank = 1
  )
  SELECT jsonb_build_object(
    'items',
    COALESCE(
      jsonb_agg(
        to_jsonb(item)
        ORDER BY
          item.year_to DESC,
          item.year_from DESC,
          item.registrations_in_range DESC,
          item.fuel_type,
          item.power_cv NULLS LAST,
          item.vehicle_cluster_id
      ),
      '[]'::jsonb
    )
  )
  FROM item;
$function$;

COMMENT ON FUNCTION public.auto_tco_versions(text) IS
'Restituisce una voce per ogni intervallo continuo di anni con uguale alimentazione, tipo ibrido e potenza; mantiene un cluster reale rappresentativo per il calcolo.';

REVOKE ALL ON FUNCTION public.auto_tco_versions(text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.auto_tco_versions(text) TO anon;

COMMIT;

NOTIFY pgrst, 'reload schema';

-- Verifica integrata: controlla Panda e BMW Serie 3 senza modificare i dati.
WITH test_models AS (
  SELECT DISTINCT ON (brand_key, model_key)
    brand,
    model,
    model_catalog_id
  FROM mvp.site_vehicle_catalog_publishable_v1
  WHERE
    (brand_key = 'FIAT' AND model_key = 'PANDA')
    OR (
      brand_key = 'BMW'
      AND model_key IN ('3SERIES', 'SERIE3')
    )
  ORDER BY brand_key, model_key, registrations_count DESC
), extracted AS (
  SELECT
    test_models.brand,
    test_models.model,
    version
  FROM test_models
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(test_models.model_catalog_id) -> 'items'
  ) AS version
), checks AS (
  SELECT
    count(*)::integer AS versioni_mostrate,
    count(*) FILTER (
      WHERE (version ->> 'year_from')::integer
        < (version ->> 'year_to')::integer
    )::integer AS intervalli_pluriennali,
    count(*) FILTER (
      WHERE (version ->> 'year_from')::integer
        > (version ->> 'year_to')::integer
    )::integer AS intervalli_invertiti,
    count(*) FILTER (
      WHERE COALESCE(version ->> 'vehicle_cluster_id', '') = ''
    )::integer AS id_calcolo_mancanti,
    count(*) FILTER (
      WHERE COALESCE(version ->> 'version_label', '')
        !~ '^[0-9]{4}(-[0-9]{4})? · '
    )::integer AS etichette_non_valide
  FROM extracted
)
SELECT
  versioni_mostrate,
  intervalli_pluriennali,
  intervalli_invertiti,
  id_calcolo_mancanti,
  etichette_non_valide,
  CASE
    WHEN versioni_mostrate > 0
      AND intervalli_pluriennali > 0
      AND intervalli_invertiti = 0
      AND id_calcolo_mancanti = 0
      AND etichette_non_valide = 0
      THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM checks;

WITH panda_model AS (
  SELECT model_catalog_id
  FROM mvp.site_vehicle_catalog_publishable_v1
  WHERE brand_key = 'FIAT'
    AND model_key = 'PANDA'
  ORDER BY registrations_count DESC
  LIMIT 1
)
SELECT
  version ->> 'version_label' AS esempio_panda,
  version ->> 'vehicle_cluster_id' AS id_calcolo,
  version ->> 'display_year' AS anno_rappresentativo
FROM panda_model
CROSS JOIN LATERAL jsonb_array_elements(
  public.auto_tco_versions(panda_model.model_catalog_id) -> 'items'
) AS version
ORDER BY
  (version ->> 'year_to')::integer DESC,
  (version ->> 'year_from')::integer DESC,
  version ->> 'version_label'
LIMIT 12;
