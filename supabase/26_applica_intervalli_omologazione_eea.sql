-- Auto TCO - applica soltanto gli intervalli storici nuovi confermati dalla
-- continuita degli identificativi EEA Tipo/Variante/Versione.
--
-- La migrazione e' conservativa:
--   * non modifica i profili tecnici o i calcoli;
--   * mantiene una copia privata della funzione versioni precedente;
--   * pubblica soltanto intervalli che non tagliano un intervallo gia esposto;
--   * lascia invariati tutti i casi non confermati.

\set ON_ERROR_STOP on
\pset pager off

BEGIN;

SET LOCAL statement_timeout = '15min';

CREATE TABLE IF NOT EXISTS mvp.eea_historical_display_ranges_v1 (
  range_id text PRIMARY KEY,
  seed_model_id integer NOT NULL,
  brand text NOT NULL,
  model text NOT NULL,
  year_from integer NOT NULL,
  year_to integer NOT NULL,
  fuel_type text NOT NULL,
  hybrid_type text NOT NULL,
  display_power_cv integer NOT NULL,
  minimum_tvv_coverage numeric NOT NULL,
  member_count integer NOT NULL,
  thermal_consumption_min numeric,
  thermal_consumption_max numeric,
  electric_consumption_min numeric,
  electric_consumption_max numeric,
  confidence text NOT NULL,
  source_name text NOT NULL,
  source_url text NOT NULL,
  source_model_catalog_id text,
  calculation_vehicle_profile_id integer,
  registrations_in_range bigint,
  is_publishable boolean NOT NULL DEFAULT false,
  built_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT eea_historical_display_ranges_years_check
    CHECK (
      year_from BETWEEN 1900 AND 2100
      AND year_to BETWEEN year_from AND 2100
    ),
  CONSTRAINT eea_historical_display_ranges_confidence_check
    CHECK (confidence IN ('high', 'medium', 'low'))
);

CREATE TABLE IF NOT EXISTS mvp.eea_historical_display_range_members_v1 (
  range_id text NOT NULL
    REFERENCES mvp.eea_historical_display_ranges_v1(range_id)
    ON DELETE CASCADE,
  historical_version_id text NOT NULL,
  vehicle_profile_id integer,
  PRIMARY KEY (range_id, historical_version_id),
  UNIQUE (historical_version_id)
);

COMMENT ON TABLE mvp.eea_historical_display_ranges_v1 IS
'Intervalli commerciali storici confermati da continuita EEA Tipo/Variante/Versione, potenza e consumo compatibili.';

COMMENT ON TABLE mvp.eea_historical_display_range_members_v1 IS
'Profili annuali EEA che compongono ogni intervallo storico mostrato nel sito.';

REVOKE ALL ON TABLE mvp.eea_historical_display_ranges_v1
  FROM PUBLIC, anon, authenticated;
REVOKE ALL ON TABLE mvp.eea_historical_display_range_members_v1
  FROM PUBLIC, anon, authenticated;

TRUNCATE TABLE
  mvp.eea_historical_display_range_members_v1,
  mvp.eea_historical_display_ranges_v1;

\ir 26_tvv_display_ranges_data.sql

-- Collega gli identificativi stabili del file EEA ai profili interni creati
-- dalla migrazione dello storico.
UPDATE mvp.eea_historical_display_range_members_v1 AS member
SET vehicle_profile_id = profile.id
FROM mvp.eea_historical_versions_compact_v1 AS historical
JOIN mvp.vehicle_profiles AS profile
  ON profile.seed_model_id = historical.seed_model_id
 AND profile.representative_year = historical.representative_year
 AND profile.fuel_type = historical.fuel_type
 AND COALESCE(profile.hybrid_type, 'none') = historical.hybrid_type
 AND abs(profile.power_kw - historical.power_kw) <= 0.01
 AND profile.profile_kind = 'eea_historical_compact_v1'
 AND profile.profile_status = 'active'
WHERE historical.historical_version_id = member.historical_version_id;

-- Identifica il modello pubblico al quale appartiene ogni intervallo.
WITH model_counts AS (
  SELECT
    member.range_id,
    catalog.model_catalog_id,
    count(*) AS matched_members,
    row_number() OVER (
      PARTITION BY member.range_id
      ORDER BY
        count(*) DESC,
        catalog.model_catalog_id
    ) AS model_rank
  FROM mvp.eea_historical_display_range_members_v1 AS member
  JOIN mvp.site_vehicle_catalog_publishable_v1 AS catalog
    ON catalog.vehicle_profile_id = member.vehicle_profile_id
  GROUP BY member.range_id, catalog.model_catalog_id
)
UPDATE mvp.eea_historical_display_ranges_v1 AS range
SET source_model_catalog_id = model_counts.model_catalog_id
FROM model_counts
WHERE model_counts.range_id = range.range_id
  AND model_counts.model_rank = 1;

-- Sceglie per il calcolo il profilo piu vicino al centro dell'intervallo,
-- privilegiando quello con piu immatricolazioni EEA.
WITH ranked_profiles AS (
  SELECT
    range.range_id,
    member.vehicle_profile_id,
    historical.registrations_count,
    row_number() OVER (
      PARTITION BY range.range_id
      ORDER BY
        abs(
          historical.representative_year
          - ((range.year_from + range.year_to) / 2.0)
        ),
        historical.registrations_count DESC,
        member.vehicle_profile_id
    ) AS profile_rank
  FROM mvp.eea_historical_display_ranges_v1 AS range
  JOIN mvp.eea_historical_display_range_members_v1 AS member
    ON member.range_id = range.range_id
  JOIN mvp.eea_historical_versions_compact_v1 AS historical
    ON historical.historical_version_id = member.historical_version_id
  WHERE member.vehicle_profile_id IS NOT NULL
), registration_totals AS (
  SELECT
    member.range_id,
    sum(historical.registrations_count)::bigint AS registrations_in_range
  FROM mvp.eea_historical_display_range_members_v1 AS member
  JOIN mvp.eea_historical_versions_compact_v1 AS historical
    ON historical.historical_version_id = member.historical_version_id
  GROUP BY member.range_id
)
UPDATE mvp.eea_historical_display_ranges_v1 AS range
SET
  calculation_vehicle_profile_id = ranked_profiles.vehicle_profile_id,
  registrations_in_range = registration_totals.registrations_in_range
FROM ranked_profiles
JOIN registration_totals
  ON registration_totals.range_id = ranked_profiles.range_id
WHERE ranked_profiles.range_id = range.range_id
  AND ranked_profiles.profile_rank = 1;

CREATE INDEX IF NOT EXISTS
  idx_eea_historical_display_ranges_model
ON mvp.eea_historical_display_ranges_v1 (
  source_model_catalog_id,
  year_from,
  year_to
);

CREATE INDEX IF NOT EXISTS
  idx_eea_historical_display_range_members_profile
ON mvp.eea_historical_display_range_members_v1 (vehicle_profile_id);

-- Conserva una sola volta la funzione precedente, che continua a gestire
-- catalogo curato, versioni recenti e tutti i casi non coperti qui.
DO $block$
BEGIN
  IF to_regprocedure('mvp.auto_tco_versions_base_v1(text)') IS NULL THEN
    EXECUTE
      'ALTER FUNCTION public.auto_tco_versions(text) '
      'RENAME TO auto_tco_versions_base_v1';
    EXECUTE
      'ALTER FUNCTION public.auto_tco_versions_base_v1(text) SET SCHEMA mvp';
  END IF;
END;
$block$;

REVOKE ALL ON FUNCTION mvp.auto_tco_versions_base_v1(text)
  FROM PUBLIC, anon, authenticated;

-- Un intervallo nuovo viene pubblicato soltanto se gli elementi compatibili
-- della API precedente sono interamente contenuti nel nuovo intervallo.
-- Questo evita di cancellare accidentalmente anni esterni.
UPDATE mvp.eea_historical_display_ranges_v1 AS range
SET is_publishable = (
  range.source_model_catalog_id IS NOT NULL
  AND range.calculation_vehicle_profile_id IS NOT NULL
  AND NOT EXISTS (
    SELECT 1
    FROM jsonb_array_elements(
      mvp.auto_tco_versions_base_v1(range.source_model_catalog_id) -> 'items'
    ) AS old_item
    WHERE old_item ->> 'year_source' <> 'curated_commercial_catalog'
      AND old_item ->> 'fuel_type' = range.fuel_type
      AND COALESCE(old_item ->> 'hybrid_type', 'none') = range.hybrid_type
      AND NULLIF(old_item ->> 'power_cv', '')::numeric
        BETWEEN range.display_power_cv - 5 AND range.display_power_cv + 5
      AND (old_item ->> 'year_from')::integer <= range.year_to
      AND (old_item ->> 'year_to')::integer >= range.year_from
      AND NOT (
        (old_item ->> 'year_from')::integer >= range.year_from
        AND (old_item ->> 'year_to')::integer <= range.year_to
      )
  )
);

CREATE OR REPLACE FUNCTION public.auto_tco_versions(p_model_id text)
RETURNS jsonb
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public
AS $function$
  WITH requested AS (
    SELECT
      left(trim(p_model_id), 64) AS model_id,
      COALESCE(
        curation.source_model_catalog_id,
        left(trim(p_model_id), 64)
      ) AS source_model_id,
      COALESCE(
        curation.include_uncurated_source_versions,
        true
      ) AS include_uncurated_source_versions
    FROM (SELECT 1) AS singleton
    LEFT JOIN mvp.site_vehicle_model_curations_v1 AS curation
      ON curation.public_model_id = left(trim(p_model_id), 64)
  ), old_item AS (
    SELECT item
    FROM jsonb_array_elements(
      mvp.auto_tco_versions_base_v1(left(trim(p_model_id), 64)) -> 'items'
    ) AS item
  ), retained_old_item AS (
    SELECT old_item.item
    FROM old_item
    CROSS JOIN requested
    WHERE old_item.item ->> 'year_source' = 'curated_commercial_catalog'
       OR NOT EXISTS (
         SELECT 1
         FROM mvp.eea_historical_display_ranges_v1 AS range
         WHERE range.is_publishable
           AND range.source_model_catalog_id = requested.source_model_id
           AND old_item.item ->> 'fuel_type' = range.fuel_type
           AND COALESCE(old_item.item ->> 'hybrid_type', 'none')
             = range.hybrid_type
           AND NULLIF(old_item.item ->> 'power_cv', '')::numeric
             BETWEEN range.display_power_cv - 5
                 AND range.display_power_cv + 5
           AND (old_item.item ->> 'year_from')::integer >= range.year_from
           AND (old_item.item ->> 'year_to')::integer <= range.year_to
       )
  ), range_source AS (
    SELECT
      range.*,
      profile.representative_year,
      profile.power_kw,
      profile.power_cv AS calculation_power_cv,
      profile.seed_model_id AS calculation_seed_model_id,
      catalog.energy_data_status,
      catalog.depreciation_data_status,
      catalog.observation_quality,
      catalog.registrations_count
    FROM mvp.eea_historical_display_ranges_v1 AS range
    CROSS JOIN requested
    JOIN mvp.vehicle_profiles AS profile
      ON profile.id = range.calculation_vehicle_profile_id
    LEFT JOIN mvp.site_vehicle_catalog_publishable_v1 AS catalog
      ON catalog.vehicle_profile_id = range.calculation_vehicle_profile_id
     AND catalog.model_catalog_id = range.source_model_catalog_id
    WHERE range.is_publishable
      AND requested.include_uncurated_source_versions
      AND range.source_model_catalog_id = requested.source_model_id
      AND NOT EXISTS (
        SELECT 1
        FROM mvp.site_vehicle_model_curations_v1 AS curation
        WHERE curation.source_model_catalog_id = range.source_model_catalog_id
          AND range.year_from <= curation.replace_source_year_to
          AND range.year_to >= curation.replace_source_year_from
      )
  ), range_item AS (
    SELECT jsonb_build_object(
      'vehicle_cluster_id',
        'profile:' || calculation_vehicle_profile_id::text,
      'model_catalog_id', requested.model_id,
      'vehicle_profile_id', calculation_vehicle_profile_id,
      'seed_model_id',
        COALESCE(calculation_seed_model_id, seed_model_id),
      'brand', brand,
      'model', model,
      'version_label',
        (
          CASE
            WHEN year_from = year_to THEN year_from::text
            ELSE year_from::text || '-' || year_to::text
          END
          || ' ' || chr(183) || ' '
          || CASE
            WHEN hybrid_type = 'plug_in_hybrid' THEN
              'Ibrida plug-in '
              || CASE fuel_type WHEN 'diesel' THEN 'diesel' ELSE 'benzina' END
            WHEN hybrid_type = 'hybrid' THEN
              'Ibrida '
              || CASE fuel_type WHEN 'diesel' THEN 'diesel' ELSE 'benzina' END
            WHEN fuel_type = 'electric' THEN 'Elettrica'
            WHEN fuel_type = 'petrol' THEN 'Benzina'
            WHEN fuel_type = 'diesel' THEN 'Diesel'
            WHEN fuel_type = 'lpg' THEN 'GPL'
            WHEN fuel_type = 'ng' THEN 'Metano'
            ELSE initcap(fuel_type)
          END
          || ' ' || chr(183) || ' ' || display_power_cv::text || ' CV'
        ),
      'representative_year', representative_year,
      'display_year', round((year_from + year_to) / 2.0)::integer,
      'year_from', year_from,
      'year_to', year_to,
      'years_in_range', year_to - year_from + 1,
      'year_source', 'eea_type_variant_continuity',
      'year_confidence', confidence,
      'fuel_type', fuel_type,
      'hybrid_type', hybrid_type,
      'powertrain_type',
        CASE
          WHEN fuel_type = 'electric' THEN 'electric'
          WHEN hybrid_type = 'plug_in_hybrid' THEN 'plug_in_hybrid'
          WHEN hybrid_type = 'hybrid' THEN 'hybrid'
          ELSE 'combustion'
        END,
      'power_kw', power_kw,
      'power_cv', display_power_cv,
      'transmission_label', NULL,
      'gear_count', NULL,
      'commercial_name', NULL,
      'data_source', source_name,
      'data_source_url', source_url,
      'energy_data_status', COALESCE(energy_data_status, 'ready'),
      'depreciation_data_status',
        COALESCE(depreciation_data_status, 'original_profile'),
      'observation_quality', confidence,
      'registrations_count', COALESCE(registrations_count, 0),
      'registrations_in_range', COALESCE(registrations_in_range, 0)
    ) AS item
    FROM range_source
    CROSS JOIN requested
  ), combined AS (
    SELECT item FROM retained_old_item
    UNION ALL
    SELECT item FROM range_item
  )
  SELECT jsonb_build_object(
    'items',
    COALESCE(
      jsonb_agg(
        item
        ORDER BY
          (item ->> 'year_to')::integer DESC,
          (item ->> 'year_from')::integer DESC,
          NULLIF(item ->> 'registrations_in_range', '')::bigint DESC NULLS LAST,
          item ->> 'fuel_type',
          NULLIF(item ->> 'power_cv', '')::numeric NULLS LAST,
          item ->> 'vehicle_cluster_id'
      ),
      '[]'::jsonb
    )
  )
  FROM combined;
$function$;

COMMENT ON FUNCTION public.auto_tco_versions(text) IS
'Versioni del sito: catalogo precedente piu intervalli storici EEA confermati da continuita di omologazione.';

REVOKE ALL ON FUNCTION public.auto_tco_versions(text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.auto_tco_versions(text) TO anon;

NOTIFY pgrst, 'reload schema';

-- Verifica integrata.
DO $block$
DECLARE
  v_ranges integer;
  v_members integer;
  v_unlinked integer;
  v_publishable integer;
  v_partial_overlap integer;
BEGIN
  SELECT count(*) INTO v_ranges
  FROM mvp.eea_historical_display_ranges_v1;

  SELECT count(*) INTO v_members
  FROM mvp.eea_historical_display_range_members_v1;

  SELECT count(*) INTO v_unlinked
  FROM mvp.eea_historical_display_range_members_v1
  WHERE vehicle_profile_id IS NULL;

  SELECT count(*) INTO v_publishable
  FROM mvp.eea_historical_display_ranges_v1
  WHERE is_publishable;

  SELECT count(*) INTO v_partial_overlap
  FROM mvp.eea_historical_display_ranges_v1 AS range
  CROSS JOIN LATERAL jsonb_array_elements(
    mvp.auto_tco_versions_base_v1(range.source_model_catalog_id) -> 'items'
  ) AS old_item
  WHERE range.is_publishable
    AND old_item ->> 'year_source' <> 'curated_commercial_catalog'
    AND old_item ->> 'fuel_type' = range.fuel_type
    AND COALESCE(old_item ->> 'hybrid_type', 'none') = range.hybrid_type
    AND NULLIF(old_item ->> 'power_cv', '')::numeric
      BETWEEN range.display_power_cv - 5 AND range.display_power_cv + 5
    AND (old_item ->> 'year_from')::integer <= range.year_to
    AND (old_item ->> 'year_to')::integer >= range.year_from
    AND NOT (
      (old_item ->> 'year_from')::integer >= range.year_from
      AND (old_item ->> 'year_to')::integer <= range.year_to
    );

  IF v_ranges = 0
     OR v_members = 0
     OR v_publishable = 0
     OR v_partial_overlap <> 0 THEN
    RAISE EXCEPTION
      'Intervalli EEA non applicati: ranges %, members %, unlinked %, publishable %, partial %',
      v_ranges,
      v_members,
      v_unlinked,
      v_publishable,
      v_partial_overlap;
  END IF;
END;
$block$;

WITH sample_range AS (
  SELECT *
  FROM mvp.eea_historical_display_ranges_v1
  WHERE is_publishable
  ORDER BY registrations_in_range DESC, range_id
  LIMIT 1
), sample_versions AS (
  SELECT item
  FROM sample_range
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(sample_range.source_model_catalog_id) -> 'items'
  ) AS item
)
SELECT
  (SELECT count(*) FROM mvp.eea_historical_display_ranges_v1)
    AS intervalli_confermati_caricati,
  (SELECT count(*) FROM mvp.eea_historical_display_ranges_v1
   WHERE is_publishable) AS intervalli_pubblicati,
  (SELECT count(*) FROM mvp.eea_historical_display_range_members_v1)
    AS profili_annuali_collegati,
  (SELECT count(*) FROM mvp.eea_historical_display_range_members_v1
   WHERE vehicle_profile_id IS NULL) AS profili_non_collegati,
  (SELECT count(*) FROM sample_versions
   WHERE item ->> 'year_source' = 'eea_type_variant_continuity')
    AS intervalli_visibili_nel_modello_test,
  (SELECT item ->> 'version_label'
   FROM sample_versions
   WHERE item ->> 'year_source' = 'eea_type_variant_continuity'
   LIMIT 1) AS esempio_intervallo,
  CASE
    WHEN (SELECT count(*) FROM mvp.eea_historical_display_ranges_v1
          WHERE is_publishable) > 0
      THEN 'ok'
    ELSE 'verificare'
  END AS verifica;

COMMIT;
