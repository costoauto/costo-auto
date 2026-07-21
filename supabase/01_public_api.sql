BEGIN;

REVOKE ALL ON SCHEMA raw, curated, mvp FROM anon, authenticated;
REVOKE ALL ON ALL TABLES IN SCHEMA raw, curated, mvp FROM anon, authenticated;
REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA curated, mvp FROM anon, authenticated;
REVOKE CREATE ON SCHEMA public FROM PUBLIC;

DO $block$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'auto_tco_web') THEN
    ALTER ROLE auto_tco_web NOLOGIN;
  END IF;
END
$block$;

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
    FROM mvp.site_vehicle_catalog_eea_v2
    WHERE model_key NOT IN ('UNKNOWN', 'UNK', 'NA', 'NULL', 'NOTAVAILABLE')
      AND model_key <> 'GV80GENESISGV80'
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
    SELECT DISTINCT
      model_catalog_id,
      brand_key,
      seed_model_id,
      brand,
      model_key,
      model
    FROM mvp.site_vehicle_catalog_eea_v2
    WHERE brand_key = left(trim(p_brand_key), 60)
      AND model_key NOT IN ('UNKNOWN', 'UNK', 'NA', 'NULL', 'NOTAVAILABLE')
      AND model_key <> 'GV80GENESISGV80'
  ) AS item;
$function$;

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
      vehicle_cluster_id,
      model_catalog_id,
      vehicle_profile_id,
      seed_model_id,
      brand,
      model,
      version_label,
      fuel_type,
      hybrid_type,
      powertrain_type,
      power_kw,
      power_cv,
      energy_data_status,
      depreciation_data_status,
      observation_quality,
      registrations_count
    FROM mvp.site_vehicle_catalog_eea_v2
    WHERE model_catalog_id = left(trim(p_model_id), 64)
      AND model_key NOT IN ('UNKNOWN', 'UNK', 'NA', 'NULL', 'NOTAVAILABLE')
      AND model_key <> 'GV80GENESISGV80'
  ) AS item;
$function$;

CREATE OR REPLACE FUNCTION public.auto_tco_regions()
RETURNS jsonb
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public
AS $function$
  SELECT jsonb_build_object(
    'items',
    COALESCE(
      jsonb_agg(to_jsonb(item) ORDER BY item.display_order, item.region_name),
      '[]'::jsonb
    )
  )
  FROM (
    SELECT region_code, region_name, display_order
    FROM mvp.tax_jurisdictions
  ) AS item;
$function$;

CREATE OR REPLACE FUNCTION public.auto_tco_estimate(
  p_vehicle_cluster_id text,
  p_annual_km integer,
  p_ownership_years integer,
  p_region_code text
)
RETURNS jsonb
LANGUAGE plpgsql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public
AS $function$
BEGIN
  IF p_vehicle_cluster_id IS NULL
    OR length(trim(p_vehicle_cluster_id)) NOT BETWEEN 1 AND 64
  THEN
    RAISE EXCEPTION 'Versione non valida' USING ERRCODE = '22023';
  END IF;

  IF p_annual_km NOT BETWEEN 1000 AND 100000 THEN
    RAISE EXCEPTION 'Chilometri annui non validi' USING ERRCODE = '22023';
  END IF;

  IF p_ownership_years NOT BETWEEN 1 AND 10 THEN
    RAISE EXCEPTION 'Anni di possesso non validi' USING ERRCODE = '22023';
  END IF;

  IF p_region_code IS NULL
    OR length(trim(p_region_code)) NOT BETWEEN 1 AND 60
  THEN
    RAISE EXCEPTION 'Area non valida' USING ERRCODE = '22023';
  END IF;

  IF NOT EXISTS (
    SELECT 1
    FROM mvp.site_vehicle_catalog_eea_v2
    WHERE vehicle_cluster_id = trim(p_vehicle_cluster_id)
  ) THEN
    RAISE EXCEPTION 'Versione non disponibile' USING ERRCODE = '22023';
  END IF;

  RETURN mvp.estimate_vehicle_cluster_tco_ui_v2(
    trim(p_vehicle_cluster_id),
    p_annual_km,
    p_ownership_years,
    lower(trim(p_region_code)),
    CURRENT_DATE
  );
END;
$function$;

REVOKE ALL ON FUNCTION public.auto_tco_brands() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.auto_tco_models(text) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.auto_tco_versions(text) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.auto_tco_regions() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.auto_tco_estimate(text, integer, integer, text) FROM PUBLIC;

GRANT USAGE ON SCHEMA public TO anon;
GRANT EXECUTE ON FUNCTION public.auto_tco_brands() TO anon;
GRANT EXECUTE ON FUNCTION public.auto_tco_models(text) TO anon;
GRANT EXECUTE ON FUNCTION public.auto_tco_versions(text) TO anon;
GRANT EXECUTE ON FUNCTION public.auto_tco_regions() TO anon;
GRANT EXECUTE ON FUNCTION public.auto_tco_estimate(text, integer, integer, text) TO anon;

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public
  REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLES FROM anon, authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public
  REVOKE USAGE, SELECT ON SEQUENCES FROM anon, authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public
  REVOKE EXECUTE ON FUNCTIONS FROM PUBLIC, anon, authenticated;

COMMIT;

NOTIFY pgrst, 'reload schema';

SELECT
  has_function_privilege('anon', 'public.auto_tco_brands()', 'EXECUTE')
    AS marche_accessibili,
  has_function_privilege(
    'anon',
    'public.auto_tco_estimate(text,integer,integer,text)',
    'EXECUTE'
  ) AS calcolo_accessibile,
  NOT has_schema_privilege('anon', 'mvp', 'USAGE') AS dati_interni_privati,
  NOT has_table_privilege(
    'anon',
    'mvp.site_vehicle_catalog_eea_v2',
    'SELECT,INSERT,UPDATE,DELETE'
  ) AS catalogo_non_diretto;
