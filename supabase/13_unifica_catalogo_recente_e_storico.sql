-- Auto TCO - unisce il catalogo EEA recente ai profili storici originali.
--
-- I modelli storici non presenti nelle immatricolazioni EEA 2025 restavano
-- esclusi dai dropdown, pur essendo ancora disponibili in mvp.vehicle_profiles.
-- Questa vista li aggiunge senza duplicare i profili gia collegati a un cluster
-- recente e senza copiare o modificare i dati originali.

BEGIN;

SET LOCAL statement_timeout = '15min';

CREATE OR REPLACE VIEW mvp.site_vehicle_catalog_unified_v1 AS
WITH recent_catalog AS (
  SELECT
    catalog.vehicle_cluster_id AS version_id,
    'eea_current'::text AS source_kind,
    catalog.vehicle_cluster_id,
    catalog.model_catalog_id,
    catalog.vehicle_profile_id,
    catalog.seed_model_id,
    catalog.brand_key,
    catalog.model_key,
    catalog.brand,
    catalog.model,
    catalog.version_label,
    profile.representative_year,
    CASE
      WHEN profile.representative_year IS NOT NULL
        AND profile.profile_kind <> 'recent_wltp_2025'
        AND COALESCE(profile.source_type, '') <> 'eea_wltp_2025_curated'
        THEN profile.representative_year
      ELSE years.year_from
    END AS display_year,
    CASE
      WHEN profile.representative_year IS NOT NULL
        AND profile.profile_kind <> 'recent_wltp_2025'
        AND COALESCE(profile.source_type, '') <> 'eea_wltp_2025_curated'
        THEN 'original_database'
      ELSE years.estimation_method
    END AS year_source,
    CASE
      WHEN profile.representative_year IS NOT NULL
        AND profile.profile_kind <> 'recent_wltp_2025'
        AND COALESCE(profile.source_type, '') <> 'eea_wltp_2025_curated'
        THEN 'original'
      ELSE years.confidence
    END AS year_confidence,
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
  JOIN mvp.vehicle_cluster_years_v1 AS years
    ON years.vehicle_cluster_id = catalog.vehicle_cluster_id
  WHERE catalog.model_key NOT IN (
      'UNKNOWN', 'UNK', 'NA', 'NULL', 'NOTAVAILABLE'
    )
    AND catalog.model_key <> 'GV80GENESISGV80'
), current_by_seed AS (
  SELECT DISTINCT ON (seed_model_id)
    seed_model_id,
    model_catalog_id,
    brand_key,
    model_key
  FROM recent_catalog
  WHERE seed_model_id IS NOT NULL
  ORDER BY seed_model_id, registrations_count DESC, model_catalog_id
), current_by_name AS (
  SELECT DISTINCT ON (brand_key, model_key)
    brand_key,
    model_key,
    model_catalog_id
  FROM recent_catalog
  ORDER BY brand_key, model_key, registrations_count DESC, model_catalog_id
), legacy_base AS (
  SELECT
    legacy.*,
    regexp_replace(
      translate(
        upper(legacy.brand),
        'ÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜÝ',
        'AAAAAACEEEEIIIINOOOOOUUUUY'
      ),
      '[^A-Z0-9]', '', 'g'
    ) AS normalized_brand_key,
    regexp_replace(
      translate(
        upper(legacy.model),
        'ÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜÝ',
        'AAAAAACEEEEIIIINOOOOOUUUUY'
      ),
      '[^A-Z0-9]', '', 'g'
    ) AS normalized_model_key
  FROM mvp.site_vehicle_catalog AS legacy
  WHERE legacy.profile_kind <> 'recent_wltp_2025'
    AND COALESCE(legacy.source_type, '') <> 'eea_wltp_2025_curated'
    AND legacy.representative_year BETWEEN 1900 AND 2100
), legacy_catalog AS (
  SELECT
    ('profile:' || legacy.vehicle_profile_id::text)::text AS version_id,
    'original_historical_profile'::text AS source_kind,
    ('profile:' || legacy.vehicle_profile_id::text)::text AS vehicle_cluster_id,
    COALESCE(
      seed_map.model_catalog_id,
      name_map.model_catalog_id,
      'profile_model_' || legacy.seed_model_id::text
    ) AS model_catalog_id,
    legacy.vehicle_profile_id,
    legacy.seed_model_id,
    COALESCE(seed_map.brand_key, name_map.brand_key, legacy.normalized_brand_key)
      AS brand_key,
    COALESCE(seed_map.model_key, name_map.model_key, legacy.normalized_model_key)
      AS model_key,
    legacy.brand,
    legacy.model,
    legacy.version_label,
    legacy.representative_year,
    legacy.representative_year AS display_year,
    'original_database'::text AS year_source,
    'original'::text AS year_confidence,
    legacy.fuel_type,
    COALESCE(legacy.hybrid_type, 'none') AS hybrid_type,
    CASE
      WHEN legacy.fuel_type = 'electric' THEN 'electric'
      WHEN legacy.hybrid_type = 'plug_in_hybrid' THEN 'plug_in_hybrid'
      WHEN legacy.hybrid_type = 'hybrid' THEN 'hybrid'
      ELSE 'combustion'
    END AS powertrain_type,
    legacy.power_kw,
    round(legacy.power_cv)::integer AS power_cv,
    CASE
      WHEN legacy.fuel_type = 'electric'
        AND legacy.electric_consumption_kwh_100km IS NOT NULL THEN 'ready'
      WHEN legacy.hybrid_type = 'plug_in_hybrid'
        AND legacy.electric_consumption_kwh_100km IS NOT NULL
        AND COALESCE(
          legacy.phev_thermal_consumption_l_100km,
          legacy.consumption_l_100km
        ) IS NOT NULL THEN 'ready'
      WHEN legacy.fuel_type <> 'electric'
        AND COALESCE(
          legacy.phev_thermal_consumption_l_100km,
          legacy.consumption_l_100km
        ) IS NOT NULL THEN 'ready'
      ELSE 'missing'
    END AS energy_data_status,
    'original_profile'::text AS depreciation_data_status,
    legacy.confidence AS observation_quality,
    GREATEST(round(COALESCE(legacy.popularity_score, 0)), 0)::bigint
      AS registrations_count
  FROM legacy_base AS legacy
  LEFT JOIN current_by_seed AS seed_map
    ON seed_map.seed_model_id = legacy.seed_model_id
  LEFT JOIN current_by_name AS name_map
    ON name_map.brand_key = legacy.normalized_brand_key
   AND name_map.model_key = legacy.normalized_model_key
  WHERE NOT EXISTS (
    SELECT 1
    FROM recent_catalog AS recent
    WHERE recent.vehicle_profile_id = legacy.vehicle_profile_id
  )
)
SELECT * FROM recent_catalog
UNION ALL
SELECT * FROM legacy_catalog;

COMMENT ON VIEW mvp.site_vehicle_catalog_unified_v1 IS
'Catalogo pubblico interno: cluster EEA recenti piu profili storici originali non gia rappresentati.';

REVOKE ALL ON TABLE mvp.site_vehicle_catalog_unified_v1
  FROM PUBLIC, anon, authenticated;

DO $block$
DECLARE
  function_definition text;
BEGIN
  SELECT pg_get_functiondef(
    'mvp.estimate_vehicle_energy_v1(integer,integer,text,date)'::regprocedure
  )
  INTO function_definition;

  IF position('mvp.fuel_prices_site_rolling_12m' IN function_definition) > 0 THEN
    function_definition := replace(
      function_definition,
      'mvp.fuel_prices_site_rolling_12m',
      'mvp.fuel_prices_site_cache_v1'
    );
    EXECUTE function_definition;
  ELSIF position('mvp.fuel_prices_site_cache_v1' IN function_definition) = 0 THEN
    RAISE EXCEPTION 'La funzione energia profili non contiene la sorgente prevista';
  END IF;
END;
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
    FROM mvp.site_vehicle_catalog_unified_v1
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
    FROM mvp.site_vehicle_catalog_unified_v1
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
  FROM (
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
    FROM mvp.site_vehicle_catalog_unified_v1
    WHERE model_catalog_id = left(trim(p_model_id), 64)
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
DECLARE
  v_profile_id integer;
  v_result jsonb;
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

  IF trim(p_vehicle_cluster_id) ~ '^profile:[0-9]{1,10}$' THEN
    v_profile_id := substring(trim(p_vehicle_cluster_id) FROM 9)::integer;

    IF NOT EXISTS (
      SELECT 1
      FROM mvp.site_vehicle_catalog_unified_v1 AS catalog
      WHERE catalog.vehicle_cluster_id = trim(p_vehicle_cluster_id)
        AND catalog.source_kind = 'original_historical_profile'
    ) THEN
      RAISE EXCEPTION 'Versione non disponibile' USING ERRCODE = '22023';
    END IF;

    v_result := mvp.estimate_vehicle_tco_ui_v4(
      v_profile_id,
      p_annual_km,
      p_ownership_years,
      lower(trim(p_region_code)),
      CURRENT_DATE
    );

    -- Uniforma i testi delle schede storiche a quelli gia corretti
    -- usati dal catalogo recente, senza toccare le formule originali.
    v_result := jsonb_set(
      v_result,
      '{descriptions,tax}',
      to_jsonb(
        'Bollo medio sul periodo di possesso, considerando potenza, alimentazione, età, area ed eventuali anni di esenzione.'::text
      ),
      true
    );
    v_result := jsonb_set(
      v_result,
      '{descriptions,insurance}',
      to_jsonb(
        'Premio RC Auto medio dell''area selezionata; non è un preventivo personale.'::text
      ),
      true
    );

    RETURN v_result;
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
REVOKE ALL ON FUNCTION public.auto_tco_estimate(
  text, integer, integer, text
) FROM PUBLIC;

GRANT EXECUTE ON FUNCTION public.auto_tco_brands() TO anon;
GRANT EXECUTE ON FUNCTION public.auto_tco_models(text) TO anon;
GRANT EXECUTE ON FUNCTION public.auto_tco_versions(text) TO anon;
GRANT EXECUTE ON FUNCTION public.auto_tco_estimate(
  text, integer, integer, text
) TO anon;

COMMIT;

NOTIFY pgrst, 'reload schema';

-- Verifica inclusa: la 147 deve avere quattro versioni e il calcolo deve
-- restituire carburante, bollo, assicurazione e svalutazione.
WITH catalog_summary AS (
  SELECT
    count(*)::integer AS versioni_totali,
    count(*) FILTER (WHERE source_kind = 'eea_current')::integer
      AS versioni_recenti,
    count(*) FILTER (
      WHERE source_kind = 'original_historical_profile'
    )::integer AS versioni_storiche_aggiunte,
    count(DISTINCT model_catalog_id)::integer AS modelli_totali
  FROM mvp.site_vehicle_catalog_unified_v1
), alfa_models AS (
  SELECT public.auto_tco_models('ALFAROMEO') AS payload
), alfa_147_model AS (
  SELECT item ->> 'model_catalog_id' AS model_catalog_id
  FROM alfa_models
  CROSS JOIN LATERAL jsonb_array_elements(payload -> 'items') AS items(item)
  WHERE lower(item ->> 'model') = '147'
), alfa_147_versions AS (
  SELECT item
  FROM alfa_147_model
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(model_catalog_id) -> 'items'
  ) AS items(item)
), alfa_147_estimate AS (
  SELECT public.auto_tco_estimate(
    'profile:960', 15000, 5, 'italia'
  ) AS payload
), checks AS (
  SELECT
    (SELECT count(*) FROM alfa_147_model)::integer AS modelli_147,
    (SELECT count(*) FROM alfa_147_versions)::integer AS versioni_147,
    (SELECT count(*) FROM alfa_147_versions
      WHERE (item ->> 'display_year')::integer
        IN (2006, 2007, 2008, 2010))::integer AS anni_147_corretti,
    (SELECT payload #>> '{vehicle,model}' FROM alfa_147_estimate)
      AS esempio_modello,
    (SELECT payload #>> '{quality,status}' FROM alfa_147_estimate)
      AS esempio_stato,
    (SELECT (payload #>> '{monthly_costs,fuel_or_energy_eur}')::numeric
      FROM alfa_147_estimate) AS esempio_energia,
    (SELECT (payload #>> '{monthly_costs,tax_eur}')::numeric
      FROM alfa_147_estimate) AS esempio_bollo,
    (SELECT (payload #>> '{monthly_costs,insurance_eur}')::numeric
      FROM alfa_147_estimate) AS esempio_assicurazione,
    (SELECT (payload #>> '{monthly_costs,depreciation_eur}')::numeric
      FROM alfa_147_estimate) AS esempio_svalutazione
)
SELECT
  catalog_summary.*,
  checks.*,
  position(
    'mvp.fuel_prices_site_cache_v1'
    IN pg_get_functiondef(
      'mvp.estimate_vehicle_energy_v1(integer,integer,text,date)'::regprocedure
    )
  ) > 0 AS profili_usano_cache,
  CASE
    WHEN catalog_summary.versioni_storiche_aggiunte > 0
      AND catalog_summary.versioni_totali > catalog_summary.versioni_recenti
      AND checks.modelli_147 = 1
      AND checks.versioni_147 = 4
      AND checks.anni_147_corretti = 4
      AND checks.esempio_modello = '147'
      AND checks.esempio_stato = 'ready'
      AND checks.esempio_energia > 0
      AND checks.esempio_bollo >= 0
      AND checks.esempio_assicurazione > 0
      AND checks.esempio_svalutazione > 0
      THEN 'ok'
    ELSE 'controllare'
  END AS verifica
FROM catalog_summary
CROSS JOIN checks;
