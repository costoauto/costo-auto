\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - potenza commerciale di sistema per ibride plug-in.
--
-- Il campo EEA "ep" non consente di ricavare matematicamente la potenza
-- complessiva del sistema ibrido. Questa migrazione conserva quindi:
--   * la potenza termica verificata;
--   * la potenza totale di sistema verificata;
--   * la fonte pubblica puntuale.
--
-- Il catalogo privato non è leggibile direttamente dal browser. La API
-- espone soltanto i campi necessari nelle versioni già pubblicabili.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

CREATE TABLE IF NOT EXISTS mvp.phev_system_power_catalog_v1 (
  id bigserial PRIMARY KEY,
  brand_key text NOT NULL,
  model_catalog_id text NOT NULL,
  brand text NOT NULL,
  model text NOT NULL,
  year_from integer NOT NULL,
  year_to integer,
  system_power_kw numeric NOT NULL,
  system_power_cv numeric NOT NULL,
  thermal_power_kw numeric NOT NULL,
  thermal_power_cv numeric NOT NULL,
  representative_list_price_eur numeric,
  source_name text NOT NULL,
  source_url text NOT NULL,
  confidence text NOT NULL,
  imported_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT phev_system_power_years_check CHECK (
    year_from BETWEEN 1990 AND 2100
    AND (year_to IS NULL OR year_to BETWEEN year_from AND 2100)
  ),
  CONSTRAINT phev_system_power_values_check CHECK (
    system_power_kw > 0
    AND system_power_cv > 0
    AND thermal_power_kw > 0
    AND thermal_power_cv > 0
  ),
  CONSTRAINT phev_system_power_confidence_check CHECK (
    confidence IN ('high', 'medium', 'low')
  )
);

COMMENT ON TABLE mvp.phev_system_power_catalog_v1 IS
'Potenze di sistema e termiche PHEV derivate da schede tecniche pubbliche ADAC; dati privati esposti solo tramite RPC controllate.';

REVOKE ALL ON TABLE mvp.phev_system_power_catalog_v1
  FROM PUBLIC, anon, authenticated;
REVOKE ALL ON SEQUENCE mvp.phev_system_power_catalog_v1_id_seq
  FROM PUBLIC, anon, authenticated;

TRUNCATE TABLE mvp.phev_system_power_catalog_v1 RESTART IDENTITY;

\ir ../scripts/adac-phev-system-power.sql

CREATE INDEX IF NOT EXISTS idx_phev_system_power_model_year
ON mvp.phev_system_power_catalog_v1 (
  model_catalog_id,
  year_from,
  (COALESCE(year_to, 2099))
);

CREATE INDEX IF NOT EXISTS idx_phev_system_power_model_powers
ON mvp.phev_system_power_catalog_v1 (
  model_catalog_id,
  thermal_power_cv,
  system_power_cv
);

ANALYZE mvp.phev_system_power_catalog_v1;

-- Conserva la funzione di catalogo precedente una sola volta. Essa continua
-- a governare catalogo curato, intervalli storici e identificativi di calcolo.
DO $block$
BEGIN
  IF to_regprocedure(
    'mvp.auto_tco_versions_pre_system_power_v1(text)'
  ) IS NULL THEN
    IF to_regprocedure('public.auto_tco_versions(text)') IS NULL THEN
      RAISE EXCEPTION
        'Funzione public.auto_tco_versions(text) non disponibile';
    END IF;

    EXECUTE
      'ALTER FUNCTION public.auto_tco_versions(text) '
      'RENAME TO auto_tco_versions_pre_system_power_v1';
    EXECUTE
      'ALTER FUNCTION public.auto_tco_versions_pre_system_power_v1(text) '
      'SET SCHEMA mvp';
  END IF;
END;
$block$;

REVOKE ALL ON FUNCTION
  mvp.auto_tco_versions_pre_system_power_v1(text)
FROM PUBLIC, anon, authenticated;

CREATE OR REPLACE FUNCTION public.auto_tco_versions(p_model_id text)
RETURNS jsonb
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public
AS $function$
  WITH base_item AS (
    SELECT
      ordinality AS item_number,
      item,
      COALESCE(
        NULLIF(item ->> 'year_from', '')::integer,
        NULLIF(item ->> 'display_year', '')::integer
      ) AS item_year_from,
      COALESCE(
        NULLIF(item ->> 'year_to', '')::integer,
        NULLIF(item ->> 'display_year', '')::integer
      ) AS item_year_to,
      NULLIF(item ->> 'power_kw', '')::numeric AS declared_power_kw,
      NULLIF(item ->> 'power_cv', '')::numeric AS declared_power_cv
    FROM jsonb_array_elements(
      mvp.auto_tco_versions_pre_system_power_v1(
        left(trim(p_model_id), 64)
      ) -> 'items'
    ) WITH ORDINALITY AS source(item, ordinality)
  ), candidate_pair AS (
    SELECT
      base.item_number,
      base.item,
      catalog.system_power_kw,
      catalog.system_power_cv,
      catalog.thermal_power_kw,
      catalog.thermal_power_cv,
      min(catalog.source_name) AS source_name,
      min(catalog.source_url) AS source_url,
      min(catalog.confidence) AS confidence,
      min(
        GREATEST(base.item_year_from, catalog.year_from)
      ) AS matched_year_from,
      max(
        LEAST(base.item_year_to, COALESCE(catalog.year_to, 2099))
      ) AS matched_year_to,
      CASE
        WHEN
          abs(
            base.declared_power_kw - catalog.thermal_power_kw
          ) <= 2
          OR abs(
            base.declared_power_kw - catalog.system_power_kw
          ) <= 2
          OR abs(
            base.declared_power_cv - catalog.thermal_power_cv
          ) <= 3
          OR abs(
            base.declared_power_cv - catalog.system_power_cv
          ) <= 3
        THEN 1
        ELSE 2
      END AS match_rank
    FROM base_item AS base
    JOIN mvp.phev_system_power_catalog_v1 AS catalog
      ON catalog.model_catalog_id = base.item ->> 'model_catalog_id'
     AND catalog.year_from <= base.item_year_to
     AND COALESCE(catalog.year_to, 2099) >= base.item_year_from
    WHERE base.item ->> 'hybrid_type' = 'plug_in_hybrid'
      AND base.item_year_from IS NOT NULL
      AND base.item_year_to IS NOT NULL
    GROUP BY
      base.item_number,
      base.item,
      catalog.system_power_kw,
      catalog.system_power_cv,
      catalog.thermal_power_kw,
      catalog.thermal_power_cv,
      CASE
        WHEN
          abs(
            base.declared_power_kw - catalog.thermal_power_kw
          ) <= 2
          OR abs(
            base.declared_power_kw - catalog.system_power_kw
          ) <= 2
          OR abs(
            base.declared_power_cv - catalog.thermal_power_cv
          ) <= 3
          OR abs(
            base.declared_power_cv - catalog.system_power_cv
          ) <= 3
        THEN 1
        ELSE 2
      END
  ), candidate_stats AS (
    SELECT
      item_number,
      min(match_rank) AS best_match_rank,
      count(*) AS pair_count
    FROM candidate_pair
    GROUP BY item_number
  ), selected_pair AS (
    SELECT pair.*
    FROM candidate_pair AS pair
    JOIN candidate_stats AS stats USING (item_number)
    WHERE pair.match_rank = stats.best_match_rank
      AND (
        stats.best_match_rank = 1
        OR stats.pair_count = 1
      )
  ), expanded_item AS (
    SELECT
      base.item_number,
      0 AS variant_order,
      (
        base.item
        || jsonb_build_object(
          'display_variant_id',
            base.item ->> 'vehicle_cluster_id'
            || '#phev:'
            || round(selected.system_power_cv)::integer::text
            || ':'
            || round(selected.thermal_power_cv)::integer::text
            || ':'
            || selected.matched_year_from::text
            || '-'
            || selected.matched_year_to::text,
          'system_power_kw', selected.system_power_kw,
          'system_power_cv', selected.system_power_cv,
          'thermal_power_kw', selected.thermal_power_kw,
          'thermal_power_cv', selected.thermal_power_cv,
          'power_data_status', 'verified',
          'power_data_confidence', selected.confidence,
          'power_data_source', selected.source_name,
          'power_data_source_url', selected.source_url,
          'year_from', selected.matched_year_from,
          'year_to', selected.matched_year_to,
          'display_year',
            round(
              (
                selected.matched_year_from
                + selected.matched_year_to
              ) / 2.0
            )::integer,
          'years_in_range',
            selected.matched_year_to
            - selected.matched_year_from
            + 1
        )
      ) AS item
    FROM base_item AS base
    JOIN selected_pair AS selected USING (item_number)

    UNION ALL

    SELECT
      base.item_number,
      1 AS variant_order,
      (
        base.item
        || jsonb_build_object(
          'display_variant_id',
            base.item ->> 'vehicle_cluster_id',
          'power_data_status',
            CASE
              WHEN base.item ->> 'hybrid_type' = 'plug_in_hybrid'
                THEN 'unverified_system_power'
              ELSE 'not_applicable'
            END
        )
      ) AS item
    FROM base_item AS base
    WHERE NOT EXISTS (
      SELECT 1
      FROM selected_pair AS selected
      WHERE selected.item_number = base.item_number
    )
  ), deduplicated AS (
    SELECT DISTINCT ON (
      item ->> 'display_variant_id',
      item ->> 'year_from',
      item ->> 'year_to'
    )
      item_number,
      variant_order,
      item
    FROM expanded_item
    ORDER BY
      item ->> 'display_variant_id',
      item ->> 'year_from',
      item ->> 'year_to',
      item_number
  )
  SELECT jsonb_build_object(
    'items',
    COALESCE(
      jsonb_agg(
        item
        ORDER BY
          NULLIF(item ->> 'year_to', '')::integer DESC NULLS LAST,
          NULLIF(item ->> 'year_from', '')::integer DESC NULLS LAST,
          NULLIF(item ->> 'system_power_cv', '')::numeric
            DESC NULLS LAST,
          NULLIF(item ->> 'thermal_power_cv', '')::numeric
            DESC NULLS LAST,
          NULLIF(item ->> 'power_cv', '')::numeric DESC NULLS LAST,
          item ->> 'display_variant_id'
      ),
      '[]'::jsonb
    )
  )
  FROM deduplicated;
$function$;

COMMENT ON FUNCTION public.auto_tco_versions(text) IS
'Versioni pubbliche con potenza totale e termica PHEV separate quando verificate su schede tecniche pubbliche.';

REVOKE ALL ON FUNCTION public.auto_tco_versions(text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.auto_tco_versions(text) TO anon;

NOTIFY pgrst, 'reload schema';

-- Verifica unica: integrità, sicurezza, copertura e caso ambiguo Formentor.
DO $block$
DECLARE
  v_catalog_rows integer;
  v_invalid_rows integer;
  v_direct_read boolean;
  v_formentor_model_id text;
  v_formentor_versions jsonb;
  v_formentor_204 integer;
  v_formentor_245 integer;
  v_invalid_display_ids integer;
BEGIN
  SELECT count(*) INTO v_catalog_rows
  FROM mvp.phev_system_power_catalog_v1;

  SELECT count(*) INTO v_invalid_rows
  FROM mvp.phev_system_power_catalog_v1
  WHERE system_power_cv < thermal_power_cv
     OR system_power_kw < thermal_power_kw
     OR source_url !~ '^https://www[.]adac[.]de/';

  SELECT has_table_privilege(
    'anon',
    'mvp.phev_system_power_catalog_v1',
    'SELECT'
  ) INTO v_direct_read;

  SELECT model_catalog_id
  INTO v_formentor_model_id
  FROM mvp.phev_system_power_catalog_v1
  WHERE lower(brand) = 'cupra'
    AND lower(model) = 'formentor'
  LIMIT 1;

  v_formentor_versions :=
    public.auto_tco_versions(v_formentor_model_id) -> 'items';

  SELECT
    count(*) FILTER (
      WHERE round(NULLIF(item ->> 'system_power_cv', '')::numeric) = 204
        AND round(NULLIF(item ->> 'thermal_power_cv', '')::numeric) = 150
    ),
    count(*) FILTER (
      WHERE round(NULLIF(item ->> 'system_power_cv', '')::numeric) = 245
        AND round(NULLIF(item ->> 'thermal_power_cv', '')::numeric) = 150
    ),
    count(*) FILTER (
      WHERE COALESCE(item ->> 'display_variant_id', '') = ''
    )
  INTO
    v_formentor_204,
    v_formentor_245,
    v_invalid_display_ids
  FROM jsonb_array_elements(v_formentor_versions) AS version(item);

  IF v_catalog_rows < 600
    OR v_invalid_rows <> 0
    OR v_direct_read
    OR v_formentor_model_id IS NULL
    OR v_formentor_204 = 0
    OR v_formentor_245 = 0
    OR v_invalid_display_ids <> 0
  THEN
    RAISE EXCEPTION
      'Verifica potenze PHEV fallita: catalogo %, anomalie %, lettura %, Formentor 204 %, Formentor 245 %, id mancanti %',
      v_catalog_rows,
      v_invalid_rows,
      v_direct_read,
      v_formentor_204,
      v_formentor_245,
      v_invalid_display_ids;
  END IF;
END;
$block$;

COMMIT;

SELECT
  (SELECT count(*) FROM mvp.phev_system_power_catalog_v1)
    AS motorizzazioni_pubbliche_importate,
  (
    SELECT count(DISTINCT model_catalog_id)
    FROM mvp.phev_system_power_catalog_v1
  ) AS modelli_coperti,
  (
    SELECT count(*)
    FROM mvp.phev_system_power_catalog_v1
    WHERE system_power_cv > thermal_power_cv
  ) AS coppie_potenza_valide,
  (
    SELECT count(*)
    FROM jsonb_array_elements(
      public.auto_tco_versions(
        (
          SELECT model_catalog_id
          FROM mvp.phev_system_power_catalog_v1
          WHERE lower(brand) = 'cupra'
            AND lower(model) = 'formentor'
          LIMIT 1
        )
      ) -> 'items'
    ) AS version(item)
    WHERE round(NULLIF(item ->> 'system_power_cv', '')::numeric) = 204
      AND round(NULLIF(item ->> 'thermal_power_cv', '')::numeric) = 150
  ) AS formentor_204_150,
  (
    SELECT count(*)
    FROM jsonb_array_elements(
      public.auto_tco_versions(
        (
          SELECT model_catalog_id
          FROM mvp.phev_system_power_catalog_v1
          WHERE lower(brand) = 'cupra'
            AND lower(model) = 'formentor'
          LIMIT 1
        )
      ) -> 'items'
    ) AS version(item)
    WHERE round(NULLIF(item ->> 'system_power_cv', '')::numeric) = 245
      AND round(NULLIF(item ->> 'thermal_power_cv', '')::numeric) = 150
  ) AS formentor_245_150,
  NOT has_table_privilege(
    'anon',
    'mvp.phev_system_power_catalog_v1',
    'SELECT'
  ) AS dati_privati_protetti,
  CASE
    WHEN (
      SELECT count(*)
      FROM mvp.phev_system_power_catalog_v1
    ) >= 600
      AND NOT has_table_privilege(
        'anon',
        'mvp.phev_system_power_catalog_v1',
        'SELECT'
      )
    THEN 'ok'
    ELSE 'verificare'
  END AS verifica;
