\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - pulizia tecnica del catalogo PHEV e dei duplicati visibili.
--
-- Corregge alla radice tre problemi emersi dall'audit 38:
--   * il catalogo ADAC usato per le PHEV conteneva anche full hybrid;
--   * alcune versioni pubbliche indistinguibili venivano duplicate;
--   * due schede ADAC BMW avevano coppie kW/CV incoerenti, corrette nel
--     generatore con le schede ufficiali BMW Group PressClub.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

-- Ricarica soltanto le righe con una prova positiva di alimentazione plug-in.
TRUNCATE TABLE
  mvp.phev_display_variant_energy_v1,
  mvp.phev_variant_price_factors_v1,
  mvp.phev_variant_energy_catalog_v1,
  mvp.phev_system_power_catalog_v1
RESTART IDENTITY;

\ir ../scripts/adac-phev-system-power.sql
\ir ../scripts/adac-phev-energy.sql

ANALYZE mvp.phev_system_power_catalog_v1;
ANALYZE mvp.phev_variant_energy_catalog_v1;

-- Conserva l'endpoint precedente e aggiunge un ultimo livello di pulizia.
DO $block$
BEGIN
  IF to_regprocedure(
    'mvp.auto_tco_versions_before_technical_cleanup_v1(text)'
  ) IS NULL THEN
    IF to_regprocedure('public.auto_tco_versions(text)') IS NULL THEN
      RAISE EXCEPTION 'Funzione public.auto_tco_versions non disponibile';
    END IF;

    EXECUTE
      'ALTER FUNCTION public.auto_tco_versions(text) '
      'RENAME TO auto_tco_versions_before_technical_cleanup_v1';
    EXECUTE
      'ALTER FUNCTION public.auto_tco_versions_before_technical_cleanup_v1(text) '
      'SET SCHEMA mvp';
  END IF;
END;
$block$;

REVOKE ALL ON FUNCTION
  mvp.auto_tco_versions_before_technical_cleanup_v1(text)
FROM PUBLIC, anon, authenticated;

CREATE OR REPLACE FUNCTION public.auto_tco_versions(p_model_id text)
RETURNS jsonb
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public
AS $function$
  WITH source_item AS (
    SELECT
      source.item,
      source.ordinality
    FROM jsonb_array_elements(
      mvp.auto_tco_versions_before_technical_cleanup_v1(
        left(trim(p_model_id), 64)
      ) -> 'items'
    ) WITH ORDINALITY AS source(item, ordinality)
  ), normalized_label AS (
    SELECT
      CASE
        WHEN item ->> 'hybrid_type' = 'plug_in_hybrid'
          AND item ->> 'power_data_status' = 'verified'
          AND NULLIF(item ->> 'system_power_cv', '') IS NOT NULL
          AND NULLIF(item ->> 'thermal_power_cv', '') IS NOT NULL
          AND NULLIF(item ->> 'year_from', '') IS NOT NULL
          AND NULLIF(item ->> 'year_to', '') IS NOT NULL
        THEN item || jsonb_build_object(
          'version_label',
            (
              CASE
                WHEN (item ->> 'year_from')::integer
                  = (item ->> 'year_to')::integer
                  THEN item ->> 'year_from'
                ELSE (item ->> 'year_from')
                  || '-' || (item ->> 'year_to')
              END
              || ' ' || chr(183) || ' Ibrida plug-in '
              || CASE
                WHEN item ->> 'fuel_type' IN (
                  'diesel',
                  'diesel/electric'
                ) THEN 'diesel'
                ELSE 'benzina'
              END
              || ' ' || chr(183) || ' '
              || round(
                (item ->> 'system_power_cv')::numeric
              )::integer::text
              || ' CV ('
              || round(
                (item ->> 'thermal_power_cv')::numeric
              )::integer::text
              || ' CV termici)'
            )
        )
        ELSE item
      END AS item,
      ordinality
    FROM source_item
  ), label_stats AS (
    SELECT
      item ->> 'version_label' AS version_label,
      count(*)::integer AS occurrences,
      count(
        DISTINCT NULLIF(trim(item ->> 'commercial_name'), '')
      )::integer AS distinct_commercial_names
    FROM normalized_label
    GROUP BY item ->> 'version_label'
  ), disambiguated AS (
    SELECT
      CASE
        WHEN stats.occurrences > 1
          AND stats.distinct_commercial_names = stats.occurrences
          AND NULLIF(trim(source.item ->> 'commercial_name'), '')
            IS NOT NULL
        THEN source.item || jsonb_build_object(
          'version_label',
            source.item ->> 'version_label'
            || ' ' || chr(183) || ' '
            || trim(source.item ->> 'commercial_name')
        )
        ELSE source.item
      END AS item,
      source.ordinality
    FROM normalized_label AS source
    JOIN label_stats AS stats
      ON stats.version_label = source.item ->> 'version_label'
  ), ranked AS (
    SELECT
      item,
      ordinality,
      row_number() OVER (
        PARTITION BY item ->> 'version_label'
        ORDER BY
          CASE
            WHEN item ->> 'hybrid_type' = 'plug_in_hybrid'
              AND NULLIF(item ->> 'thermal_power_kw', '') IS NOT NULL
              AND NULLIF(item ->> 'thermal_power_cv', '') IS NOT NULL
            THEN
              abs(
                COALESCE(
                  NULLIF(item ->> 'power_kw', '')::numeric,
                  (item ->> 'thermal_power_kw')::numeric
                ) - (item ->> 'thermal_power_kw')::numeric
              )
              + abs(
                COALESCE(
                  NULLIF(item ->> 'power_cv', '')::numeric,
                  (item ->> 'thermal_power_cv')::numeric
                ) - (item ->> 'thermal_power_cv')::numeric
              ) / 1.359621617
            ELSE 0
          END,
          CASE
            WHEN item ->> 'fuel_type' LIKE '%/electric' THEN 0
            ELSE 1
          END,
          CASE COALESCE(item ->> 'energy_data_status', '')
            WHEN 'complete' THEN 0
            WHEN 'ready' THEN 1
            WHEN 'estimated' THEN 2
            ELSE 3
          END,
          CASE
            WHEN item ->> 'vehicle_cluster_id' LIKE 'profile:%' THEN 1
            ELSE 0
          END,
          item ->> 'display_variant_id',
          ordinality
      ) AS visible_label_rank
    FROM disambiguated
  )
  SELECT jsonb_build_object(
    'items',
    COALESCE(
      jsonb_agg(item ORDER BY ordinality),
      '[]'::jsonb
    )
  )
  FROM ranked
  WHERE visible_label_rank = 1;
$function$;

COMMENT ON FUNCTION public.auto_tco_versions(text) IS
'Versioni pubbliche senza duplicati indistinguibili: le trazioni curate vengono esplicitate e, per le PHEV, sono accettate solo potenze supportate da prove positive di ricaricabilita.';

REVOKE ALL ON FUNCTION public.auto_tco_versions(text)
FROM PUBLIC, authenticated;
GRANT EXECUTE ON FUNCTION public.auto_tco_versions(text) TO anon;

-- Ricostruisce i consumi specifici delle sole varianti PHEV ancora pubblicate.
WITH model_ids AS (
  SELECT DISTINCT catalog.model_catalog_id
  FROM mvp.phev_variant_energy_catalog_v1 AS catalog
  WHERE catalog.weighted_thermal_l_100km IS NOT NULL
    AND catalog.weighted_electric_kwh_100km IS NOT NULL
), public_variants AS (
  SELECT DISTINCT ON (version.item ->> 'display_variant_id')
    version.item
  FROM model_ids AS model
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(model.model_catalog_id) -> 'items'
  ) AS version(item)
  WHERE version.item ->> 'hybrid_type' = 'plug_in_hybrid'
    AND version.item ->> 'power_data_status' = 'verified'
    AND NULLIF(version.item ->> 'display_variant_id', '') IS NOT NULL
    AND NULLIF(version.item ->> 'vehicle_cluster_id', '') IS NOT NULL
    AND NULLIF(version.item ->> 'model_catalog_id', '') IS NOT NULL
    AND NULLIF(version.item ->> 'system_power_kw', '') IS NOT NULL
    AND NULLIF(version.item ->> 'thermal_power_kw', '') IS NOT NULL
    AND NULLIF(version.item ->> 'year_from', '')::integer
      BETWEEN 1990 AND 2100
    AND NULLIF(version.item ->> 'year_to', '')::integer
      BETWEEN 1990 AND 2100
  ORDER BY
    version.item ->> 'display_variant_id',
    NULLIF(version.item ->> 'year_to', '')::integer DESC
), matched AS (
  SELECT
    variant.item,
    energy.weighted_thermal_l_100km,
    energy.weighted_electric_kwh_100km,
    energy.thermal_empty_battery_l_100km,
    energy.electric_range_wltp_km,
    energy.source_name,
    energy.source_urls,
    energy.source_records,
    energy.confidence
  FROM public_variants AS variant
  CROSS JOIN LATERAL (
    SELECT
      percentile_cont(0.5) WITHIN GROUP (
        ORDER BY catalog.weighted_thermal_l_100km
      )::numeric AS weighted_thermal_l_100km,
      percentile_cont(0.5) WITHIN GROUP (
        ORDER BY catalog.weighted_electric_kwh_100km
      )::numeric AS weighted_electric_kwh_100km,
      (
        percentile_cont(0.5) WITHIN GROUP (
          ORDER BY catalog.thermal_empty_battery_l_100km
        ) FILTER (
          WHERE catalog.thermal_empty_battery_l_100km IS NOT NULL
        )
      )::numeric AS thermal_empty_battery_l_100km,
      (
        percentile_cont(0.5) WITHIN GROUP (
          ORDER BY catalog.electric_range_wltp_km
        ) FILTER (
          WHERE catalog.electric_range_wltp_km IS NOT NULL
        )
      )::numeric AS electric_range_wltp_km,
      min(catalog.source_name) AS source_name,
      array_agg(
        DISTINCT catalog.source_url ORDER BY catalog.source_url
      ) AS source_urls,
      count(*)::integer AS source_records,
      CASE min(
        CASE catalog.confidence
          WHEN 'high' THEN 3
          WHEN 'medium' THEN 2
          ELSE 1
        END
      )
        WHEN 3 THEN 'high'
        WHEN 2 THEN 'medium'
        ELSE 'low'
      END AS confidence
    FROM mvp.phev_variant_energy_catalog_v1 AS catalog
    WHERE catalog.model_catalog_id = variant.item ->> 'model_catalog_id'
      AND abs(
        catalog.system_power_kw
          - (variant.item ->> 'system_power_kw')::numeric
      ) <= 1
      AND abs(
        catalog.thermal_power_kw
          - (variant.item ->> 'thermal_power_kw')::numeric
      ) <= 1
      AND catalog.year_from <= (variant.item ->> 'year_to')::integer
      AND coalesce(catalog.year_to, 2099)
        >= (variant.item ->> 'year_from')::integer
      AND catalog.weighted_thermal_l_100km IS NOT NULL
      AND catalog.weighted_electric_kwh_100km IS NOT NULL
  ) AS energy
  WHERE energy.weighted_thermal_l_100km > 0
    AND energy.weighted_electric_kwh_100km > 0
    AND energy.source_records > 0
)
INSERT INTO mvp.phev_display_variant_energy_v1 (
  display_variant_id,
  vehicle_cluster_id,
  model_catalog_id,
  brand,
  model,
  year_from,
  year_to,
  system_power_kw,
  system_power_cv,
  thermal_power_kw,
  thermal_power_cv,
  weighted_thermal_l_100km,
  weighted_electric_kwh_100km,
  thermal_empty_battery_l_100km,
  electric_range_wltp_km,
  source_name,
  source_urls,
  source_records,
  confidence
)
SELECT
  item ->> 'display_variant_id',
  item ->> 'vehicle_cluster_id',
  item ->> 'model_catalog_id',
  item ->> 'brand',
  item ->> 'model',
  (item ->> 'year_from')::integer,
  (item ->> 'year_to')::integer,
  (item ->> 'system_power_kw')::numeric,
  (item ->> 'system_power_cv')::numeric,
  (item ->> 'thermal_power_kw')::numeric,
  (item ->> 'thermal_power_cv')::numeric,
  round(weighted_thermal_l_100km, 3),
  round(weighted_electric_kwh_100km, 3),
  round(thermal_empty_battery_l_100km, 3),
  round(electric_range_wltp_km, 1),
  source_name,
  source_urls,
  source_records,
  confidence
FROM matched;

ANALYZE mvp.phev_display_variant_energy_v1;

-- Ricostruisce i fattori relativi di svalutazione delle PHEV pubblicate.
WITH model_ids AS (
  SELECT DISTINCT catalog.model_catalog_id
  FROM mvp.phev_system_power_catalog_v1 AS catalog
), public_variants AS (
  SELECT DISTINCT ON (version.item ->> 'display_variant_id')
    version.item
  FROM model_ids AS model
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(model.model_catalog_id) -> 'items'
  ) AS version(item)
  WHERE version.item ->> 'hybrid_type' = 'plug_in_hybrid'
    AND version.item ->> 'power_data_status' = 'verified'
    AND NULLIF(version.item ->> 'display_variant_id', '') IS NOT NULL
    AND NULLIF(version.item ->> 'vehicle_cluster_id', '') IS NOT NULL
    AND NULLIF(version.item ->> 'model_catalog_id', '') IS NOT NULL
  ORDER BY
    version.item ->> 'display_variant_id',
    NULLIF(version.item ->> 'year_to', '')::integer DESC
), priced_variants AS (
  SELECT
    variant.item,
    variant_price.median_price AS variant_list_price_eur,
    variant_price.price_records AS variant_price_records,
    variant_price.source_name,
    variant_price.source_urls,
    variant_price.confidence,
    reference_price.median_price AS reference_list_price_eur,
    reference_price.price_records AS reference_price_records
  FROM public_variants AS variant
  CROSS JOIN LATERAL (
    SELECT
      percentile_cont(0.5) WITHIN GROUP (
        ORDER BY catalog.representative_list_price_eur
      )::numeric AS median_price,
      count(*)::integer AS price_records,
      min(catalog.source_name) AS source_name,
      array_agg(DISTINCT catalog.source_url ORDER BY catalog.source_url)
        AS source_urls,
      CASE min(
        CASE catalog.confidence
          WHEN 'high' THEN 3
          WHEN 'medium' THEN 2
          ELSE 1
        END
      )
        WHEN 3 THEN 'high'
        WHEN 2 THEN 'medium'
        ELSE 'low'
      END AS confidence
    FROM mvp.phev_system_power_catalog_v1 AS catalog
    WHERE catalog.model_catalog_id = variant.item ->> 'model_catalog_id'
      AND abs(
        catalog.system_power_kw
          - (variant.item ->> 'system_power_kw')::numeric
      ) <= 1
      AND abs(
        catalog.thermal_power_kw
          - (variant.item ->> 'thermal_power_kw')::numeric
      ) <= 1
      AND catalog.year_from <= (variant.item ->> 'year_to')::integer
      AND coalesce(catalog.year_to, 2099)
        >= (variant.item ->> 'year_from')::integer
      AND catalog.representative_list_price_eur > 0
  ) AS variant_price
  CROSS JOIN LATERAL (
    SELECT
      percentile_cont(0.5) WITHIN GROUP (
        ORDER BY catalog.representative_list_price_eur
      )::numeric AS median_price,
      count(*)::integer AS price_records
    FROM mvp.phev_system_power_catalog_v1 AS catalog
    WHERE catalog.model_catalog_id = variant.item ->> 'model_catalog_id'
      AND catalog.year_from <= (variant.item ->> 'year_to')::integer
      AND coalesce(catalog.year_to, 2099)
        >= (variant.item ->> 'year_from')::integer
      AND catalog.representative_list_price_eur > 0
      AND (
        (
          NULLIF(variant.item ->> 'power_kw', '') IS NOT NULL
          AND (
            abs(
              catalog.thermal_power_kw
                - (variant.item ->> 'power_kw')::numeric
            ) <= 2
            OR abs(
              catalog.system_power_kw
                - (variant.item ->> 'power_kw')::numeric
            ) <= 2
          )
        )
        OR (
          NULLIF(variant.item ->> 'power_cv', '') IS NOT NULL
          AND (
            abs(
              catalog.thermal_power_cv
                - (variant.item ->> 'power_cv')::numeric
            ) <= 3
            OR abs(
              catalog.system_power_cv
                - (variant.item ->> 'power_cv')::numeric
            ) <= 3
          )
        )
      )
  ) AS reference_price
  WHERE variant_price.median_price > 0
    AND reference_price.median_price > 0
), valid_factors AS (
  SELECT
    priced.*,
    priced.variant_list_price_eur
      / priced.reference_list_price_eur AS raw_price_factor
  FROM priced_variants AS priced
  WHERE priced.variant_price_records > 0
    AND priced.reference_price_records > 0
)
INSERT INTO mvp.phev_variant_price_factors_v1 (
  display_variant_id,
  vehicle_cluster_id,
  model_catalog_id,
  brand,
  model,
  year_from,
  year_to,
  system_power_kw,
  system_power_cv,
  thermal_power_kw,
  thermal_power_cv,
  variant_list_price_eur,
  reference_list_price_eur,
  price_factor,
  variant_price_records,
  reference_price_records,
  source_name,
  source_urls,
  confidence
)
SELECT
  item ->> 'display_variant_id',
  item ->> 'vehicle_cluster_id',
  item ->> 'model_catalog_id',
  item ->> 'brand',
  item ->> 'model',
  (item ->> 'year_from')::integer,
  (item ->> 'year_to')::integer,
  (item ->> 'system_power_kw')::numeric,
  (item ->> 'system_power_cv')::numeric,
  (item ->> 'thermal_power_kw')::numeric,
  (item ->> 'thermal_power_cv')::numeric,
  round(variant_list_price_eur, 2),
  round(reference_list_price_eur, 2),
  round(raw_price_factor, 6),
  variant_price_records,
  reference_price_records,
  source_name,
  source_urls,
  confidence
FROM valid_factors
WHERE raw_price_factor BETWEEN 0.65 AND 1.50;

ANALYZE mvp.phev_variant_price_factors_v1;

-- Riallinea la cache della manutenzione ai nuovi display_variant_id.
TRUNCATE TABLE mvp.maintenance_display_variant_inputs_v1;

WITH brand_item AS (
  SELECT brand.item
  FROM jsonb_array_elements(
    public.auto_tco_brands() -> 'items'
  ) AS brand(item)
), model_item AS (
  SELECT DISTINCT
    model.item ->> 'model_catalog_id' AS model_catalog_id
  FROM brand_item AS brand
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_models(brand.item ->> 'brand_key') -> 'items'
  ) AS model(item)
  WHERE NULLIF(model.item ->> 'model_catalog_id', '') IS NOT NULL
), version_item AS (
  SELECT
    model.model_catalog_id,
    version.item
  FROM model_item AS model
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(model.model_catalog_id) -> 'items'
  ) AS version(item)
), normalized AS (
  SELECT
    COALESCE(
      NULLIF(item ->> 'display_variant_id', ''),
      NULLIF(item ->> 'vehicle_cluster_id', '')
    ) AS display_variant_id,
    NULLIF(item ->> 'vehicle_cluster_id', '') AS vehicle_cluster_id,
    COALESCE(
      NULLIF(item ->> 'model_catalog_id', ''),
      model_catalog_id
    ) AS model_catalog_id,
    NULLIF(item ->> 'brand', '') AS brand,
    NULLIF(item ->> 'model', '') AS model,
    NULLIF(item ->> 'version_label', '') AS version_label,
    COALESCE(
      NULLIF(item ->> 'year_from', '')::integer,
      NULLIF(item ->> 'display_year', '')::integer,
      NULLIF(item ->> 'representative_year', '')::integer
    ) AS year_from,
    COALESCE(
      NULLIF(item ->> 'year_to', '')::integer,
      NULLIF(item ->> 'display_year', '')::integer,
      NULLIF(item ->> 'representative_year', '')::integer
    ) AS year_to,
    COALESCE(
      NULLIF(item ->> 'display_year', '')::integer,
      round(
        (
          NULLIF(item ->> 'year_from', '')::numeric
          + NULLIF(item ->> 'year_to', '')::numeric
        ) / 2.0
      )::integer,
      NULLIF(item ->> 'representative_year', '')::integer
    ) AS display_year,
    COALESCE(NULLIF(item ->> 'year_source', ''), 'catalog_display_year')
      AS year_source,
    COALESCE(NULLIF(item ->> 'year_confidence', ''), 'low')
      AS year_confidence,
    COALESCE(NULLIF(item ->> 'fuel_type', ''), 'unknown')
      AS fuel_type,
    COALESCE(NULLIF(item ->> 'hybrid_type', ''), 'none')
      AS hybrid_type,
    NULLIF(item ->> 'power_kw', '')::numeric AS displayed_power_kw,
    NULLIF(item ->> 'thermal_power_kw', '')::numeric AS thermal_power_kw
  FROM version_item
), valid AS (
  SELECT
    normalized.*,
    CASE
      WHEN hybrid_type = 'plug_in_hybrid'
        AND thermal_power_kw > 0
        THEN thermal_power_kw
      ELSE displayed_power_kw
    END AS maintenance_power_kw,
    CASE
      WHEN hybrid_type = 'plug_in_hybrid'
        AND thermal_power_kw > 0
        THEN 'thermal_engine_power'
      ELSE 'declared_vehicle_power'
    END AS power_basis
  FROM normalized
  WHERE display_variant_id IS NOT NULL
    AND vehicle_cluster_id IS NOT NULL
    AND model_catalog_id IS NOT NULL
    AND brand IS NOT NULL
    AND model IS NOT NULL
    AND version_label IS NOT NULL
    AND year_from BETWEEN 1900 AND 2100
    AND year_to BETWEEN year_from AND 2100
    AND display_year BETWEEN year_from AND year_to
), deduplicated AS (
  SELECT DISTINCT ON (display_variant_id, vehicle_cluster_id)
    *
  FROM valid
  ORDER BY
    display_variant_id,
    vehicle_cluster_id,
    CASE year_confidence
      WHEN 'high' THEN 1
      WHEN 'medium_high' THEN 2
      WHEN 'medium' THEN 3
      WHEN 'medium_low' THEN 4
      ELSE 5
    END,
    year_to DESC
)
INSERT INTO mvp.maintenance_display_variant_inputs_v1 (
  display_variant_id,
  vehicle_cluster_id,
  model_catalog_id,
  brand,
  model,
  version_label,
  year_from,
  year_to,
  display_year,
  year_source,
  year_confidence,
  fuel_type,
  hybrid_type,
  displayed_power_kw,
  thermal_power_kw,
  maintenance_power_kw,
  power_basis,
  built_at
)
SELECT
  display_variant_id,
  vehicle_cluster_id,
  model_catalog_id,
  brand,
  model,
  version_label,
  year_from,
  year_to,
  display_year,
  year_source,
  year_confidence,
  fuel_type,
  hybrid_type,
  displayed_power_kw,
  thermal_power_kw,
  maintenance_power_kw,
  power_basis,
  now()
FROM deduplicated;

ANALYZE mvp.maintenance_display_variant_inputs_v1;

NOTIFY pgrst, 'reload schema';

-- Verifica integrata: inventario pubblico e calcolo TCO di ogni versione.
CREATE OR REPLACE FUNCTION pg_temp.safe_tco_after_plugin_cleanup_v1(
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

CREATE TEMP TABLE published_after_plugin_cleanup_v1
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
  ORDER BY model.item ->> 'model_catalog_id'
), version_item AS (
  SELECT version.item
  FROM model_item AS model
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(
      model.item ->> 'model_catalog_id'
    ) -> 'items'
  ) AS version(item)
)
SELECT
  item,
  item ->> 'brand' AS brand,
  item ->> 'model' AS model,
  item ->> 'version_label' AS version_label,
  item ->> 'vehicle_cluster_id' AS vehicle_cluster_id,
  item ->> 'display_variant_id' AS display_variant_id
FROM version_item;

CREATE INDEX ON published_after_plugin_cleanup_v1 (
  vehicle_cluster_id,
  display_variant_id
);
ANALYZE published_after_plugin_cleanup_v1;

CREATE TEMP TABLE tco_after_plugin_cleanup_v1
ON COMMIT DROP
AS
SELECT
  published.*,
  pg_temp.safe_tco_after_plugin_cleanup_v1(
    vehicle_cluster_id,
    display_variant_id
  ) AS result
FROM published_after_plugin_cleanup_v1 AS published;

DO $verification$
DECLARE
  v_duplicate_labels integer;
  v_failed_calculations integer;
  v_not_ready integer;
  v_false_kuga integer;
  v_false_chr integer;
  v_panda_tractions integer;
  v_bmw_220_125 integer;
BEGIN
  SELECT count(*)
  INTO v_duplicate_labels
  FROM (
    SELECT brand, model, version_label
    FROM published_after_plugin_cleanup_v1
    GROUP BY brand, model, version_label
    HAVING count(*) > 1
  ) AS duplicate;

  SELECT
    count(*) FILTER (
      WHERE NULLIF(result ->> '_audit_error', '') IS NOT NULL
    ),
    count(*) FILTER (
      WHERE NULLIF(result ->> '_audit_error', '') IS NULL
        AND result #>> '{quality,status}' IS DISTINCT FROM 'ready'
    )
  INTO v_failed_calculations, v_not_ready
  FROM tco_after_plugin_cleanup_v1;

  SELECT count(*)
  INTO v_false_kuga
  FROM published_after_plugin_cleanup_v1
  WHERE brand = 'Ford'
    AND model = 'Kuga'
    AND item ->> 'hybrid_type' = 'plug_in_hybrid'
    AND round(NULLIF(item ->> 'system_power_cv', '')::numeric)
      IN (180, 183);

  SELECT count(*)
  INTO v_false_chr
  FROM published_after_plugin_cleanup_v1
  WHERE brand = 'Toyota'
    AND model = 'C-HR'
    AND item ->> 'hybrid_type' = 'plug_in_hybrid'
    AND round(NULLIF(item ->> 'system_power_cv', '')::numeric) = 197;

  SELECT count(*)
  INTO v_panda_tractions
  FROM published_after_plugin_cleanup_v1
  WHERE brand = 'Fiat'
    AND model = 'Panda'
    AND version_label IN (
      '2012-2018 ' || chr(183) || ' Benzina ' || chr(183)
        || ' 85 CV ' || chr(183) || ' 4x2',
      '2012-2018 ' || chr(183) || ' Benzina ' || chr(183)
        || ' 85 CV ' || chr(183) || ' 4x4'
    );

  SELECT count(*)
  INTO v_bmw_220_125
  FROM published_after_plugin_cleanup_v1
  WHERE brand = 'BMW'
    AND model = '2 Series'
    AND round(NULLIF(item ->> 'system_power_cv', '')::numeric) = 220
    AND round(NULLIF(item ->> 'thermal_power_cv', '')::numeric) = 125;

  IF v_duplicate_labels <> 0
    OR v_failed_calculations <> 0
    OR v_not_ready <> 0
    OR v_false_kuga <> 0
    OR v_false_chr <> 0
    OR v_panda_tractions <> 2
    OR v_bmw_220_125 < 1
  THEN
    RAISE EXCEPTION
      'Verifica fallita: duplicati %, errori %, non ready %, Kuga false %, C-HR false %, Panda trazioni %, BMW corretta %',
      v_duplicate_labels,
      v_failed_calculations,
      v_not_ready,
      v_false_kuga,
      v_false_chr,
      v_panda_tractions,
      v_bmw_220_125;
  END IF;
END;
$verification$;

SELECT
  (SELECT count(*) FROM mvp.phev_system_power_catalog_v1)
    AS motorizzazioni_plugin_verificate,
  (SELECT count(*) FROM mvp.phev_variant_energy_catalog_v1)
    AS motorizzazioni_plugin_con_dati_energia,
  (SELECT count(*) FROM mvp.phev_display_variant_energy_v1)
    AS varianti_plugin_con_consumo_specifico,
  (SELECT count(*) FROM mvp.phev_variant_price_factors_v1)
    AS varianti_plugin_con_fattore_svalutazione,
  (SELECT count(*) FROM published_after_plugin_cleanup_v1)
    AS versioni_pubblicate,
  (
    SELECT count(*)
    FROM (
      SELECT brand, model, version_label
      FROM published_after_plugin_cleanup_v1
      GROUP BY brand, model, version_label
      HAVING count(*) > 1
    ) AS duplicate
  ) AS etichette_duplicate,
  count(*) FILTER (
    WHERE NULLIF(result ->> '_audit_error', '') IS NOT NULL
  ) AS richieste_fallite,
  count(*) FILTER (
    WHERE NULLIF(result ->> '_audit_error', '') IS NULL
      AND result #>> '{quality,status}' = 'ready'
  ) AS risultati_ready,
  'ok' AS verifica
FROM tco_after_plugin_cleanup_v1;

COMMIT;
