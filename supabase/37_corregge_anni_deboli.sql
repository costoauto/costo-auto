\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - corregge gli anni attribuiti tramite abbinamenti storici deboli.
--
-- Un cluster tecnico EEA 2025 non puo essere proiettato all'indietro usando
-- soltanto marca/modello/alimentazione: la stessa gamma puo avere cambiato
-- completamente motore e potenza. In assenza di una corrispondenza storica
-- anche sulla potenza, la sola affermazione verificabile e che la versione e
-- osservata nel catalogo EEA 2025.
--
-- Restano invariati:
--   * profili storici originali;
--   * cataloghi commerciali curati;
--   * intervalli EEA confermati da type/variant/version;
--   * match storici che includono la potenza;
--   * PHEV con potenza e intervallo verificati su fonte pubblica.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

CREATE TABLE IF NOT EXISTS mvp.vehicle_cluster_year_corrections_v1 (
  vehicle_cluster_id text PRIMARY KEY,
  original_year_from integer NOT NULL,
  original_year_to integer NOT NULL,
  original_estimation_method text NOT NULL,
  original_confidence text NOT NULL,
  original_matched_rows_count integer NOT NULL,
  original_historical_registrations_count bigint NOT NULL,
  original_matched_historical_years integer[] NOT NULL,
  corrected_year_from integer NOT NULL,
  corrected_year_to integer NOT NULL,
  correction_reason text NOT NULL,
  corrected_at timestamptz NOT NULL DEFAULT now()
);

COMMENT ON TABLE mvp.vehicle_cluster_year_corrections_v1 IS
'Registro privato e reversibile delle correzioni applicate agli anni ricostruiti con abbinamenti che non verificavano la potenza.';

REVOKE ALL ON mvp.vehicle_cluster_year_corrections_v1
FROM PUBLIC, anon, authenticated;

-- Individua le PHEV per cui la funzione pubblica ha gia una motorizzazione
-- verificata. Il loro intervallo e fornito dal catalogo tecnico pubblico PHEV
-- e non deve essere ristretto dal controllo seguente.
CREATE TEMP TABLE verified_phev_clusters_v1
AS
WITH brand_item AS (
  SELECT brand.item
  FROM jsonb_array_elements(
    public.auto_tco_brands() -> 'items'
  ) AS brand(item)
), model_item AS (
  SELECT DISTINCT model.item
  FROM brand_item AS brand
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_models(brand.item ->> 'brand_key') -> 'items'
  ) AS model(item)
), version_item AS (
  SELECT version.item
  FROM model_item AS model
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(
      model.item ->> 'model_catalog_id'
    ) -> 'items'
  ) AS version(item)
)
SELECT DISTINCT item ->> 'vehicle_cluster_id' AS vehicle_cluster_id
FROM version_item
WHERE item ->> 'hybrid_type' = 'plug_in_hybrid'
  AND item ->> 'power_data_status' = 'verified'
  AND NULLIF(item ->> 'vehicle_cluster_id', '') IS NOT NULL;

CREATE UNIQUE INDEX ON verified_phev_clusters_v1 (vehicle_cluster_id);

-- Questi sono gli unici record da correggere automaticamente. I due metodi
-- indicati verificavano modello e alimentazione, ma non la potenza.
CREATE TEMP TABLE weak_year_targets_v1
AS
SELECT DISTINCT ON (years.vehicle_cluster_id)
  years.vehicle_cluster_id,
  years.year_from,
  years.year_to,
  years.estimation_method,
  years.confidence,
  years.matched_rows_count,
  years.historical_registrations_count,
  years.matched_historical_years,
  catalog.brand,
  catalog.model,
  catalog.fuel_type,
  COALESCE(catalog.hybrid_type, 'none') AS hybrid_type,
  catalog.power_kw,
  catalog.power_cv
FROM mvp.vehicle_cluster_years_v1 AS years
JOIN mvp.site_vehicle_catalog_eea_v2 AS catalog
  ON catalog.vehicle_cluster_id = years.vehicle_cluster_id
WHERE years.estimation_method IN (
    'exact_model_powertrain',
    'fuzzy_model_powertrain'
  )
  AND years.year_from < 2025
  AND (
    COALESCE(catalog.hybrid_type, 'none') <> 'plug_in_hybrid'
    OR NOT EXISTS (
      SELECT 1
      FROM verified_phev_clusters_v1 AS verified
      WHERE verified.vehicle_cluster_id = years.vehicle_cluster_id
    )
  )
ORDER BY years.vehicle_cluster_id, catalog.registrations_count DESC;

CREATE UNIQUE INDEX ON weak_year_targets_v1 (vehicle_cluster_id);

INSERT INTO mvp.vehicle_cluster_year_corrections_v1 (
  vehicle_cluster_id,
  original_year_from,
  original_year_to,
  original_estimation_method,
  original_confidence,
  original_matched_rows_count,
  original_historical_registrations_count,
  original_matched_historical_years,
  corrected_year_from,
  corrected_year_to,
  correction_reason,
  corrected_at
)
SELECT
  target.vehicle_cluster_id,
  target.year_from,
  target.year_to,
  target.estimation_method,
  target.confidence,
  target.matched_rows_count,
  target.historical_registrations_count,
  target.matched_historical_years,
  2025,
  2025,
  'Abbinamento storico rifiutato: modello e alimentazione coincidevano, ma la potenza della versione non era stata verificata.',
  now()
FROM weak_year_targets_v1 AS target
ON CONFLICT (vehicle_cluster_id) DO NOTHING;

UPDATE mvp.vehicle_cluster_years_v1 AS years
SET
  year_from = 2025,
  year_to = 2025,
  estimation_method =
    'first_observed_in_current_eea_after_power_mismatch_guard',
  confidence = 'low',
  matched_rows_count = 0,
  historical_registrations_count = 0,
  matched_historical_years = ARRAY[]::integer[],
  source_name =
    'EEA CO2 monitoring 2025; abbinamento storico senza verifica della potenza scartato',
  built_at = now()
FROM weak_year_targets_v1 AS target
WHERE target.vehicle_cluster_id = years.vehicle_cluster_id;

-- Conserva la funzione finale precedente e normalizza le etichette usando i
-- campi anno effettivamente esposti. Per le PHEV verificate rende coerenti
-- anche potenza totale e potenza termica nella risposta API.
DO $block$
BEGIN
  IF to_regprocedure(
    'mvp.auto_tco_versions_before_year_sanity_v1(text)'
  ) IS NULL THEN
    IF to_regprocedure('public.auto_tco_versions(text)') IS NULL THEN
      RAISE EXCEPTION 'Funzione public.auto_tco_versions non disponibile';
    END IF;

    EXECUTE
      'ALTER FUNCTION public.auto_tco_versions(text) '
      'RENAME TO auto_tco_versions_before_year_sanity_v1';
    EXECUTE
      'ALTER FUNCTION public.auto_tco_versions_before_year_sanity_v1(text) '
      'SET SCHEMA mvp';
  END IF;
END;
$block$;

REVOKE ALL ON FUNCTION
  mvp.auto_tco_versions_before_year_sanity_v1(text)
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
      mvp.auto_tco_versions_before_year_sanity_v1(
        left(trim(p_model_id), 64)
      ) -> 'items'
    ) WITH ORDINALITY AS source(item, ordinality)
  ), normalized AS (
    SELECT
      CASE
        WHEN item ->> 'hybrid_type' = 'plug_in_hybrid'
          AND item ->> 'power_data_status' = 'verified'
          AND NULLIF(item ->> 'system_power_cv', '') IS NOT NULL
          AND NULLIF(item ->> 'thermal_power_cv', '') IS NOT NULL
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
              || ' ' || chr(183) || ' '
              || 'Ibrida plug-in '
              || CASE
                WHEN item ->> 'fuel_type' = 'diesel' THEN 'diesel'
                ELSE 'benzina'
              END
              || ' ' || chr(183) || ' '
              || round((item ->> 'system_power_cv')::numeric)::integer::text
              || ' CV ('
              || round((item ->> 'thermal_power_cv')::numeric)::integer::text
              || ' CV termici)'
            )
        )
        WHEN COALESCE(item ->> 'version_label', '') ~ '^[0-9]{4}'
          AND NULLIF(item ->> 'year_from', '') IS NOT NULL
          AND NULLIF(item ->> 'year_to', '') IS NOT NULL
        THEN item || jsonb_build_object(
          'version_label',
            regexp_replace(
              item ->> 'version_label',
              '^[0-9]{4}(-[0-9]{4})?',
              CASE
                WHEN (item ->> 'year_from')::integer
                  = (item ->> 'year_to')::integer
                  THEN item ->> 'year_from'
                ELSE (item ->> 'year_from')
                  || '-' || (item ->> 'year_to')
              END
            )
        )
        ELSE item
      END AS item,
      ordinality
    FROM source_item
  )
  SELECT jsonb_build_object(
    'items',
    COALESCE(
      jsonb_agg(item ORDER BY ordinality),
      '[]'::jsonb
    )
  )
  FROM normalized;
$function$;

COMMENT ON FUNCTION public.auto_tco_versions(text) IS
'Versioni pubbliche con anni coerenti con le prove disponibili: gli abbinamenti storici privi di verifica della potenza non vengono proiettati nel passato.';

REVOKE ALL ON FUNCTION public.auto_tco_versions(text)
FROM PUBLIC, authenticated;
GRANT EXECUTE ON FUNCTION public.auto_tco_versions(text) TO anon;

-- Riallinea la cache privata usata dal calcolo della manutenzione agli anni e
-- alle etichette appena pubblicati.
CREATE TEMP TABLE published_after_year_sanity_v1
AS
WITH brand_item AS (
  SELECT brand.item
  FROM jsonb_array_elements(
    public.auto_tco_brands() -> 'items'
  ) AS brand(item)
), model_item AS (
  SELECT DISTINCT model.item
  FROM brand_item AS brand
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_models(brand.item ->> 'brand_key') -> 'items'
  ) AS model(item)
), version_item AS (
  SELECT
    model.item ->> 'model_catalog_id' AS requested_model_catalog_id,
    version.item
  FROM model_item AS model
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(
      model.item ->> 'model_catalog_id'
    ) -> 'items'
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
      requested_model_catalog_id
    ) AS model_catalog_id,
    NULLIF(item ->> 'version_label', '') AS version_label,
    NULLIF(item ->> 'year_from', '')::integer AS year_from,
    NULLIF(item ->> 'year_to', '')::integer AS year_to,
    NULLIF(item ->> 'display_year', '')::integer AS display_year,
    COALESCE(NULLIF(item ->> 'year_source', ''), 'catalog_display_year')
      AS year_source,
    COALESCE(NULLIF(item ->> 'year_confidence', ''), 'low')
      AS year_confidence
  FROM version_item
)
SELECT DISTINCT ON (display_variant_id, vehicle_cluster_id)
  *
FROM normalized
WHERE display_variant_id IS NOT NULL
  AND vehicle_cluster_id IS NOT NULL
  AND version_label IS NOT NULL
  AND year_from BETWEEN 1900 AND 2100
  AND year_to BETWEEN year_from AND 2100
  AND display_year BETWEEN year_from AND year_to
ORDER BY
  display_variant_id,
  vehicle_cluster_id,
  year_to DESC,
  year_from DESC;

CREATE UNIQUE INDEX ON published_after_year_sanity_v1 (
  display_variant_id,
  vehicle_cluster_id
);

UPDATE mvp.maintenance_display_variant_inputs_v1 AS cache
SET
  model_catalog_id = published.model_catalog_id,
  version_label = published.version_label,
  year_from = published.year_from,
  year_to = published.year_to,
  display_year = published.display_year,
  year_source = published.year_source,
  year_confidence = published.year_confidence,
  built_at = now()
FROM published_after_year_sanity_v1 AS published
WHERE published.display_variant_id = cache.display_variant_id
  AND published.vehicle_cluster_id = cache.vehicle_cluster_id;

ANALYZE mvp.vehicle_cluster_years_v1;
ANALYZE mvp.maintenance_display_variant_inputs_v1;

NOTIFY pgrst, 'reload schema';

-- Verifica nello stesso passaggio: nessun metodo debole continua a produrre
-- anni storici, nessuna etichetta contraddice i campi anno e tutti i record
-- corretti rimangono calcolabili.
CREATE OR REPLACE FUNCTION pg_temp.safe_tco_year_sanity_v1(
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

CREATE TEMP TABLE corrected_year_results_v1
AS
SELECT
  published.vehicle_cluster_id,
  published.display_variant_id,
  pg_temp.safe_tco_year_sanity_v1(
    published.vehicle_cluster_id,
    published.display_variant_id
  ) AS payload
FROM published_after_year_sanity_v1 AS published
WHERE EXISTS (
  SELECT 1
  FROM weak_year_targets_v1 AS target
  WHERE target.vehicle_cluster_id = published.vehicle_cluster_id
);

DO $block$
DECLARE
  v_target_count integer;
  v_existing_corrections integer;
  v_weak_historical_remaining integer;
  v_label_mismatches integer;
  v_cache_mismatches integer;
  v_failed_results integer;
BEGIN
  SELECT count(*) INTO v_target_count
  FROM weak_year_targets_v1;

  SELECT count(*) INTO v_existing_corrections
  FROM mvp.vehicle_cluster_year_corrections_v1;

  SELECT count(*) INTO v_weak_historical_remaining
  FROM mvp.vehicle_cluster_years_v1 AS years
  JOIN mvp.site_vehicle_catalog_eea_v2 AS catalog
    ON catalog.vehicle_cluster_id = years.vehicle_cluster_id
  WHERE years.estimation_method IN (
      'exact_model_powertrain',
      'fuzzy_model_powertrain'
    )
    AND years.year_from < 2025
    AND (
      COALESCE(catalog.hybrid_type, 'none') <> 'plug_in_hybrid'
      OR NOT EXISTS (
        SELECT 1
        FROM verified_phev_clusters_v1 AS verified
        WHERE verified.vehicle_cluster_id = years.vehicle_cluster_id
      )
    );

  SELECT count(*) INTO v_label_mismatches
  FROM published_after_year_sanity_v1
  WHERE version_label !~ (
    '^'
    || CASE
      WHEN year_from = year_to THEN year_from::text
      ELSE year_from::text || '-' || year_to::text
    END
    || '([^0-9]|$)'
  );

  SELECT count(*) INTO v_cache_mismatches
  FROM published_after_year_sanity_v1 AS published
  JOIN mvp.maintenance_display_variant_inputs_v1 AS cache
    ON cache.display_variant_id = published.display_variant_id
   AND cache.vehicle_cluster_id = published.vehicle_cluster_id
  WHERE cache.year_from IS DISTINCT FROM published.year_from
     OR cache.year_to IS DISTINCT FROM published.year_to
     OR cache.display_year IS DISTINCT FROM published.display_year
     OR cache.version_label IS DISTINCT FROM published.version_label;

  SELECT count(*) INTO v_failed_results
  FROM corrected_year_results_v1
  WHERE payload ? '_audit_error'
     OR payload #>> '{quality,status}' <> 'ready';

  IF (v_target_count = 0 AND v_existing_corrections = 0)
    OR v_weak_historical_remaining <> 0
    OR v_label_mismatches <> 0
    OR v_cache_mismatches <> 0
    OR v_failed_results <> 0
    OR has_table_privilege(
      'anon',
      'mvp.vehicle_cluster_year_corrections_v1',
      'SELECT'
    )
    OR has_function_privilege(
      'anon',
      'mvp.auto_tco_versions_before_year_sanity_v1(text)',
      'EXECUTE'
    )
  THEN
    RAISE EXCEPTION
      'Verifica anni fallita: target %, deboli storici %, etichette %, cache %, calcoli %',
      v_target_count,
      v_weak_historical_remaining,
      v_label_mismatches,
      v_cache_mismatches,
      v_failed_results;
  END IF;
END;
$block$;

COMMIT;

WITH corrected AS (
  SELECT
    count(*)::integer AS versioni_corrette,
    count(*) FILTER (
      WHERE hybrid_type = 'plug_in_hybrid'
    )::integer AS plugin_non_verificate_corrette,
    count(*) FILTER (
      WHERE hybrid_type <> 'plug_in_hybrid'
    )::integer AS altre_versioni_corrette
  FROM weak_year_targets_v1
), results AS (
  SELECT
    count(*)::integer AS versioni_calcolate,
    count(*) FILTER (
      WHERE payload #>> '{quality,status}' = 'ready'
    )::integer AS risultati_ready
  FROM corrected_year_results_v1
), labels AS (
  SELECT count(*) FILTER (
    WHERE version_label !~ (
      '^'
      || CASE
        WHEN year_from = year_to THEN year_from::text
        ELSE year_from::text || '-' || year_to::text
      END
      || '([^0-9]|$)'
    )
  )::integer AS etichette_incoerenti
  FROM published_after_year_sanity_v1
)
SELECT
  corrected.versioni_corrette,
  (SELECT count(*) FROM mvp.vehicle_cluster_year_corrections_v1)
    AS correzioni_registrate,
  corrected.plugin_non_verificate_corrette,
  corrected.altre_versioni_corrette,
  (SELECT count(*) FROM verified_phev_clusters_v1)
    AS plugin_verificate_preservate,
  results.versioni_calcolate,
  results.risultati_ready,
  labels.etichette_incoerenti,
  NOT has_table_privilege(
    'anon',
    'mvp.vehicle_cluster_year_corrections_v1',
    'SELECT'
  ) AS registro_privato_protetto,
  NOT has_function_privilege(
    'anon',
    'mvp.auto_tco_versions_before_year_sanity_v1(text)',
    'EXECUTE'
  ) AS motore_precedente_protetto,
  CASE
    WHEN (
        corrected.versioni_corrette > 0
        OR (SELECT count(*)
            FROM mvp.vehicle_cluster_year_corrections_v1) > 0
      )
      AND results.risultati_ready = results.versioni_calcolate
      AND labels.etichette_incoerenti = 0
    THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM corrected
CROSS JOIN results
CROSS JOIN labels;
