\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - risolve le anomalie emerse dall'audit conclusivo.
--
-- 1. Completa i consumi termici mancanti usando la stessa gerarchia di
--    mediane tecniche gia adottata dal motore: stesso modello, stessa marca
--    e potenza, stessa alimentazione e potenza, stessa alimentazione.
-- 2. Non inventa collegamenti per versioni rimaste orfane: le rimuove dal
--    menu mediante un filtro generale sull'effettiva presenza nel catalogo
--    di calcolo.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

-- Individua i difetti attraverso lo stesso endpoint usato dal sito. La sola
-- assenza di una riga nella cache energetica non e un difetto: diversi profili
-- validi ricavano infatti il consumo direttamente dal catalogo o dal profilo.
CREATE OR REPLACE FUNCTION pg_temp.safe_auto_tco_before_repair(
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

CREATE TEMP TABLE energy_audit_before_repair_v1 AS
SELECT
  cache.*,
  pg_temp.safe_auto_tco_before_repair(
    cache.vehicle_cluster_id,
    cache.display_variant_id
  ) AS payload
FROM mvp.maintenance_display_variant_inputs_v1 AS cache;

CREATE INDEX ON energy_audit_before_repair_v1 (vehicle_cluster_id);
CREATE INDEX ON energy_audit_before_repair_v1 (
  model_catalog_id,
  fuel_type,
  hybrid_type
);
ANALYZE energy_audit_before_repair_v1;

CREATE TEMP TABLE energy_repair_targets_v1 AS
SELECT DISTINCT ON (audit.vehicle_cluster_id)
  audit.vehicle_cluster_id,
  audit.model_catalog_id,
  audit.brand,
  audit.model,
  audit.fuel_type,
  audit.hybrid_type,
  audit.displayed_power_kw AS power_kw
FROM energy_audit_before_repair_v1 AS audit
JOIN mvp.site_vehicle_catalog_unified_v1 AS catalog
  ON catalog.vehicle_cluster_id = audit.vehicle_cluster_id
WHERE NOT (audit.payload ? '_audit_error')
  AND audit.payload #>> '{monthly_costs,fuel_or_energy_eur}' IS NULL
  AND COALESCE(
    audit.payload #> '{quality,missing_required_components}',
    '[]'::jsonb
  ) @> '["fuel_or_energy"]'::jsonb
ORDER BY
  audit.vehicle_cluster_id,
  audit.year_to DESC,
  audit.display_variant_id;

DO $block$
DECLARE
  v_targets integer;
  v_published integer;
BEGIN
  SELECT count(*)::integer
  INTO v_targets
  FROM energy_repair_targets_v1;

  SELECT count(*)::integer
  INTO v_published
  FROM energy_audit_before_repair_v1;

  IF EXISTS (
    SELECT 1
    FROM energy_repair_targets_v1
    WHERE fuel_type = 'electric'
      OR hybrid_type = 'plug_in_hybrid'
  ) THEN
    RAISE EXCEPTION
      'Audit: trovata energia elettrica o plug-in mancante; serve una riparazione specifica';
  END IF;

  IF v_targets = 0 THEN
    RAISE EXCEPTION
      'Audit: nessun consumo termico realmente mancante da riparare';
  END IF;

  IF v_targets > greatest(100, ceil(v_published * 0.05)::integer) THEN
    RAISE EXCEPTION
      'Audit: selezione anomala di % versioni su %, operazione annullata',
      v_targets,
      v_published;
  END IF;
END;
$block$;

CREATE TEMP TABLE energy_repair_peers_v1 AS
SELECT DISTINCT ON (audit.vehicle_cluster_id)
  audit.vehicle_cluster_id,
  audit.model_catalog_id,
  audit.brand,
  audit.model,
  audit.fuel_type,
  audit.hybrid_type,
  audit.displayed_power_kw AS power_kw,
  COALESCE(
    CASE
      WHEN energy.input_status = 'ready'
        THEN NULLIF(energy.thermal_consumption_per_100km, 0)
      ELSE NULL
    END,
    CASE
      WHEN audit.hybrid_type = 'plug_in_hybrid'
        THEN NULLIF(profile.phev_thermal_consumption_l_100km, 0)
      ELSE NULLIF(profile.consumption_l_100km, 0)
    END,
    NULLIF(
      audit.payload #>>
        '{calculation_details,fuel_or_energy,thermal_consumption_per_100km}',
      ''
    )::numeric
  ) AS consumption
FROM energy_audit_before_repair_v1 AS audit
JOIN mvp.site_vehicle_catalog_unified_v1 AS catalog
  ON catalog.vehicle_cluster_id = audit.vehicle_cluster_id
LEFT JOIN mvp.vehicle_profiles AS profile
  ON profile.id = catalog.vehicle_profile_id
 AND profile.profile_status = 'active'
LEFT JOIN mvp.vehicle_cluster_energy_inputs_v1 AS energy
  ON energy.vehicle_cluster_id = audit.vehicle_cluster_id
WHERE NOT (audit.payload ? '_audit_error')
  AND audit.payload #>> '{quality,status}' = 'ready'
  AND COALESCE(
    CASE
      WHEN energy.input_status = 'ready'
        THEN NULLIF(energy.thermal_consumption_per_100km, 0)
      ELSE NULL
    END,
    CASE
      WHEN audit.hybrid_type = 'plug_in_hybrid'
        THEN NULLIF(profile.phev_thermal_consumption_l_100km, 0)
      ELSE NULLIF(profile.consumption_l_100km, 0)
    END,
    NULLIF(
      audit.payload #>>
        '{calculation_details,fuel_or_energy,thermal_consumption_per_100km}',
      ''
    )::numeric
  ) > 0
ORDER BY
  audit.vehicle_cluster_id,
  CASE energy.confidence
    WHEN 'high' THEN 1
    WHEN 'medium' THEN 2
    WHEN 'medium_low' THEN 3
    WHEN 'low' THEN 4
    ELSE 5
  END,
  audit.year_to DESC;

CREATE INDEX ON energy_repair_peers_v1 (
  model_catalog_id,
  fuel_type,
  hybrid_type
);
CREATE INDEX ON energy_repair_peers_v1 (
  brand,
  fuel_type,
  hybrid_type,
  power_kw
);
ANALYZE energy_repair_targets_v1;
ANALYZE energy_repair_peers_v1;

CREATE TEMP TABLE energy_repair_plan_v1 AS
SELECT
  target.*,
  round(
    COALESCE(
      same_model.value,
      same_brand_power.value,
      same_fuel_power.value,
      same_fuel.value
    ),
    3
  ) AS resolved_consumption,
  CASE
    WHEN same_model.value IS NOT NULL
      THEN 'same_model_median_audit_repair_v1'
    WHEN same_brand_power.value IS NOT NULL
      THEN 'same_brand_power_median_audit_repair_v1'
    WHEN same_fuel_power.value IS NOT NULL
      THEN 'same_fuel_power_median_audit_repair_v1'
    WHEN same_fuel.value IS NOT NULL
      THEN 'same_fuel_median_audit_repair_v1'
    ELSE NULL
  END AS resolution_method,
  CASE
    WHEN same_model.value IS NOT NULL THEN same_model.reference_count
    WHEN same_brand_power.value IS NOT NULL
      THEN same_brand_power.reference_count
    WHEN same_fuel_power.value IS NOT NULL
      THEN same_fuel_power.reference_count
    WHEN same_fuel.value IS NOT NULL THEN same_fuel.reference_count
    ELSE 0
  END AS reference_count,
  CASE
    WHEN same_model.value IS NOT NULL THEN 'medium'
    WHEN same_brand_power.value IS NOT NULL THEN 'medium_low'
    WHEN same_fuel_power.value IS NOT NULL THEN 'low'
    WHEN same_fuel.value IS NOT NULL THEN 'low'
    ELSE 'missing'
  END AS resolved_confidence
FROM energy_repair_targets_v1 AS target
LEFT JOIN LATERAL (
  SELECT
    percentile_cont(0.5)
      WITHIN GROUP (ORDER BY peer.consumption)::numeric AS value,
    count(*)::integer AS reference_count
  FROM energy_repair_peers_v1 AS peer
  WHERE peer.vehicle_cluster_id <> target.vehicle_cluster_id
    AND peer.model_catalog_id = target.model_catalog_id
    AND peer.fuel_type = target.fuel_type
    AND peer.hybrid_type = target.hybrid_type
) AS same_model ON true
LEFT JOIN LATERAL (
  SELECT
    percentile_cont(0.5)
      WITHIN GROUP (ORDER BY peer.consumption)::numeric AS value,
    count(*)::integer AS reference_count
  FROM energy_repair_peers_v1 AS peer
  WHERE peer.vehicle_cluster_id <> target.vehicle_cluster_id
    AND peer.brand = target.brand
    AND peer.fuel_type = target.fuel_type
    AND peer.hybrid_type = target.hybrid_type
    AND peer.power_kw IS NOT NULL
    AND target.power_kw IS NOT NULL
    AND abs(peer.power_kw - target.power_kw)
      <= greatest(10, target.power_kw * 0.20)
) AS same_brand_power ON true
LEFT JOIN LATERAL (
  SELECT
    percentile_cont(0.5)
      WITHIN GROUP (ORDER BY peer.consumption)::numeric AS value,
    count(*)::integer AS reference_count
  FROM energy_repair_peers_v1 AS peer
  WHERE peer.vehicle_cluster_id <> target.vehicle_cluster_id
    AND peer.fuel_type = target.fuel_type
    AND peer.hybrid_type = target.hybrid_type
    AND peer.power_kw IS NOT NULL
    AND target.power_kw IS NOT NULL
    AND abs(peer.power_kw - target.power_kw)
      <= greatest(10, target.power_kw * 0.20)
) AS same_fuel_power ON true
LEFT JOIN LATERAL (
  SELECT
    percentile_cont(0.5)
      WITHIN GROUP (ORDER BY peer.consumption)::numeric AS value,
    count(*)::integer AS reference_count
  FROM energy_repair_peers_v1 AS peer
  WHERE peer.vehicle_cluster_id <> target.vehicle_cluster_id
    AND peer.fuel_type = target.fuel_type
    AND peer.hybrid_type = target.hybrid_type
) AS same_fuel ON true;

DO $block$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM energy_repair_plan_v1
    WHERE resolved_consumption IS NULL
      OR resolved_consumption <= 0
      OR resolution_method IS NULL
      OR reference_count <= 0
  ) THEN
    RAISE EXCEPTION
      'Impossibile risolvere in modo controllato tutti i consumi mancanti';
  END IF;
END;
$block$;

INSERT INTO mvp.vehicle_cluster_energy_inputs_v1 (
  vehicle_cluster_id,
  thermal_consumption_per_100km,
  electric_consumption_kwh_100km,
  thermal_method,
  electric_method,
  thermal_reference_count,
  electric_reference_count,
  input_status,
  confidence,
  built_at
)
SELECT
  plan.vehicle_cluster_id,
  plan.resolved_consumption,
  NULL,
  plan.resolution_method,
  NULL,
  plan.reference_count,
  0,
  'ready',
  plan.resolved_confidence,
  now()
FROM energy_repair_plan_v1 AS plan
ON CONFLICT (vehicle_cluster_id) DO UPDATE
SET
  thermal_consumption_per_100km =
    EXCLUDED.thermal_consumption_per_100km,
  thermal_method = EXCLUDED.thermal_method,
  thermal_reference_count = EXCLUDED.thermal_reference_count,
  input_status = 'ready',
  confidence = EXCLUDED.confidence,
  built_at = EXCLUDED.built_at
WHERE mvp.vehicle_cluster_energy_inputs_v1.input_status <> 'ready'
   OR mvp.vehicle_cluster_energy_inputs_v1.thermal_consumption_per_100km
      IS NULL;

UPDATE mvp.vehicle_profiles AS profile
SET
  consumption_l_100km = COALESCE(
    profile.consumption_l_100km,
    plan.resolved_consumption
  ),
  energy_input_source = plan.resolution_method,
  energy_input_confidence = plan.resolved_confidence,
  source_notes = concat_ws(
    ' ',
    NULLIF(btrim(profile.source_notes), ''),
    format(
      'Consumo termico mancante integrato con %s riferimenti (%s; affidabilita %s).',
      plan.reference_count,
      plan.resolution_method,
      plan.resolved_confidence
    )
  )
FROM energy_repair_plan_v1 AS plan
WHERE plan.vehicle_cluster_id = 'profile:' || profile.id::text
  AND profile.profile_status = 'active'
  AND profile.consumption_l_100km IS NULL;

-- Conserva il catalogo precedente e applica un filtro generale: una voce puo
-- essere mostrata solo se il relativo cluster esiste ancora nel motore TCO.
DO $block$
BEGIN
  IF to_regprocedure(
    'mvp.auto_tco_versions_before_availability_filter_v1(text)'
  ) IS NULL THEN
    IF to_regprocedure('public.auto_tco_versions(text)') IS NULL THEN
      RAISE EXCEPTION 'Funzione public.auto_tco_versions non disponibile';
    END IF;

    EXECUTE
      'ALTER FUNCTION public.auto_tco_versions(text) '
      'RENAME TO auto_tco_versions_before_availability_filter_v1';
    EXECUTE
      'ALTER FUNCTION public.auto_tco_versions_before_availability_filter_v1(text) '
      'SET SCHEMA mvp';
  END IF;
END;
$block$;

REVOKE ALL ON FUNCTION
  mvp.auto_tco_versions_before_availability_filter_v1(text)
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
      version.item,
      version.ordinality
    FROM jsonb_array_elements(
      mvp.auto_tco_versions_before_availability_filter_v1(
        left(trim(p_model_id), 64)
      ) -> 'items'
    ) WITH ORDINALITY AS version(item, ordinality)
  ), valid_item AS (
    SELECT source_item.*
    FROM source_item
    WHERE EXISTS (
      SELECT 1
      FROM mvp.site_vehicle_catalog_unified_v1 AS catalog
      WHERE catalog.vehicle_cluster_id =
        source_item.item ->> 'vehicle_cluster_id'
    )
  )
  SELECT jsonb_build_object(
    'items',
    COALESCE(
      jsonb_agg(valid_item.item ORDER BY valid_item.ordinality),
      '[]'::jsonb
    )
  )
  FROM valid_item;
$function$;

COMMENT ON FUNCTION public.auto_tco_versions(text) IS
'Restituisce le versioni del sito escludendo automaticamente riferimenti a cluster non piu presenti nel motore TCO.';

REVOKE ALL ON FUNCTION public.auto_tco_versions(text)
FROM PUBLIC, authenticated;
GRANT EXECUTE ON FUNCTION public.auto_tco_versions(text) TO anon;

CREATE TEMP TABLE stale_cached_versions_v1 AS
SELECT cache.*
FROM mvp.maintenance_display_variant_inputs_v1 AS cache
WHERE NOT EXISTS (
  SELECT 1
  FROM mvp.site_vehicle_catalog_unified_v1 AS catalog
  WHERE catalog.vehicle_cluster_id = cache.vehicle_cluster_id
);

DELETE FROM mvp.maintenance_display_variant_inputs_v1 AS cache
WHERE NOT EXISTS (
  SELECT 1
  FROM mvp.site_vehicle_catalog_unified_v1 AS catalog
  WHERE catalog.vehicle_cluster_id = cache.vehicle_cluster_id
);

ANALYZE mvp.maintenance_display_variant_inputs_v1;

NOTIFY pgrst, 'reload schema';

-- Verifica tutte le riparazioni e la coerenza del nuovo filtro.
CREATE OR REPLACE FUNCTION pg_temp.safe_auto_tco_after_repair(
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

CREATE TEMP TABLE repaired_results_v1 AS
SELECT
  plan.vehicle_cluster_id,
  cache.display_variant_id,
  plan.brand,
  plan.model,
  plan.resolved_consumption,
  plan.resolution_method,
  plan.reference_count,
  plan.resolved_confidence,
  pg_temp.safe_auto_tco_after_repair(
    plan.vehicle_cluster_id,
    cache.display_variant_id
  ) AS payload
FROM energy_repair_plan_v1 AS plan
JOIN mvp.maintenance_display_variant_inputs_v1 AS cache
  ON cache.vehicle_cluster_id = plan.vehicle_cluster_id;

CREATE TEMP TABLE published_version_integrity_v1 AS
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
    model.item ->> 'model_catalog_id' AS model_catalog_id,
    version.item
  FROM model_item AS model
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(
      model.item ->> 'model_catalog_id'
    ) -> 'items'
  ) AS version(item)
)
SELECT
  count(*)::integer AS published_versions,
  count(*) FILTER (
    WHERE NOT EXISTS (
      SELECT 1
      FROM mvp.site_vehicle_catalog_unified_v1 AS catalog
      WHERE catalog.vehicle_cluster_id =
        version_item.item ->> 'vehicle_cluster_id'
    )
  )::integer AS invalid_cluster_links,
  (
    SELECT count(*)::integer
    FROM model_item AS model
    WHERE jsonb_array_length(
      public.auto_tco_versions(
        model.item ->> 'model_catalog_id'
      ) -> 'items'
    ) = 0
  ) AS models_without_versions
FROM version_item;

DO $block$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM repaired_results_v1
    WHERE payload ? '_audit_error'
      OR payload #>> '{quality,status}' <> 'ready'
      OR payload #>> '{monthly_costs,fuel_or_energy_eur}' IS NULL
  )
    OR EXISTS (
      SELECT 1
      FROM published_version_integrity_v1
      WHERE invalid_cluster_links <> 0
        OR models_without_versions <> 0
        OR published_versions <= 0
    )
    OR has_function_privilege(
      'anon',
      'mvp.auto_tco_versions_before_availability_filter_v1(text)',
      'EXECUTE'
    )
  THEN
    RAISE EXCEPTION
      'Verifica riparazione anomalie audit fallita';
  END IF;
END;
$block$;

COMMIT;

WITH repaired AS (
  SELECT
    count(DISTINCT vehicle_cluster_id)::integer
      AS consumi_riparati,
    count(*) FILTER (
      WHERE payload #>> '{quality,status}' = 'ready'
        AND payload #>> '{monthly_costs,fuel_or_energy_eur}' IS NOT NULL
    )::integer AS risultati_ready,
    min(resolved_consumption) AS consumo_minimo,
    max(resolved_consumption) AS consumo_massimo,
    min(reference_count)::integer AS riferimenti_minimi
  FROM repaired_results_v1
), removed AS (
  SELECT count(*)::integer AS versioni_orfane_nascoste
  FROM stale_cached_versions_v1
), integrity AS (
  SELECT * FROM published_version_integrity_v1
)
SELECT
  repaired.consumi_riparati,
  repaired.risultati_ready,
  repaired.consumo_minimo,
  repaired.consumo_massimo,
  repaired.riferimenti_minimi,
  removed.versioni_orfane_nascoste,
  integrity.published_versions,
  integrity.invalid_cluster_links,
  integrity.models_without_versions,
  NOT has_function_privilege(
    'anon',
    'mvp.auto_tco_versions_before_availability_filter_v1(text)',
    'EXECUTE'
  ) AS motore_privato_protetto,
  CASE
    WHEN repaired.consumi_riparati > 0
      AND repaired.risultati_ready >= repaired.consumi_riparati
      AND integrity.invalid_cluster_links = 0
      AND integrity.models_without_versions = 0
      AND NOT has_function_privilege(
        'anon',
        'mvp.auto_tco_versions_before_availability_filter_v1(text)',
        'EXECUTE'
      )
    THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM repaired
CROSS JOIN removed
CROSS JOIN integrity;
