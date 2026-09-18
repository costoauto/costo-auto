\pset pager off

BEGIN;

SET LOCAL statement_timeout = '15min';
SET LOCAL lock_timeout = '15s';

CREATE TEMP TABLE _passo2_public_guard_v1 AS
WITH brand_item AS (
  SELECT brand.item
  FROM jsonb_array_elements(
    public.auto_tco_brands() -> 'items'
  ) AS brand(item)
), model_item AS (
  SELECT DISTINCT model.item ->> 'model_catalog_id' AS model_catalog_id
  FROM brand_item AS brand
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_models(brand.item ->> 'brand_key') -> 'items'
  ) AS model(item)
), version_item AS (
  SELECT version.item
  FROM model_item AS model
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(model.model_catalog_id) -> 'items'
  ) AS version(item)
)
SELECT count(*)::integer AS public_versions_before
FROM version_item;

CREATE TABLE IF NOT EXISTS mvp.eea_pipeline_runs_v2 (
  run_id text PRIMARY KEY,
  pipeline_version text NOT NULL,
  generated_at timestamptz NOT NULL,
  source_year_from integer NOT NULL,
  source_year_to integer NOT NULL,
  source_files integer NOT NULL,
  source_rows integer NOT NULL,
  source_registrations bigint NOT NULL,
  mapped_registrations bigint NOT NULL,
  mapped_registrations_pct numeric(6, 2) NOT NULL,
  commercial_observations integer NOT NULL,
  selected_versions integer NOT NULL,
  publishable_versions integer NOT NULL,
  candidate_versions integer NOT NULL,
  confirmed_ranges integer NOT NULL,
  reconciled_online_versions integer NOT NULL,
  canonical_manifest_fingerprint text NOT NULL,
  normalized_manifest_fingerprint text NOT NULL,
  policy jsonb NOT NULL,
  loaded_at timestamptz NOT NULL DEFAULT now(),
  CHECK (source_year_from <= source_year_to),
  CHECK (source_files > 0),
  CHECK (source_rows > 0),
  CHECK (publishable_versions + candidate_versions = selected_versions)
);

CREATE TABLE IF NOT EXISTS mvp.eea_commercial_observations_v2 (
  run_id text NOT NULL REFERENCES mvp.eea_pipeline_runs_v2(run_id) ON DELETE CASCADE,
  observation_key text NOT NULL,
  seed_model_id integer NOT NULL,
  brand text NOT NULL,
  model text NOT NULL,
  observation_year integer NOT NULL,
  source_status text NOT NULL CHECK (source_status = 'F'),
  fuel_type text NOT NULL,
  hybrid_type text NOT NULL,
  power_kw numeric,
  direct_consumption_l_100km numeric,
  direct_electric_consumption_kwh_100km numeric,
  registrations_count bigint NOT NULL,
  source_records_count integer NOT NULL,
  model_match_methods jsonb NOT NULL,
  source_identity_samples jsonb NOT NULL,
  selected_for_catalog boolean NOT NULL,
  selection_reason text NOT NULL,
  PRIMARY KEY (run_id, observation_key)
);

CREATE TABLE IF NOT EXISTS mvp.eea_historical_version_candidates_v2 (
  run_id text NOT NULL REFERENCES mvp.eea_pipeline_runs_v2(run_id) ON DELETE CASCADE,
  historical_version_id text NOT NULL,
  observation_key text NOT NULL,
  seed_model_id integer NOT NULL,
  brand text NOT NULL,
  model text NOT NULL,
  representative_year integer NOT NULL,
  fuel_type text NOT NULL,
  hybrid_type text NOT NULL,
  power_kw numeric NOT NULL,
  power_cv numeric NOT NULL,
  direct_consumption_l_100km numeric,
  direct_electric_consumption_kwh_100km numeric,
  selected_consumption_l_100km numeric,
  selected_electric_consumption_kwh_100km numeric,
  registrations_count bigint NOT NULL,
  source_records_count integer NOT NULL,
  source_status text NOT NULL CHECK (source_status = 'F'),
  confidence text NOT NULL,
  energy_method text NOT NULL,
  model_match_methods jsonb NOT NULL,
  quarantine_reasons jsonb NOT NULL,
  publication_status text NOT NULL
    CHECK (publication_status IN ('publishable', 'candidate')),
  PRIMARY KEY (run_id, historical_version_id),
  FOREIGN KEY (run_id, observation_key)
    REFERENCES mvp.eea_commercial_observations_v2(run_id, observation_key),
  CHECK (
    publication_status <> 'candidate'
    OR jsonb_array_length(quarantine_reasons) > 0
  )
);

CREATE TABLE IF NOT EXISTS mvp.eea_display_ranges_v2 (
  run_id text NOT NULL REFERENCES mvp.eea_pipeline_runs_v2(run_id) ON DELETE CASCADE,
  range_id text NOT NULL,
  seed_model_id integer NOT NULL,
  brand text NOT NULL,
  model text NOT NULL,
  fuel_type text NOT NULL,
  hybrid_type text NOT NULL,
  year_from integer NOT NULL,
  year_to integer NOT NULL,
  observed_years jsonb NOT NULL,
  maximum_observed_gap integer NOT NULL,
  power_kw_min numeric NOT NULL,
  power_kw_max numeric NOT NULL,
  power_cv_representative numeric NOT NULL,
  thermal_consumption_min numeric,
  thermal_consumption_max numeric,
  electric_consumption_min numeric,
  electric_consumption_max numeric,
  profile_ids jsonb NOT NULL,
  minimum_tvv_coverage numeric NOT NULL,
  edge_count integer NOT NULL,
  evidence_status text NOT NULL CHECK (evidence_status = 'confirmed'),
  evidence_method text NOT NULL,
  PRIMARY KEY (run_id, range_id),
  CHECK (year_from <= year_to),
  CHECK (power_kw_min <= power_kw_max),
  CHECK (minimum_tvv_coverage >= 0 AND minimum_tvv_coverage <= 1),
  CHECK (jsonb_array_length(profile_ids) >= 2)
);

CREATE TABLE IF NOT EXISTS mvp.eea_catalog_reconciliation_v2 (
  run_id text NOT NULL REFERENCES mvp.eea_pipeline_runs_v2(run_id) ON DELETE CASCADE,
  reconciliation_id text NOT NULL,
  display_variant_id text,
  vehicle_cluster_id text,
  brand text NOT NULL,
  model text NOT NULL,
  version_label text NOT NULL,
  classification text NOT NULL,
  year_from integer,
  year_to integer,
  fuel_type text,
  hybrid_type text,
  power_kw numeric,
  power_cv numeric,
  observed_years jsonb NOT NULL,
  raw_observed_years jsonb NOT NULL,
  suggested_ranges jsonb NOT NULL,
  PRIMARY KEY (run_id, reconciliation_id),
  CHECK (year_from IS NULL OR year_to IS NULL OR year_from <= year_to)
);

CREATE INDEX IF NOT EXISTS eea_commercial_observations_v2_lookup_idx
ON mvp.eea_commercial_observations_v2
  (run_id, seed_model_id, observation_year, fuel_type, hybrid_type, power_kw);

CREATE INDEX IF NOT EXISTS eea_historical_candidates_v2_lookup_idx
ON mvp.eea_historical_version_candidates_v2
  (run_id, seed_model_id, representative_year, fuel_type, hybrid_type, power_kw);

CREATE INDEX IF NOT EXISTS eea_display_ranges_v2_lookup_idx
ON mvp.eea_display_ranges_v2
  (run_id, seed_model_id, year_from, year_to, fuel_type, hybrid_type);

CREATE INDEX IF NOT EXISTS eea_catalog_reconciliation_v2_class_idx
ON mvp.eea_catalog_reconciliation_v2 (run_id, classification, brand, model);

COMMENT ON TABLE mvp.eea_pipeline_runs_v2 IS
  'Esecuzioni riproducibili della pipeline EEA v2. Non esposta alla Data API.';
COMMENT ON TABLE mvp.eea_commercial_observations_v2 IS
  'Osservazioni commerciali aggregate da una sola edizione EEA finale per anno.';
COMMENT ON TABLE mvp.eea_historical_version_candidates_v2 IS
  'Identita candidate e stime derivate; i casi approssimativi restano in quarantena.';
COMMENT ON TABLE mvp.eea_display_ranges_v2 IS
  'Intervalli di anni sostenuti da continuita TVV ad alta affidabilita.';
COMMENT ON TABLE mvp.eea_catalog_reconciliation_v2 IS
  'Confronto tra catalogo pubblico corrente e pipeline EEA canonica v2.';

REVOKE ALL ON mvp.eea_pipeline_runs_v2
FROM PUBLIC, anon, authenticated;
REVOKE ALL ON mvp.eea_commercial_observations_v2
FROM PUBLIC, anon, authenticated;
REVOKE ALL ON mvp.eea_historical_version_candidates_v2
FROM PUBLIC, anon, authenticated;
REVOKE ALL ON mvp.eea_display_ranges_v2
FROM PUBLIC, anon, authenticated;
REVOKE ALL ON mvp.eea_catalog_reconciliation_v2
FROM PUBLIC, anon, authenticated;

-- __PASSO2_GENERATED_DATA__

ANALYZE mvp.eea_pipeline_runs_v2;
ANALYZE mvp.eea_commercial_observations_v2;
ANALYZE mvp.eea_historical_version_candidates_v2;
ANALYZE mvp.eea_display_ranges_v2;
ANALYZE mvp.eea_catalog_reconciliation_v2;

DO $verification$
DECLARE
  v_expected record;
  v_public_versions_after integer;
  v_observations integer;
  v_candidates integer;
  v_publishable integer;
  v_quarantined integer;
  v_ranges integer;
  v_reconciled integer;
  v_invalid integer;
BEGIN
  SELECT * INTO STRICT v_expected FROM _passo2_expected_v1;

  SELECT count(*) INTO v_observations
  FROM mvp.eea_commercial_observations_v2
  WHERE run_id = v_expected.run_id;

  SELECT
    count(*),
    count(*) FILTER (WHERE publication_status = 'publishable'),
    count(*) FILTER (WHERE publication_status = 'candidate')
  INTO v_candidates, v_publishable, v_quarantined
  FROM mvp.eea_historical_version_candidates_v2
  WHERE run_id = v_expected.run_id;

  SELECT count(*) INTO v_ranges
  FROM mvp.eea_display_ranges_v2
  WHERE run_id = v_expected.run_id;

  SELECT count(*) INTO v_reconciled
  FROM mvp.eea_catalog_reconciliation_v2
  WHERE run_id = v_expected.run_id;

  SELECT count(*) INTO v_invalid
  FROM mvp.eea_historical_version_candidates_v2
  WHERE run_id = v_expected.run_id
    AND (
      source_status <> 'F'
      OR (publication_status = 'publishable' AND confidence = 'low')
      OR (publication_status = 'candidate' AND jsonb_array_length(quarantine_reasons) = 0)
    );

  WITH brand_item AS (
    SELECT brand.item
    FROM jsonb_array_elements(
      public.auto_tco_brands() -> 'items'
    ) AS brand(item)
  ), model_item AS (
    SELECT DISTINCT model.item ->> 'model_catalog_id' AS model_catalog_id
    FROM brand_item AS brand
    CROSS JOIN LATERAL jsonb_array_elements(
      public.auto_tco_models(brand.item ->> 'brand_key') -> 'items'
    ) AS model(item)
  ), version_item AS (
    SELECT version.item
    FROM model_item AS model
    CROSS JOIN LATERAL jsonb_array_elements(
      public.auto_tco_versions(model.model_catalog_id) -> 'items'
    ) AS version(item)
  )
  SELECT count(*)::integer INTO v_public_versions_after
  FROM version_item;

  IF v_observations <> v_expected.observations
     OR v_candidates <> v_expected.candidates
     OR v_publishable <> v_expected.publishable
     OR v_quarantined <> v_expected.quarantined
     OR v_ranges <> v_expected.ranges
     OR v_reconciled <> v_expected.reconciled
     OR v_invalid <> 0
  THEN
    RAISE EXCEPTION
      'Verifica staging fallita: osservazioni %, candidati %, pubblicabili %, quarantena %, intervalli %, riconciliazioni %, invalidi %',
      v_observations, v_candidates, v_publishable, v_quarantined,
      v_ranges, v_reconciled, v_invalid;
  END IF;

  IF v_public_versions_after <>
     (SELECT public_versions_before FROM _passo2_public_guard_v1)
  THEN
    RAISE EXCEPTION 'Il catalogo pubblico e cambiato durante il caricamento staging';
  END IF;

  IF has_table_privilege('anon', 'mvp.eea_pipeline_runs_v2', 'SELECT')
     OR has_table_privilege('anon', 'mvp.eea_commercial_observations_v2', 'SELECT')
     OR has_table_privilege('anon', 'mvp.eea_historical_version_candidates_v2', 'SELECT')
     OR has_table_privilege('anon', 'mvp.eea_display_ranges_v2', 'SELECT')
     OR has_table_privilege('anon', 'mvp.eea_catalog_reconciliation_v2', 'SELECT')
  THEN
    RAISE EXCEPTION 'Lo staging EEA non deve essere leggibile dal ruolo anon';
  END IF;
END
$verification$;

SELECT
  e.run_id,
  e.observations AS osservazioni_commerciali,
  e.candidates AS identita_candidate,
  e.publishable AS candidati_pubblicabili,
  e.quarantined AS candidati_in_quarantena,
  e.ranges AS intervalli_tvv_confermati,
  e.reconciled AS versioni_online_riconciliate,
  (SELECT public_versions_before FROM _passo2_public_guard_v1)
    AS versioni_pubbliche_rimaste_invariate,
  NOT has_table_privilege('anon', 'mvp.eea_pipeline_runs_v2', 'SELECT')
    AS staging_privato,
  'ok'::text AS verifica
FROM _passo2_expected_v1 AS e;

COMMIT;
