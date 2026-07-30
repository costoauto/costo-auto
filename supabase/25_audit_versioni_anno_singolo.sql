-- Auto TCO - audit diagnostico delle versioni non recenti mostrate con un
-- solo anno.
--
-- Questo script:
--   * legge esattamente i modelli e le versioni esposti dalla API pubblica;
--   * non modifica il catalogo, i profili, i calcoli o il sito;
--   * confronta ogni anno singolo con l'anno immediatamente precedente e
--     successivo dello stesso modello;
--   * segnala i casi probabilmente accorpabili e quelli da verificare con una
--     fonte commerciale esterna.
--
-- Per "non recente" si intende un anno precedente di almeno due anni
-- all'anno corrente. Nel 2026, quindi, il limite e' il 2024.

\set ON_ERROR_STOP on
\pset pager off

BEGIN;

SET LOCAL statement_timeout = '15min';

CREATE TEMP TABLE audit_models
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

CREATE INDEX audit_models_public_idx
  ON audit_models (public_model_id);

CREATE INDEX audit_models_source_idx
  ON audit_models (source_model_catalog_id);

CREATE TEMP TABLE audit_visible_versions
ON COMMIT DROP
AS
SELECT
  row_number() OVER (
    ORDER BY
      model.brand,
      model.model,
      (item ->> 'year_from')::integer,
      item ->> 'vehicle_cluster_id'
  )::bigint AS audit_id,
  model.public_model_id,
  model.source_model_catalog_id,
  model.brand,
  model.model,
  item ->> 'vehicle_cluster_id' AS vehicle_cluster_id,
  NULLIF(item ->> 'vehicle_profile_id', '')::integer
    AS vehicle_profile_id,
  item ->> 'version_label' AS version_label,
  (item ->> 'year_from')::integer AS year_from,
  (item ->> 'year_to')::integer AS year_to,
  item ->> 'year_source' AS year_source,
  item ->> 'year_confidence' AS year_confidence,
  item ->> 'fuel_type' AS fuel_type,
  COALESCE(item ->> 'hybrid_type', 'none') AS hybrid_type,
  item ->> 'powertrain_type' AS powertrain_type,
  NULLIF(item ->> 'power_kw', '')::numeric AS power_kw,
  NULLIF(item ->> 'power_cv', '')::numeric AS power_cv,
  item ->> 'transmission_label' AS transmission_label,
  item ->> 'commercial_name' AS commercial_name,
  item ->> 'data_source' AS data_source,
  item ->> 'data_source_url' AS data_source_url,
  NULLIF(item ->> 'registrations_in_range', '')::bigint
    AS registrations_in_range,
  CASE
    WHEN item ->> 'year_source' = 'curated_commercial_catalog'
      THEN 'curated'
    ELSE 'automatic'
  END AS catalog_kind
FROM audit_models AS model
CROSS JOIN LATERAL jsonb_array_elements(
  public.auto_tco_versions(model.public_model_id) -> 'items'
) AS item;

CREATE INDEX audit_visible_versions_model_year_idx
  ON audit_visible_versions (source_model_catalog_id, year_from, year_to);

CREATE TEMP TABLE audit_yearly_evidence
ON COMMIT DROP
AS
SELECT
  catalog.model_catalog_id,
  catalog.vehicle_cluster_id,
  catalog.display_year,
  catalog.source_kind,
  catalog.year_source,
  catalog.year_confidence,
  catalog.fuel_type,
  COALESCE(catalog.hybrid_type, 'none') AS hybrid_type,
  catalog.powertrain_type,
  catalog.power_kw,
  catalog.power_cv,
  COALESCE(
    inputs.thermal_consumption_per_100km,
    CASE
      WHEN COALESCE(catalog.hybrid_type, 'none') = 'plug_in_hybrid'
        THEN COALESCE(
          profile.phev_thermal_consumption_l_100km,
          profile.consumption_l_100km
        )
      ELSE profile.consumption_l_100km
    END
  ) AS thermal_consumption_per_100km,
  COALESCE(
    inputs.electric_consumption_kwh_100km,
    profile.electric_consumption_kwh_100km
  ) AS electric_consumption_kwh_100km,
  catalog.registrations_count
FROM mvp.site_vehicle_catalog_publishable_v1 AS catalog
LEFT JOIN mvp.vehicle_cluster_energy_inputs_v1 AS inputs
  ON inputs.vehicle_cluster_id = catalog.vehicle_cluster_id
LEFT JOIN mvp.vehicle_profiles AS profile
  ON profile.id = catalog.vehicle_profile_id
WHERE catalog.display_year BETWEEN 1900 AND 2100;

CREATE INDEX audit_yearly_evidence_lookup_idx
  ON audit_yearly_evidence (
    model_catalog_id,
    display_year,
    fuel_type,
    hybrid_type,
    powertrain_type
  );

CREATE TEMP TABLE audit_single_year_candidates
ON COMMIT DROP
AS
SELECT
  version.*,
  COALESCE(
    inputs.thermal_consumption_per_100km,
    CASE
      WHEN version.hybrid_type = 'plug_in_hybrid'
        THEN COALESCE(
          profile.phev_thermal_consumption_l_100km,
          profile.consumption_l_100km
        )
      ELSE profile.consumption_l_100km
    END
  ) AS thermal_consumption_per_100km,
  COALESCE(
    inputs.electric_consumption_kwh_100km,
    profile.electric_consumption_kwh_100km
  ) AS electric_consumption_kwh_100km
FROM audit_visible_versions AS version
LEFT JOIN mvp.vehicle_cluster_energy_inputs_v1 AS inputs
  ON inputs.vehicle_cluster_id = version.vehicle_cluster_id
LEFT JOIN mvp.vehicle_profiles AS profile
  ON profile.id = version.vehicle_profile_id
WHERE version.year_from = version.year_to
  AND version.year_from <= extract(year FROM current_date)::integer - 2;

CREATE INDEX audit_single_year_candidates_id_idx
  ON audit_single_year_candidates (audit_id);

CREATE TEMP TABLE audit_single_year_evaluated
ON COMMIT DROP
AS
WITH neighbor_values AS (
  SELECT
    candidate.*,
    previous.display_year AS previous_year,
    previous.vehicle_cluster_id AS previous_vehicle_cluster_id,
    previous.power_kw AS previous_power_kw,
    previous.power_cv AS previous_power_cv,
    previous.thermal_consumption_per_100km
      AS previous_thermal_consumption,
    previous.electric_consumption_kwh_100km
      AS previous_electric_consumption,
    previous.registrations_count AS previous_registrations,
    following.display_year AS following_year,
    following.vehicle_cluster_id AS following_vehicle_cluster_id,
    following.power_kw AS following_power_kw,
    following.power_cv AS following_power_cv,
    following.thermal_consumption_per_100km
      AS following_thermal_consumption,
    following.electric_consumption_kwh_100km
      AS following_electric_consumption,
    following.registrations_count AS following_registrations
  FROM audit_single_year_candidates AS candidate
  LEFT JOIN LATERAL (
    SELECT evidence.*
    FROM audit_yearly_evidence AS evidence
    WHERE evidence.model_catalog_id = candidate.source_model_catalog_id
      AND evidence.display_year = candidate.year_from - 1
      AND evidence.fuel_type IS NOT DISTINCT FROM candidate.fuel_type
      AND evidence.hybrid_type IS NOT DISTINCT FROM candidate.hybrid_type
      AND evidence.powertrain_type
        IS NOT DISTINCT FROM candidate.powertrain_type
    ORDER BY
      CASE
        WHEN candidate.power_cv IS NOT NULL
          AND evidence.power_cv IS NOT NULL
          THEN abs(candidate.power_cv - evidence.power_cv)
        WHEN candidate.power_kw IS NOT NULL
          AND evidence.power_kw IS NOT NULL
          THEN abs(candidate.power_kw - evidence.power_kw) * 1.36
        ELSE 999999
      END,
      CASE
        WHEN candidate.thermal_consumption_per_100km IS NOT NULL
          AND evidence.thermal_consumption_per_100km IS NOT NULL
          THEN abs(
            candidate.thermal_consumption_per_100km
            - evidence.thermal_consumption_per_100km
          )
        WHEN candidate.electric_consumption_kwh_100km IS NOT NULL
          AND evidence.electric_consumption_kwh_100km IS NOT NULL
          THEN abs(
            candidate.electric_consumption_kwh_100km
            - evidence.electric_consumption_kwh_100km
          )
        ELSE 999999
      END,
      evidence.registrations_count DESC,
      evidence.vehicle_cluster_id
    LIMIT 1
  ) AS previous ON true
  LEFT JOIN LATERAL (
    SELECT evidence.*
    FROM audit_yearly_evidence AS evidence
    WHERE evidence.model_catalog_id = candidate.source_model_catalog_id
      AND evidence.display_year = candidate.year_from + 1
      AND evidence.fuel_type IS NOT DISTINCT FROM candidate.fuel_type
      AND evidence.hybrid_type IS NOT DISTINCT FROM candidate.hybrid_type
      AND evidence.powertrain_type
        IS NOT DISTINCT FROM candidate.powertrain_type
    ORDER BY
      CASE
        WHEN candidate.power_cv IS NOT NULL
          AND evidence.power_cv IS NOT NULL
          THEN abs(candidate.power_cv - evidence.power_cv)
        WHEN candidate.power_kw IS NOT NULL
          AND evidence.power_kw IS NOT NULL
          THEN abs(candidate.power_kw - evidence.power_kw) * 1.36
        ELSE 999999
      END,
      CASE
        WHEN candidate.thermal_consumption_per_100km IS NOT NULL
          AND evidence.thermal_consumption_per_100km IS NOT NULL
          THEN abs(
            candidate.thermal_consumption_per_100km
            - evidence.thermal_consumption_per_100km
          )
        WHEN candidate.electric_consumption_kwh_100km IS NOT NULL
          AND evidence.electric_consumption_kwh_100km IS NOT NULL
          THEN abs(
            candidate.electric_consumption_kwh_100km
            - evidence.electric_consumption_kwh_100km
          )
        ELSE 999999
      END,
      evidence.registrations_count DESC,
      evidence.vehicle_cluster_id
    LIMIT 1
  ) AS following ON true
), compatibility AS (
  SELECT
    neighbor_values.*,
    (
      previous_year IS NOT NULL
      AND (
        (
          power_cv IS NOT NULL
          AND previous_power_cv IS NOT NULL
          AND abs(power_cv - previous_power_cv) <= 3
        )
        OR (
          power_kw IS NOT NULL
          AND previous_power_kw IS NOT NULL
          AND abs(power_kw - previous_power_kw) <= 2.5
        )
      )
    ) AS previous_power_compatible,
    (
      following_year IS NOT NULL
      AND (
        (
          power_cv IS NOT NULL
          AND following_power_cv IS NOT NULL
          AND abs(power_cv - following_power_cv) <= 3
        )
        OR (
          power_kw IS NOT NULL
          AND following_power_kw IS NOT NULL
          AND abs(power_kw - following_power_kw) <= 2.5
        )
      )
    ) AS following_power_compatible,
    CASE
      WHEN powertrain_type = 'electric' OR fuel_type = 'electric' THEN
        electric_consumption_kwh_100km IS NOT NULL
        AND previous_electric_consumption IS NOT NULL
        AND abs(
          electric_consumption_kwh_100km
          - previous_electric_consumption
        ) <= greatest(1.5, electric_consumption_kwh_100km * 0.08)
      WHEN powertrain_type = 'plug_in_hybrid' THEN
        thermal_consumption_per_100km IS NOT NULL
        AND previous_thermal_consumption IS NOT NULL
        AND electric_consumption_kwh_100km IS NOT NULL
        AND previous_electric_consumption IS NOT NULL
        AND abs(
          thermal_consumption_per_100km - previous_thermal_consumption
        ) <= greatest(0.35, thermal_consumption_per_100km * 0.08)
        AND abs(
          electric_consumption_kwh_100km
          - previous_electric_consumption
        ) <= greatest(1.5, electric_consumption_kwh_100km * 0.08)
      ELSE
        thermal_consumption_per_100km IS NOT NULL
        AND previous_thermal_consumption IS NOT NULL
        AND abs(
          thermal_consumption_per_100km - previous_thermal_consumption
        ) <= greatest(0.35, thermal_consumption_per_100km * 0.08)
    END AS previous_energy_compatible,
    CASE
      WHEN powertrain_type = 'electric' OR fuel_type = 'electric' THEN
        electric_consumption_kwh_100km IS NOT NULL
        AND following_electric_consumption IS NOT NULL
        AND abs(
          electric_consumption_kwh_100km
          - following_electric_consumption
        ) <= greatest(1.5, electric_consumption_kwh_100km * 0.08)
      WHEN powertrain_type = 'plug_in_hybrid' THEN
        thermal_consumption_per_100km IS NOT NULL
        AND following_thermal_consumption IS NOT NULL
        AND electric_consumption_kwh_100km IS NOT NULL
        AND following_electric_consumption IS NOT NULL
        AND abs(
          thermal_consumption_per_100km - following_thermal_consumption
        ) <= greatest(0.35, thermal_consumption_per_100km * 0.08)
        AND abs(
          electric_consumption_kwh_100km
          - following_electric_consumption
        ) <= greatest(1.5, electric_consumption_kwh_100km * 0.08)
      ELSE
        thermal_consumption_per_100km IS NOT NULL
        AND following_thermal_consumption IS NOT NULL
        AND abs(
          thermal_consumption_per_100km - following_thermal_consumption
        ) <= greatest(0.35, thermal_consumption_per_100km * 0.08)
    END AS following_energy_compatible
  FROM neighbor_values
), classified AS (
  SELECT
    compatibility.*,
    (
      COALESCE(previous_power_compatible, false)
      AND COALESCE(previous_energy_compatible, false)
    ) AS previous_compatible,
    (
      COALESCE(following_power_compatible, false)
      AND COALESCE(following_energy_compatible, false)
    ) AS following_compatible
  FROM compatibility
)
SELECT
  classified.*,
  CASE
    WHEN catalog_kind = 'curated' THEN
      'curata: controllare la fonte, non accorpare automaticamente'
    WHEN previous_compatible AND following_compatible THEN
      'probabile accorpamento su entrambi i lati'
    WHEN previous_compatible OR following_compatible THEN
      'probabile estensione verso un anno adiacente'
    WHEN previous_year IS NOT NULL OR following_year IS NOT NULL THEN
      'anno singolo con differenza tecnica o di consumo'
    ELSE
      'anno isolato nel dataset: serve una fonte commerciale'
  END AS audit_class,
  CASE
    WHEN catalog_kind = 'curated' THEN 'bassa'
    WHEN previous_compatible AND following_compatible THEN 'alta'
    WHEN previous_compatible OR following_compatible THEN 'alta'
    WHEN previous_year IS NOT NULL OR following_year IS NOT NULL THEN 'media'
    ELSE 'media'
  END AS review_priority,
  CASE
    WHEN catalog_kind = 'curated' THEN NULL
    WHEN previous_compatible
      THEN previous_year
    ELSE year_from
  END AS proposed_year_from,
  CASE
    WHEN catalog_kind = 'curated' THEN NULL
    WHEN following_compatible
      THEN following_year
    ELSE year_to
  END AS proposed_year_to
FROM classified;

-- 1. Quadro generale.
SELECT
  extract(year FROM current_date)::integer - 2 AS anno_limite_non_recente,
  (SELECT count(*) FROM audit_models) AS modelli_pubblicati,
  (SELECT count(*) FROM audit_visible_versions) AS versioni_pubblicate,
  (SELECT count(*) FROM audit_single_year_evaluated)
    AS versioni_non_recenti_con_un_solo_anno,
  count(*) FILTER (
    WHERE catalog_kind = 'curated'
  ) AS gia_curate,
  count(*) FILTER (
    WHERE catalog_kind = 'automatic'
      AND previous_compatible
      AND following_compatible
  ) AS probabili_accorpamenti_due_lati,
  count(*) FILTER (
    WHERE catalog_kind = 'automatic'
      AND (previous_compatible OR following_compatible)
      AND NOT (previous_compatible AND following_compatible)
  ) AS probabili_estensioni_un_lato,
  count(*) FILTER (
    WHERE catalog_kind = 'automatic'
      AND NOT previous_compatible
      AND NOT following_compatible
      AND (previous_year IS NOT NULL OR following_year IS NOT NULL)
  ) AS differenze_tecniche_da_verificare,
  count(*) FILTER (
    WHERE catalog_kind = 'automatic'
      AND previous_year IS NULL
      AND following_year IS NULL
  ) AS isolati_da_verificare_con_fonti,
  CASE
    WHEN count(*) FILTER (
      WHERE year_from <> year_to
         OR year_from > extract(year FROM current_date)::integer - 2
    ) = 0 THEN 'ok'
    ELSE 'errore'
  END AS verifica
FROM audit_single_year_evaluated;

-- 2. Modelli sui quali conviene lavorare prima: molti anni singoli e molti
-- candidati compatibili con almeno un anno adiacente.
SELECT
  brand,
  model,
  count(*) AS anni_singoli_non_recenti,
  count(*) FILTER (
    WHERE catalog_kind = 'automatic'
      AND (previous_compatible OR following_compatible)
  ) AS probabili_accorpamenti,
  count(*) FILTER (
    WHERE catalog_kind = 'automatic'
      AND NOT previous_compatible
      AND NOT following_compatible
  ) AS da_verificare_con_fonti,
  sum(COALESCE(registrations_in_range, 0)) AS peso_dataset
FROM audit_single_year_evaluated
GROUP BY brand, model
ORDER BY
  count(*) FILTER (
    WHERE catalog_kind = 'automatic'
      AND (previous_compatible OR following_compatible)
  ) DESC,
  count(*) DESC,
  sum(COALESCE(registrations_in_range, 0)) DESC,
  brand,
  model
LIMIT 30;

-- 3. Dettaglio operativo dei primi casi. L'intervallo proposto e' soltanto
-- diagnostico: prima di applicarlo va confermato con una fonte pubblica.
SELECT
  brand,
  model,
  version_label,
  catalog_kind,
  fuel_type,
  hybrid_type,
  round(power_cv)::integer AS cv,
  transmission_label AS cambio,
  round(thermal_consumption_per_100km, 2) AS consumo_termico_100km,
  round(electric_consumption_kwh_100km, 2) AS consumo_elettrico_100km,
  previous_year AS anno_precedente_trovato,
  round(previous_power_cv)::integer AS cv_precedente,
  round(previous_thermal_consumption, 2) AS consumo_precedente,
  following_year AS anno_successivo_trovato,
  round(following_power_cv)::integer AS cv_successivo,
  round(following_thermal_consumption, 2) AS consumo_successivo,
  proposed_year_from AS intervallo_proposto_da,
  proposed_year_to AS intervallo_proposto_a,
  audit_class AS esito_audit,
  review_priority AS priorita,
  registrations_in_range AS peso_dataset
FROM audit_single_year_evaluated
ORDER BY
  CASE review_priority WHEN 'alta' THEN 0 WHEN 'media' THEN 1 ELSE 2 END,
  COALESCE(registrations_in_range, 0) DESC,
  brand,
  model,
  year_from
LIMIT 80;

ROLLBACK;
