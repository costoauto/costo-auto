\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - audit diagnostico degli anni mostrati nel catalogo pubblico.
--
-- Non modifica alcun dato. Distingue:
--   1. errori certi di struttura o di etichetta;
--   2. intervalli incompatibili con le osservazioni tecniche disponibili;
--   3. intervalli lunghi sostenuti soltanto da una fonte debole, da
--      verificare successivamente con fonti commerciali pubbliche.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

CREATE TEMP TABLE audit_year_models_v1
ON COMMIT DROP
AS
WITH base AS (
  SELECT DISTINCT
    catalog.model_catalog_id AS public_model_id,
    catalog.model_catalog_id AS source_model_catalog_id,
    catalog.brand,
    catalog.model
  FROM mvp.site_vehicle_catalog_unified_v1 AS catalog
  WHERE NOT EXISTS (
    SELECT 1
    FROM mvp.site_vehicle_model_curations_v1 AS curation
    WHERE curation.source_model_catalog_id = catalog.model_catalog_id
  )
), curated AS (
  SELECT DISTINCT
    curation.public_model_id,
    curation.source_model_catalog_id,
    curation.brand,
    curation.model
  FROM mvp.site_vehicle_model_curations_v1 AS curation
  WHERE EXISTS (
    SELECT 1
    FROM mvp.site_vehicle_version_curations_v1 AS version
    WHERE version.public_model_id = curation.public_model_id
      AND version.is_active
  )
)
SELECT * FROM base
UNION ALL
SELECT * FROM curated;

CREATE INDEX ON audit_year_models_v1 (public_model_id);
CREATE INDEX ON audit_year_models_v1 (source_model_catalog_id);

CREATE TEMP TABLE audit_public_years_v1
ON COMMIT DROP
AS
SELECT
  row_number() OVER (
    ORDER BY
      model.brand,
      model.model,
      NULLIF(item ->> 'year_from', '')::integer,
      COALESCE(
        NULLIF(item ->> 'display_variant_id', ''),
        NULLIF(item ->> 'vehicle_cluster_id', '')
      )
  )::bigint AS audit_id,
  model.public_model_id,
  model.source_model_catalog_id,
  COALESCE(NULLIF(item ->> 'brand', ''), model.brand) AS brand,
  COALESCE(NULLIF(item ->> 'model', ''), model.model) AS model,
  COALESCE(
    NULLIF(item ->> 'display_variant_id', ''),
    NULLIF(item ->> 'vehicle_cluster_id', '')
  ) AS display_variant_id,
  NULLIF(item ->> 'vehicle_cluster_id', '') AS vehicle_cluster_id,
  NULLIF(item ->> 'vehicle_profile_id', '')::integer
    AS vehicle_profile_id,
  NULLIF(item ->> 'seed_model_id', '')::integer AS seed_model_id,
  NULLIF(item ->> 'version_label', '') AS version_label,
  NULLIF(item ->> 'year_from', '')::integer AS year_from,
  NULLIF(item ->> 'year_to', '')::integer AS year_to,
  NULLIF(item ->> 'display_year', '')::integer AS display_year,
  NULLIF(item ->> 'year_source', '') AS year_source,
  NULLIF(item ->> 'year_confidence', '') AS year_confidence,
  NULLIF(item ->> 'fuel_type', '') AS fuel_type,
  COALESCE(NULLIF(item ->> 'hybrid_type', ''), 'none') AS hybrid_type,
  NULLIF(item ->> 'powertrain_type', '') AS powertrain_type,
  NULLIF(item ->> 'power_kw', '')::numeric AS power_kw,
  NULLIF(item ->> 'power_cv', '')::numeric AS power_cv,
  NULLIF(item ->> 'system_power_cv', '')::numeric AS system_power_cv,
  NULLIF(item ->> 'thermal_power_cv', '')::numeric AS thermal_power_cv,
  NULLIF(item ->> 'power_data_status', '') AS power_data_status,
  NULLIF(item ->> 'data_source', '') AS data_source,
  NULLIF(item ->> 'data_source_url', '') AS data_source_url,
  CASE
    WHEN COALESCE(item ->> 'version_label', '') ~ '^[0-9]{4}'
      THEN substring(item ->> 'version_label' FROM '^([0-9]{4})')::integer
    ELSE NULL
  END AS label_year_from,
  CASE
    WHEN COALESCE(item ->> 'version_label', '')
      ~ '^[0-9]{4}-[0-9]{4}'
      THEN substring(
        item ->> 'version_label'
        FROM '^[0-9]{4}-([0-9]{4})'
      )::integer
    WHEN COALESCE(item ->> 'version_label', '') ~ '^[0-9]{4}'
      THEN substring(item ->> 'version_label' FROM '^([0-9]{4})')::integer
    ELSE NULL
  END AS label_year_to
FROM audit_year_models_v1 AS model
CROSS JOIN LATERAL jsonb_array_elements(
  public.auto_tco_versions(model.public_model_id) -> 'items'
) AS version(item);

CREATE INDEX ON audit_public_years_v1 (audit_id);
CREATE INDEX ON audit_public_years_v1 (
  source_model_catalog_id,
  fuel_type,
  hybrid_type,
  year_from,
  year_to
);
ANALYZE audit_public_years_v1;

-- Prima e ultima osservazione EEA dello stesso modello. Sono informazioni
-- diagnostiche, non date di lancio: un modello puo essere stato presentato o
-- commercializzato prima di comparire nelle immatricolazioni EEA disponibili.
CREATE TEMP TABLE audit_model_year_evidence_v1
ON COMMIT DROP
AS
SELECT
  historical.seed_model_id,
  min(historical.representative_year)::integer AS first_eea_year,
  max(historical.representative_year)::integer AS last_eea_year,
  count(DISTINCT historical.representative_year)::integer
    AS observed_year_count,
  array_agg(
    DISTINCT historical.representative_year
    ORDER BY historical.representative_year
  ) AS observed_years
FROM mvp.eea_historical_versions_compact_v1 AS historical
GROUP BY historical.seed_model_id;

CREATE INDEX ON audit_model_year_evidence_v1 (seed_model_id);

CREATE TEMP TABLE audit_year_evidence_v1
ON COMMIT DROP
AS
SELECT
  version.*,
  profile.representative_year AS profile_representative_year,
  cluster_years.estimation_method AS cluster_year_method,
  cluster_years.confidence AS cluster_year_confidence,
  cluster_years.matched_historical_years AS cluster_observed_years,
  model_years.first_eea_year AS model_first_eea_year,
  model_years.last_eea_year AS model_last_eea_year,
  range_evidence.range_id AS matched_range_id,
  range_evidence.confidence AS range_confidence,
  range_evidence.member_years AS range_member_years,
  technical_evidence.observed_years AS technical_observed_years,
  CASE
    WHEN version.year_source = 'curated_commercial_catalog'
      THEN 'curated_public_source'
    WHEN version.hybrid_type = 'plug_in_hybrid'
      AND version.power_data_status = 'verified'
      THEN 'verified_phev_public_source'
    WHEN version.year_source = 'eea_type_variant_continuity'
      THEN 'eea_tvv_members'
    WHEN technical_evidence.observed_years IS NOT NULL
      THEN 'yearly_technical_catalog'
    WHEN cluster_years.vehicle_cluster_id IS NOT NULL
      THEN 'cluster_history_match'
    WHEN profile.representative_year IS NOT NULL
      THEN 'original_profile_year'
    ELSE 'missing'
  END AS evidence_kind,
  CASE
    WHEN version.year_source = 'curated_commercial_catalog'
      THEN NULL::integer[]
    WHEN version.hybrid_type = 'plug_in_hybrid'
      AND version.power_data_status = 'verified'
      THEN ARRAY(
        SELECT generate_series(version.year_from, version.year_to)
      )
    WHEN version.year_source = 'eea_type_variant_continuity'
      THEN range_evidence.member_years
    WHEN technical_evidence.observed_years IS NOT NULL
      THEN technical_evidence.observed_years
    WHEN cluster_years.vehicle_cluster_id IS NOT NULL
      THEN ARRAY(
        SELECT DISTINCT observed_year
        FROM unnest(
          COALESCE(
            cluster_years.matched_historical_years,
            ARRAY[]::integer[]
          ) || ARRAY[2025]
        ) AS observed(observed_year)
        ORDER BY observed_year
      )
    WHEN profile.representative_year IS NOT NULL
      THEN ARRAY[profile.representative_year]
    ELSE ARRAY[]::integer[]
  END AS supporting_years
FROM audit_public_years_v1 AS version
LEFT JOIN mvp.vehicle_profiles AS profile
  ON profile.id = version.vehicle_profile_id
LEFT JOIN mvp.vehicle_cluster_years_v1 AS cluster_years
  ON cluster_years.vehicle_cluster_id = version.vehicle_cluster_id
LEFT JOIN audit_model_year_evidence_v1 AS model_years
  ON model_years.seed_model_id = version.seed_model_id
LEFT JOIN LATERAL (
  SELECT
    range.range_id,
    range.confidence,
    member_years.member_years
  FROM mvp.eea_historical_display_ranges_v1 AS range
  LEFT JOIN LATERAL (
    SELECT array_agg(
      DISTINCT member_profile.representative_year
      ORDER BY member_profile.representative_year
    ) FILTER (
      WHERE member_profile.representative_year IS NOT NULL
    ) AS member_years
    FROM mvp.eea_historical_display_range_members_v1 AS member
    LEFT JOIN mvp.vehicle_profiles AS member_profile
      ON member_profile.id = member.vehicle_profile_id
    WHERE member.range_id = range.range_id
  ) AS member_years ON true
  WHERE version.year_source = 'eea_type_variant_continuity'
    AND range.is_publishable
    AND range.source_model_catalog_id = version.source_model_catalog_id
    AND range.year_from = version.year_from
    AND range.year_to = version.year_to
    AND range.fuel_type IS NOT DISTINCT FROM version.fuel_type
    AND range.hybrid_type IS NOT DISTINCT FROM version.hybrid_type
    AND (
      version.power_cv IS NULL
      OR abs(range.display_power_cv - version.power_cv) <= 5
    )
  ORDER BY
    CASE
      WHEN version.power_cv IS NULL THEN 0
      ELSE abs(range.display_power_cv - version.power_cv)
    END,
    range.minimum_tvv_coverage DESC,
    range.range_id
  LIMIT 1
) AS range_evidence ON true
LEFT JOIN LATERAL (
  SELECT array_agg(
    DISTINCT catalog.display_year
    ORDER BY catalog.display_year
  ) AS observed_years
  FROM mvp.site_vehicle_catalog_publishable_v1 AS catalog
  WHERE catalog.model_catalog_id = version.source_model_catalog_id
    AND catalog.fuel_type IS NOT DISTINCT FROM version.fuel_type
    AND COALESCE(catalog.hybrid_type, 'none')
      IS NOT DISTINCT FROM version.hybrid_type
    AND (
      version.power_kw IS NULL
      OR catalog.power_kw IS NULL
      OR round(catalog.power_kw)::integer = round(version.power_kw)::integer
    )
    AND catalog.display_year BETWEEN version.year_from AND version.year_to
) AS technical_evidence ON true;

CREATE TEMP TABLE audit_year_classified_v1
ON COMMIT DROP
AS
SELECT
  evidence.*,
  support_stats.support_first_year,
  support_stats.support_last_year,
  support_stats.support_year_count,
  support_stats.maximum_observed_gap,
  concat_ws(
    ', ',
    CASE
      WHEN year_from IS NULL OR year_to IS NULL OR display_year IS NULL
        THEN 'missing_year_fields'
    END,
    CASE
      WHEN year_from IS NOT NULL AND year_to IS NOT NULL
        AND year_from > year_to
        THEN 'inverted_interval'
    END,
    CASE
      WHEN display_year IS NOT NULL
        AND year_from IS NOT NULL
        AND year_to IS NOT NULL
        AND display_year NOT BETWEEN year_from AND year_to
        THEN 'display_year_outside_interval'
    END,
    CASE
      WHEN year_to > extract(year FROM current_date)::integer
        THEN 'future_year'
    END,
    CASE
      WHEN year_from < 1900
        THEN 'year_before_supported_range'
    END,
    CASE
      WHEN label_year_from IS NULL OR label_year_to IS NULL
        THEN 'label_without_parseable_year'
      WHEN label_year_from IS DISTINCT FROM year_from
        OR label_year_to IS DISTINCT FROM year_to
        THEN 'label_year_mismatch'
    END,
    CASE
      WHEN year_source = 'eea_type_variant_continuity'
        AND matched_range_id IS NULL
        AND NOT (
          hybrid_type = 'plug_in_hybrid'
          AND power_data_status = 'verified'
        )
        THEN 'tvv_range_without_matching_source'
    END,
    -- Un intervallo TVV e gia sostenuto dalla continuita di omologazione.
    -- L'assenza di immatricolazioni in uno degli anni di confine non prova
    -- che la versione fosse impossibile e non deve diventare un falso errore.
    CASE
      WHEN year_source NOT IN (
          'curated_commercial_catalog',
          'original_database'
        )
        AND NOT (
          hybrid_type = 'plug_in_hybrid'
          AND power_data_status = 'verified'
        )
        AND year_to > year_from
        AND COALESCE(support_year_count, 0) = 0
        THEN 'interval_without_year_evidence'
    END,
    CASE
      WHEN year_source NOT IN (
          'curated_commercial_catalog',
          'original_database'
        )
        AND COALESCE(maximum_observed_gap, 1) > 3
        THEN 'continuity_gap_over_three_years'
    END,
    CASE
      WHEN year_source NOT IN (
          'curated_commercial_catalog',
          'original_database',
          'eea_type_variant_continuity'
        )
        AND NOT (
          hybrid_type = 'plug_in_hybrid'
          AND power_data_status = 'verified'
        )
        AND year_to - year_from + 1 >= 8
        AND COALESCE(year_confidence, 'low')
          IN ('medium', 'medium_low', 'low')
        THEN 'long_interval_with_weak_source'
    END
    -- Non segnala come errore un anno precedente alla prima osservazione EEA.
    -- Verifiche su fonti ufficiali hanno confermato, tra gli altri: Stelvio
    -- 2016, Tipo 2015, Ghibli 2013, Levante 2016 e Taycan gia dal 2019.
  ) AS anomaly_codes
FROM audit_year_evidence_v1 AS evidence
LEFT JOIN LATERAL (
  SELECT
    min(ordered.observed_year)::integer AS support_first_year,
    max(ordered.observed_year)::integer AS support_last_year,
    count(DISTINCT ordered.observed_year)::integer AS support_year_count,
    max(ordered.observed_year - ordered.previous_year)::integer
      AS maximum_observed_gap
  FROM (
    SELECT
      observed_year,
      lag(observed_year) OVER (ORDER BY observed_year) AS previous_year
    FROM unnest(
      COALESCE(evidence.supporting_years, ARRAY[]::integer[])
    ) AS years(observed_year)
  ) AS ordered
) AS support_stats ON true;

CREATE TEMP VIEW audit_year_prioritized_v1 AS
SELECT
  classified.*,
  CASE
    WHEN anomaly_codes ~ (
      'missing_year_fields|inverted_interval|display_year_outside_interval'
      || '|future_year|year_before_supported_range|label_year_mismatch'
      || '|label_without_parseable_year|tvv_range_without_matching_source'
    ) THEN 'errore_certo'
    WHEN anomaly_codes ~ (
      'interval_without_year_evidence|continuity_gap_over_three_years'
    ) THEN 'alta'
    WHEN anomaly_codes LIKE '%long_interval_with_weak_source%'
      THEN 'media'
    ELSE 'nessuna'
  END AS priority
FROM audit_year_classified_v1 AS classified;

-- 1. Quadro generale.
SELECT
  count(*)::integer AS versioni_pubblicate,
  count(*) FILTER (WHERE priority = 'errore_certo')::integer
    AS errori_certi,
  count(*) FILTER (WHERE priority = 'alta')::integer
    AS casi_alta_priorita,
  count(*) FILTER (WHERE priority = 'media')::integer
    AS casi_da_verificare,
  count(*) FILTER (WHERE priority = 'nessuna')::integer
    AS anni_senza_anomalie,
  count(*) FILTER (
    WHERE year_source = 'curated_commercial_catalog'
  )::integer AS versioni_curate,
  count(*) FILTER (
    WHERE year_source = 'eea_type_variant_continuity'
  )::integer AS intervalli_tvv,
  CASE
    WHEN count(*) > 0 THEN 'audit_completato'
    ELSE 'errore'
  END AS verifica
FROM audit_year_prioritized_v1;

-- 2. Ripartizione per origine: chiarisce dove nascono gli anni sospetti.
SELECT
  COALESCE(year_source, '(mancante)') AS origine_anno,
  COALESCE(year_confidence, '(mancante)') AS affidabilita,
  count(*)::integer AS versioni,
  count(*) FILTER (WHERE priority = 'errore_certo')::integer
    AS errori_certi,
  count(*) FILTER (WHERE priority = 'alta')::integer
    AS alta_priorita,
  count(*) FILTER (WHERE priority = 'media')::integer
    AS da_verificare
FROM audit_year_prioritized_v1
GROUP BY year_source, year_confidence
ORDER BY errori_certi DESC, alta_priorita DESC, da_verificare DESC, versioni DESC;

-- 3. Errori certi: questi possono essere corretti senza interpretazione.
SELECT
  brand,
  model,
  version_label,
  year_from,
  year_to,
  year_source,
  evidence_kind,
  supporting_years,
  anomaly_codes
FROM audit_year_prioritized_v1
WHERE priority = 'errore_certo'
ORDER BY brand, model, year_from, version_label
LIMIT 100;

-- 4. Casi ad alta priorita: prima di correggerli, vanno confrontati con
-- una fonte commerciale pubblica del costruttore o equivalente.
SELECT
  brand,
  model,
  version_label,
  year_source,
  year_confidence,
  evidence_kind,
  supporting_years,
  maximum_observed_gap,
  model_first_eea_year,
  model_last_eea_year,
  anomaly_codes
FROM audit_year_prioritized_v1
WHERE priority = 'alta'
ORDER BY
  COALESCE(maximum_observed_gap, 0) DESC,
  year_to - year_from DESC,
  brand,
  model,
  year_from
LIMIT 120;

-- 5. Modelli sui quali concentrare la verifica online successiva.
SELECT
  brand,
  model,
  count(*) FILTER (WHERE priority = 'errore_certo')::integer
    AS errori_certi,
  count(*) FILTER (WHERE priority = 'alta')::integer
    AS alta_priorita,
  count(*) FILTER (WHERE priority = 'media')::integer
    AS intervalli_lunghi_deboli,
  min(year_from)::integer AS primo_anno_mostrato,
  max(year_to)::integer AS ultimo_anno_mostrato
FROM audit_year_prioritized_v1
WHERE priority <> 'nessuna'
GROUP BY brand, model
ORDER BY
  errori_certi DESC,
  alta_priorita DESC,
  intervalli_lunghi_deboli DESC,
  brand,
  model
LIMIT 80;

ROLLBACK;
