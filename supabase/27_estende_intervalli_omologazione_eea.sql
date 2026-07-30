-- Auto TCO - seconda passata sugli intervalli storici.
--
-- Estende la continuita di omologazione:
--   * collega osservazioni EEA distanti al massimo tre anni;
--   * richiede Tipo/Variante o TVV e copertura minima elevata;
--   * collega il catalogo storico 2010-2024 al catalogo EEA 2025;
--   * non modifica dati tecnici o formule TCO;
--   * continua a pubblicare soltanto intervalli che non tagliano quelli
--     esistenti nella funzione base.

\set ON_ERROR_STOP on
\pset pager off

BEGIN;

SET LOCAL statement_timeout = '15min';

TRUNCATE TABLE
  mvp.eea_historical_display_range_members_v1,
  mvp.eea_historical_display_ranges_v1;

\ir 27_tvv_gap_display_ranges_data.sql

-- I membri 2025 arrivano gia collegati al profilo corrente. Qui vengono
-- collegati soltanto i membri storici 2010-2024 ancora privi di ID interno.
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
WHERE member.vehicle_profile_id IS NULL
  AND historical.historical_version_id = member.historical_version_id;

-- Identifica il modello pubblico prevalente per ogni intervallo.
WITH model_counts AS (
  SELECT
    member.range_id,
    catalog.model_catalog_id,
    count(*) AS matched_members,
    row_number() OVER (
      PARTITION BY member.range_id
      ORDER BY count(*) DESC, catalog.model_catalog_id
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

-- Raccoglie anno e numerosita per scegliere un solo profilo rappresentativo,
-- senza duplicare i membri che compaiono nel catalogo pubblico.
WITH member_stats AS (
  SELECT
    member.range_id,
    member.vehicle_profile_id,
    profile.representative_year,
    COALESCE(
      historical.registrations_count,
      (
        SELECT max(catalog.registrations_count)
        FROM mvp.site_vehicle_catalog_publishable_v1 AS catalog
        WHERE catalog.vehicle_profile_id = member.vehicle_profile_id
      ),
      0
    )::bigint AS registrations_count
  FROM mvp.eea_historical_display_range_members_v1 AS member
  JOIN mvp.vehicle_profiles AS profile
    ON profile.id = member.vehicle_profile_id
  LEFT JOIN mvp.eea_historical_versions_compact_v1 AS historical
    ON historical.historical_version_id = member.historical_version_id
  WHERE member.vehicle_profile_id IS NOT NULL
), ranked_profiles AS (
  SELECT
    range.range_id,
    stats.vehicle_profile_id,
    row_number() OVER (
      PARTITION BY range.range_id
      ORDER BY
        abs(
          stats.representative_year
          - ((range.year_from + range.year_to) / 2.0)
        ),
        stats.registrations_count DESC,
        stats.vehicle_profile_id
    ) AS profile_rank
  FROM mvp.eea_historical_display_ranges_v1 AS range
  JOIN member_stats AS stats
    ON stats.range_id = range.range_id
), registration_totals AS (
  SELECT
    range_id,
    sum(registrations_count)::bigint AS registrations_in_range
  FROM member_stats
  GROUP BY range_id
)
UPDATE mvp.eea_historical_display_ranges_v1 AS range
SET
  calculation_vehicle_profile_id = ranked.vehicle_profile_id,
  registrations_in_range = totals.registrations_in_range
FROM ranked_profiles AS ranked
JOIN registration_totals AS totals
  ON totals.range_id = ranked.range_id
WHERE ranked.range_id = range.range_id
  AND ranked.profile_rank = 1;

-- Stesso criterio prudenziale della prima passata: un nuovo intervallo viene
-- pubblicato soltanto se non taglia parzialmente una riga della funzione base.
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

NOTIFY pgrst, 'reload schema';

DO $block$
DECLARE
  v_ranges integer;
  v_members integer;
  v_unlinked integer;
  v_missing_model integer;
  v_missing_calculation integer;
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

  SELECT count(*) INTO v_missing_model
  FROM mvp.eea_historical_display_ranges_v1
  WHERE source_model_catalog_id IS NULL;

  SELECT count(*) INTO v_missing_calculation
  FROM mvp.eea_historical_display_ranges_v1
  WHERE calculation_vehicle_profile_id IS NULL;

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

  IF v_ranges < 900
     OR v_members < 3500
     OR v_publishable = 0
     OR v_partial_overlap <> 0 THEN
    RAISE EXCEPTION
      'Intervalli EEA estesi non applicati: ranges %, members %, unlinked %, missing model %, missing calculation %, publishable %, partial %',
      v_ranges,
      v_members,
      v_unlinked,
      v_missing_model,
      v_missing_calculation,
      v_publishable,
      v_partial_overlap;
  END IF;
END;
$block$;

WITH sample_range AS (
  SELECT *
  FROM mvp.eea_historical_display_ranges_v1
  WHERE is_publishable
  ORDER BY
    (year_to = 2025) DESC,
    registrations_in_range DESC,
    range_id
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
    AS profili_collegati,
  (SELECT count(*) FROM mvp.eea_historical_display_range_members_v1
   WHERE vehicle_profile_id IS NULL) AS profili_non_collegati,
  (SELECT count(*) FROM mvp.eea_historical_display_ranges_v1
   WHERE year_to = 2025) AS intervalli_collegati_al_2025,
  (SELECT count(*) FROM mvp.eea_historical_display_ranges_v1
   WHERE year_to = 2025 AND is_publishable)
    AS intervalli_2025_pubblicati,
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
