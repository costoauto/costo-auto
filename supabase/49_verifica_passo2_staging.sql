\pset pager off

BEGIN;
SET LOCAL statement_timeout = '5min';

CREATE TEMP TABLE _passo2_current_public_v1 AS
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
SELECT count(*)::integer AS public_versions
FROM version_item;

CREATE TEMP TABLE _passo2_verification_v1 AS
WITH latest_run AS (
  SELECT *
  FROM mvp.eea_pipeline_runs_v2
  ORDER BY loaded_at DESC
  LIMIT 1
)
SELECT
  run.run_id,
  run.commercial_observations AS expected_observations,
  (
    SELECT count(*)::integer
    FROM mvp.eea_commercial_observations_v2 AS item
    WHERE item.run_id = run.run_id
  ) AS actual_observations,
  run.selected_versions AS expected_candidates,
  (
    SELECT count(*)::integer
    FROM mvp.eea_historical_version_candidates_v2 AS item
    WHERE item.run_id = run.run_id
  ) AS actual_candidates,
  run.publishable_versions AS expected_publishable,
  (
    SELECT count(*)::integer
    FROM mvp.eea_historical_version_candidates_v2 AS item
    WHERE item.run_id = run.run_id
      AND item.publication_status = 'publishable'
  ) AS actual_publishable,
  run.candidate_versions AS expected_quarantined,
  (
    SELECT count(*)::integer
    FROM mvp.eea_historical_version_candidates_v2 AS item
    WHERE item.run_id = run.run_id
      AND item.publication_status = 'candidate'
  ) AS actual_quarantined,
  run.confirmed_ranges AS expected_ranges,
  (
    SELECT count(*)::integer
    FROM mvp.eea_display_ranges_v2 AS item
    WHERE item.run_id = run.run_id
  ) AS actual_ranges,
  run.reconciled_online_versions AS expected_public_versions,
  (SELECT public_versions FROM _passo2_current_public_v1)
    AS actual_public_versions,
  (
    SELECT count(*)::integer
    FROM mvp.eea_historical_version_candidates_v2 AS item
    WHERE item.run_id = run.run_id
      AND (
        item.source_status <> 'F'
        OR (item.publication_status = 'publishable' AND item.confidence = 'low')
        OR (
          item.publication_status = 'candidate'
          AND jsonb_array_length(item.quarantine_reasons) = 0
        )
      )
  ) AS invalid_candidates,
  NOT has_table_privilege(
    'anon',
    'mvp.eea_pipeline_runs_v2',
    'SELECT'
  ) AS staging_private
FROM latest_run AS run;

DO $verification$
DECLARE
  v record;
BEGIN
  SELECT * INTO STRICT v FROM _passo2_verification_v1;
  IF v.expected_observations <> v.actual_observations
     OR v.expected_candidates <> v.actual_candidates
     OR v.expected_publishable <> v.actual_publishable
     OR v.expected_quarantined <> v.actual_quarantined
     OR v.expected_ranges <> v.actual_ranges
     OR v.expected_public_versions <> v.actual_public_versions
     OR v.invalid_candidates <> 0
     OR NOT v.staging_private
  THEN
    RAISE EXCEPTION 'Verifica correttiva Passo 2 fallita: %', row_to_json(v);
  END IF;
END
$verification$;

SELECT
  run_id,
  actual_observations AS osservazioni_commerciali,
  actual_candidates AS identita_candidate,
  actual_publishable AS candidati_pubblicabili,
  actual_quarantined AS candidati_in_quarantena,
  actual_ranges AS intervalli_tvv_confermati,
  actual_public_versions AS versioni_pubbliche_effettive,
  invalid_candidates AS candidati_invalidi,
  staging_private AS staging_privato,
  'ok'::text AS verifica
FROM _passo2_verification_v1;

ROLLBACK;
