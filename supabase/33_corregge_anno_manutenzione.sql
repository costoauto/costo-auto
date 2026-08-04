\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - usa per la manutenzione l'anno della versione mostrata.
--
-- La precedente funzione usava representative_year per i profili e 2025
-- per tutti gli altri cluster. Questo poteva trattare come quasi nuove
-- versioni storiche. La presente migrazione indicizza gli input pubblici
-- delle versioni e ricalcola soltanto la manutenzione, senza modificare
-- carburante/energia, bollo, RC Auto o svalutazione.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

CREATE TABLE IF NOT EXISTS mvp.maintenance_display_variant_inputs_v1 (
  display_variant_id text NOT NULL,
  vehicle_cluster_id text NOT NULL,
  model_catalog_id text NOT NULL,
  brand text NOT NULL,
  model text NOT NULL,
  version_label text NOT NULL,
  year_from integer NOT NULL,
  year_to integer NOT NULL,
  display_year integer NOT NULL,
  year_source text NOT NULL,
  year_confidence text NOT NULL,
  fuel_type text NOT NULL,
  hybrid_type text NOT NULL,
  displayed_power_kw numeric,
  thermal_power_kw numeric,
  maintenance_power_kw numeric,
  power_basis text NOT NULL,
  built_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (display_variant_id, vehicle_cluster_id),
  CONSTRAINT maintenance_display_year_range_valid
    CHECK (
      year_from BETWEEN 1900 AND 2100
      AND year_to BETWEEN year_from AND 2100
      AND display_year BETWEEN year_from AND year_to
    ),
  CONSTRAINT maintenance_display_power_positive
    CHECK (maintenance_power_kw IS NULL OR maintenance_power_kw > 0)
);

COMMENT ON TABLE mvp.maintenance_display_variant_inputs_v1 IS
'Cache privata degli anni e della potenza da usare per la manutenzione delle versioni effettivamente pubblicate dal sito.';

REVOKE ALL ON mvp.maintenance_display_variant_inputs_v1
FROM PUBLIC, anon, authenticated;

TRUNCATE TABLE mvp.maintenance_display_variant_inputs_v1;

WITH brand_item AS (
  SELECT brand.item
  FROM jsonb_array_elements(
    public.auto_tco_brands() -> 'items'
  ) AS brand(item)
), model_item AS (
  SELECT DISTINCT
    model.item ->> 'model_catalog_id' AS model_catalog_id
  FROM brand_item AS brand
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_models(brand.item ->> 'brand_key') -> 'items'
  ) AS model(item)
  WHERE NULLIF(model.item ->> 'model_catalog_id', '') IS NOT NULL
), version_item AS (
  SELECT
    model.model_catalog_id,
    version.item
  FROM model_item AS model
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(model.model_catalog_id) -> 'items'
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
      model_catalog_id
    ) AS model_catalog_id,
    NULLIF(item ->> 'brand', '') AS brand,
    NULLIF(item ->> 'model', '') AS model,
    NULLIF(item ->> 'version_label', '') AS version_label,
    COALESCE(
      NULLIF(item ->> 'year_from', '')::integer,
      NULLIF(item ->> 'display_year', '')::integer,
      NULLIF(item ->> 'representative_year', '')::integer
    ) AS year_from,
    COALESCE(
      NULLIF(item ->> 'year_to', '')::integer,
      NULLIF(item ->> 'display_year', '')::integer,
      NULLIF(item ->> 'representative_year', '')::integer
    ) AS year_to,
    COALESCE(
      NULLIF(item ->> 'display_year', '')::integer,
      round(
        (
          NULLIF(item ->> 'year_from', '')::numeric
          + NULLIF(item ->> 'year_to', '')::numeric
        ) / 2.0
      )::integer,
      NULLIF(item ->> 'representative_year', '')::integer
    ) AS display_year,
    COALESCE(NULLIF(item ->> 'year_source', ''), 'catalog_display_year')
      AS year_source,
    COALESCE(NULLIF(item ->> 'year_confidence', ''), 'low')
      AS year_confidence,
    COALESCE(NULLIF(item ->> 'fuel_type', ''), 'unknown')
      AS fuel_type,
    COALESCE(NULLIF(item ->> 'hybrid_type', ''), 'none')
      AS hybrid_type,
    NULLIF(item ->> 'power_kw', '')::numeric AS displayed_power_kw,
    NULLIF(item ->> 'thermal_power_kw', '')::numeric AS thermal_power_kw
  FROM version_item
), valid AS (
  SELECT
    normalized.*,
    CASE
      WHEN hybrid_type = 'plug_in_hybrid'
        AND thermal_power_kw > 0
        THEN thermal_power_kw
      ELSE displayed_power_kw
    END AS maintenance_power_kw,
    CASE
      WHEN hybrid_type = 'plug_in_hybrid'
        AND thermal_power_kw > 0
        THEN 'thermal_engine_power'
      ELSE 'declared_vehicle_power'
    END AS power_basis
  FROM normalized
  WHERE display_variant_id IS NOT NULL
    AND vehicle_cluster_id IS NOT NULL
    AND model_catalog_id IS NOT NULL
    AND brand IS NOT NULL
    AND model IS NOT NULL
    AND version_label IS NOT NULL
    AND year_from BETWEEN 1900 AND 2100
    AND year_to BETWEEN year_from AND 2100
    AND display_year BETWEEN year_from AND year_to
), deduplicated AS (
  SELECT DISTINCT ON (display_variant_id, vehicle_cluster_id)
    *
  FROM valid
  ORDER BY
    display_variant_id,
    vehicle_cluster_id,
    CASE year_confidence
      WHEN 'high' THEN 1
      WHEN 'medium_high' THEN 2
      WHEN 'medium' THEN 3
      WHEN 'medium_low' THEN 4
      ELSE 5
    END,
    year_to DESC
)
INSERT INTO mvp.maintenance_display_variant_inputs_v1 (
  display_variant_id,
  vehicle_cluster_id,
  model_catalog_id,
  brand,
  model,
  version_label,
  year_from,
  year_to,
  display_year,
  year_source,
  year_confidence,
  fuel_type,
  hybrid_type,
  displayed_power_kw,
  thermal_power_kw,
  maintenance_power_kw,
  power_basis,
  built_at
)
SELECT
  display_variant_id,
  vehicle_cluster_id,
  model_catalog_id,
  brand,
  model,
  version_label,
  year_from,
  year_to,
  display_year,
  year_source,
  year_confidence,
  fuel_type,
  hybrid_type,
  displayed_power_kw,
  thermal_power_kw,
  maintenance_power_kw,
  power_basis,
  now()
FROM deduplicated;

CREATE INDEX IF NOT EXISTS idx_maintenance_display_variant_cluster
ON mvp.maintenance_display_variant_inputs_v1 (
  vehicle_cluster_id,
  display_variant_id
);

CREATE INDEX IF NOT EXISTS idx_maintenance_display_variant_model
ON mvp.maintenance_display_variant_inputs_v1 (
  model_catalog_id,
  year_from,
  year_to
);

ANALYZE mvp.maintenance_display_variant_inputs_v1;

DO $block$
BEGIN
  IF to_regprocedure(
    'mvp.auto_tco_estimate_variant_before_maintenance_year_v1(text,text,integer,integer,text)'
  ) IS NULL THEN
    IF to_regprocedure(
      'public.auto_tco_estimate_variant(text,text,integer,integer,text)'
    ) IS NULL THEN
      RAISE EXCEPTION
        'Funzione public.auto_tco_estimate_variant non disponibile';
    END IF;

    EXECUTE
      'ALTER FUNCTION public.auto_tco_estimate_variant(text, text, integer, integer, text) '
      'RENAME TO auto_tco_estimate_variant_before_maintenance_year_v1';
    EXECUTE
      'ALTER FUNCTION public.auto_tco_estimate_variant_before_maintenance_year_v1(text, text, integer, integer, text) '
      'SET SCHEMA mvp';
  END IF;
END;
$block$;

REVOKE ALL ON FUNCTION
  mvp.auto_tco_estimate_variant_before_maintenance_year_v1(
    text, text, integer, integer, text
  )
FROM PUBLIC, anon, authenticated;

CREATE OR REPLACE FUNCTION public.auto_tco_estimate_variant(
  p_vehicle_cluster_id text,
  p_display_variant_id text,
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
  v_result jsonb;
  v_input mvp.maintenance_display_variant_inputs_v1%ROWTYPE;
  v_maintenance jsonb;
  v_details jsonb;
  v_old_cost numeric;
  v_new_cost numeric;
  v_delta numeric;
  v_subtotal numeric;
  v_total numeric;
  v_confidence text;
  v_assumptions jsonb;
BEGIN
  v_result := mvp.auto_tco_estimate_variant_before_maintenance_year_v1(
    p_vehicle_cluster_id,
    p_display_variant_id,
    p_annual_km,
    p_ownership_years,
    p_region_code
  );

  SELECT input.*
  INTO v_input
  FROM mvp.maintenance_display_variant_inputs_v1 AS input
  WHERE input.display_variant_id = trim(p_display_variant_id)
    AND input.vehicle_cluster_id = trim(p_vehicle_cluster_id);

  IF NOT FOUND THEN
    v_result := jsonb_set(
      v_result,
      '{quality,maintenance_year_method}',
      to_jsonb('legacy_year_fallback'::text),
      true
    );
    v_result := jsonb_set(
      v_result,
      '{quality,confidence,maintenance}',
      to_jsonb('low'::text),
      true
    );
    RETURN v_result;
  END IF;

  v_maintenance := mvp.estimate_maintenance_v1(
    v_input.fuel_type,
    v_input.hybrid_type,
    v_input.display_year,
    v_input.maintenance_power_kw,
    p_annual_km,
    p_ownership_years,
    CURRENT_DATE
  );

  v_old_cost := NULLIF(
    v_result #>> '{monthly_costs,maintenance_eur}',
    ''
  )::numeric;
  v_new_cost := NULLIF(
    v_maintenance ->> 'monthly_maintenance_eur',
    ''
  )::numeric;

  IF v_old_cost IS NULL OR v_new_cost IS NULL THEN
    RETURN v_result;
  END IF;

  v_delta := v_new_cost - v_old_cost;
  v_subtotal := CASE
    WHEN v_result #>> '{monthly_costs,available_subtotal_eur}' IS NULL
      THEN NULL
    ELSE round(
      (v_result #>> '{monthly_costs,available_subtotal_eur}')::numeric
        + v_delta,
      2
    )
  END;
  v_total := CASE
    WHEN v_result #>> '{monthly_costs,total_monthly_eur}' IS NULL
      THEN NULL
    ELSE round(
      (v_result #>> '{monthly_costs,total_monthly_eur}')::numeric
        + v_delta,
      2
    )
  END;

  v_confidence := CASE
    WHEN v_input.year_confidence IN ('low', 'missing', 'unknown')
      OR v_maintenance ->> 'confidence' = 'low'
      THEN 'low'
    ELSE v_maintenance ->> 'confidence'
  END;

  v_details := (
    v_maintenance - 'description'
  ) || jsonb_build_object(
    'method', 'display_variant_year_v2',
    'description',
      'Stima di tagliandi, materiali di consumo e usura prevedibile basata su chilometri, età, alimentazione e potenza.',
    'representative_year_used', v_input.display_year,
    'version_year_from', v_input.year_from,
    'version_year_to', v_input.year_to,
    'age_basis',
      CASE
        WHEN v_input.year_from = v_input.year_to
          THEN 'exact_model_year'
        ELSE 'display_range_midpoint'
      END,
    'year_source', v_input.year_source,
    'year_confidence', v_input.year_confidence,
    'maintenance_power_kw', v_input.maintenance_power_kw,
    'power_basis', v_input.power_basis,
    'model_specific_schedule_applied', false,
    'confidence', v_confidence
  );

  v_result := jsonb_set(
    v_result,
    '{monthly_costs,maintenance_eur}',
    to_jsonb(v_new_cost),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{monthly_costs,available_subtotal_eur}',
    coalesce(to_jsonb(v_subtotal), 'null'::jsonb),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{monthly_costs,total_monthly_eur}',
    coalesce(to_jsonb(v_total), 'null'::jsonb),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{descriptions,maintenance}',
    to_jsonb(
      'Stima di tagliandi, materiali di consumo e usura prevedibile. Sono esclusi pneumatici, revisione, incidenti, batteria di trazione e guasti straordinari non prevedibili.'::text
    ),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,components,maintenance}',
    to_jsonb('estimated'::text),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,confidence,maintenance}',
    to_jsonb(v_confidence),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,maintenance_year_method}',
    to_jsonb('display_variant_year'::text),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{calculation_details,maintenance}',
    v_details,
    true
  );

  v_assumptions := coalesce(v_result -> 'assumptions', '[]'::jsonb)
    || jsonb_build_array(
      CASE
        WHEN v_input.year_from = v_input.year_to THEN
          'La manutenzione usa l''anno modello '
            || v_input.display_year::text || ' mostrato nella versione.'
        ELSE
          'La manutenzione usa il '
            || v_input.display_year::text
            || ' come anno rappresentativo dell''intervallo '
            || v_input.year_from::text || '-'
            || v_input.year_to::text || '.'
      END
    );
  v_result := jsonb_set(
    v_result,
    '{assumptions}',
    v_assumptions,
    true
  );

  RETURN v_result;
END;
$function$;

COMMENT ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) IS
'Calcola il TCO e ricalcola la manutenzione usando l anno o il punto medio dell intervallo effettivamente mostrato per la versione.';

REVOKE ALL ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) FROM PUBLIC, authenticated;
GRANT EXECUTE ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) TO anon;

NOTIFY pgrst, 'reload schema';

-- Verifica integrata: il caso storico noto deve usare il 2008 anziché
-- l anno implicito 2025; le altre componenti non devono cambiare.
DO $block$
DECLARE
  v_historical mvp.maintenance_display_variant_inputs_v1%ROWTYPE;
  v_recent mvp.maintenance_display_variant_inputs_v1%ROWTYPE;
  v_phev mvp.maintenance_display_variant_inputs_v1%ROWTYPE;
  v_old jsonb;
  v_new jsonb;
  v_30k jsonb;
  v_10y jsonb;
  v_recent_result jsonb;
  v_phev_result jsonb;
  v_expected_age integer;
  v_private_table_read boolean;
  v_private_function_execute boolean;
  v_invalid integer;
BEGIN
  SELECT count(*)
  INTO v_invalid
  FROM mvp.maintenance_display_variant_inputs_v1 AS input
  WHERE input.display_year NOT BETWEEN input.year_from AND input.year_to
    OR input.year_from < 1900
    OR input.year_to > 2100
    OR input.display_variant_id = ''
    OR input.vehicle_cluster_id = '';

  SELECT input.*
  INTO v_historical
  FROM mvp.maintenance_display_variant_inputs_v1 AS input
  WHERE input.vehicle_cluster_id NOT LIKE 'profile:%'
    AND input.display_year
      <= extract(year FROM CURRENT_DATE)::integer - 10
    AND input.maintenance_power_kw IS NOT NULL
  ORDER BY
    input.display_year,
    input.year_from,
    input.display_variant_id
  LIMIT 1;

  IF NOT FOUND THEN
    RAISE EXCEPTION
      'Versione storica non-profile non trovata nella cache';
  END IF;

  v_old := mvp.auto_tco_estimate_variant_before_maintenance_year_v1(
    v_historical.vehicle_cluster_id,
    v_historical.display_variant_id,
    15000, 5, 'italia'
  );
  v_new := public.auto_tco_estimate_variant(
    v_historical.vehicle_cluster_id,
    v_historical.display_variant_id,
    15000, 5, 'italia'
  );
  v_30k := public.auto_tco_estimate_variant(
    v_historical.vehicle_cluster_id,
    v_historical.display_variant_id,
    30000, 5, 'italia'
  );
  v_10y := public.auto_tco_estimate_variant(
    v_historical.vehicle_cluster_id,
    v_historical.display_variant_id,
    15000, 10, 'italia'
  );

  v_expected_age := greatest(
    extract(year FROM CURRENT_DATE)::integer - v_historical.display_year,
    0
  );

  SELECT input.*
  INTO v_recent
  FROM mvp.maintenance_display_variant_inputs_v1 AS input
  WHERE input.year_to >= extract(year FROM CURRENT_DATE)::integer - 1
  ORDER BY input.year_to DESC, input.display_variant_id
  LIMIT 1;

  v_recent_result := public.auto_tco_estimate_variant(
    v_recent.vehicle_cluster_id,
    v_recent.display_variant_id,
    15000, 5, 'italia'
  );

  SELECT input.*
  INTO v_phev
  FROM mvp.maintenance_display_variant_inputs_v1 AS input
  WHERE input.hybrid_type = 'plug_in_hybrid'
    AND input.thermal_power_kw IS NOT NULL
  ORDER BY input.year_to DESC, input.display_variant_id
  LIMIT 1;

  IF FOUND THEN
    v_phev_result := public.auto_tco_estimate_variant(
      v_phev.vehicle_cluster_id,
      v_phev.display_variant_id,
      15000, 5, 'italia'
    );
  END IF;

  SELECT has_table_privilege(
    'anon',
    'mvp.maintenance_display_variant_inputs_v1',
    'SELECT'
  ) INTO v_private_table_read;
  SELECT has_function_privilege(
    'anon',
    'mvp.auto_tco_estimate_variant_before_maintenance_year_v1(text,text,integer,integer,text)',
    'EXECUTE'
  ) INTO v_private_function_execute;

  IF v_invalid <> 0
    OR (SELECT count(*) FROM mvp.maintenance_display_variant_inputs_v1) < 1000
    OR (v_old #>> '{calculation_details,maintenance,starting_age_years}')::integer
      = v_expected_age
    OR (v_new #>> '{calculation_details,maintenance,starting_age_years}')::integer
      <> v_expected_age
    OR v_new #>> '{calculation_details,maintenance,method}'
      <> 'display_variant_year_v2'
    OR (v_new #>> '{monthly_costs,maintenance_eur}')::numeric
      <= (v_old #>> '{monthly_costs,maintenance_eur}')::numeric
    OR abs(
      (v_30k #>> '{monthly_costs,maintenance_eur}')::numeric
        - 2 * (v_new #>> '{monthly_costs,maintenance_eur}')::numeric
    ) > 0.02
    OR (v_10y #>> '{monthly_costs,maintenance_eur}')::numeric
      < (v_new #>> '{monthly_costs,maintenance_eur}')::numeric
    OR v_old #>> '{monthly_costs,depreciation_eur}'
      <> v_new #>> '{monthly_costs,depreciation_eur}'
    OR v_old #>> '{monthly_costs,fuel_or_energy_eur}'
      <> v_new #>> '{monthly_costs,fuel_or_energy_eur}'
    OR v_old #>> '{monthly_costs,tax_eur}'
      <> v_new #>> '{monthly_costs,tax_eur}'
    OR v_old #>> '{monthly_costs,insurance_eur}'
      <> v_new #>> '{monthly_costs,insurance_eur}'
    OR (v_recent_result #>> '{calculation_details,maintenance,representative_year_used}')::integer
      <> v_recent.display_year
    OR (
      v_phev.display_variant_id IS NOT NULL
      AND v_phev_result #>> '{calculation_details,maintenance,power_basis}'
        <> 'thermal_engine_power'
    )
    OR v_private_table_read
    OR v_private_function_execute
  THEN
    RAISE EXCEPTION 'Verifica correzione anno manutenzione fallita';
  END IF;
END;
$block$;

COMMIT;

WITH historical AS (
  SELECT input.*
  FROM mvp.maintenance_display_variant_inputs_v1 AS input
  WHERE input.vehicle_cluster_id NOT LIKE 'profile:%'
    AND input.display_year
      <= extract(year FROM CURRENT_DATE)::integer - 10
    AND input.maintenance_power_kw IS NOT NULL
  ORDER BY
    input.display_year,
    input.year_from,
    input.display_variant_id
  LIMIT 1
), calculated AS (
  SELECT
    historical.*,
    mvp.auto_tco_estimate_variant_before_maintenance_year_v1(
      historical.vehicle_cluster_id,
      historical.display_variant_id,
      15000, 5, 'italia'
    ) AS old_result,
    public.auto_tco_estimate_variant(
      historical.vehicle_cluster_id,
      historical.display_variant_id,
      15000, 5, 'italia'
    ) AS new_result
  FROM historical
), counts AS (
  SELECT
    count(*)::integer AS versioni_indicizzate,
    count(DISTINCT model_catalog_id)::integer AS modelli_coperti,
    count(*) FILTER (WHERE year_from = year_to)::integer
      AS versioni_anno_esatto,
    count(*) FILTER (WHERE year_from <> year_to)::integer
      AS versioni_intervallo,
    count(*) FILTER (
      WHERE hybrid_type = 'plug_in_hybrid'
        AND power_basis = 'thermal_engine_power'
    )::integer AS plugin_potenza_termica
  FROM mvp.maintenance_display_variant_inputs_v1
)
SELECT
  counts.versioni_indicizzate,
  counts.modelli_coperti,
  counts.versioni_anno_esatto,
  counts.versioni_intervallo,
  counts.plugin_potenza_termica,
  calculated.version_label AS esempio_storico,
  calculated.display_year AS anno_corretto,
  calculated.old_result #>>
    '{calculation_details,maintenance,starting_age_years}'
    AS eta_usata_prima,
  calculated.new_result #>>
    '{calculation_details,maintenance,starting_age_years}'
    AS eta_usata_ora,
  calculated.old_result #>> '{monthly_costs,maintenance_eur}'
    AS manutenzione_prima,
  calculated.new_result #>> '{monthly_costs,maintenance_eur}'
    AS manutenzione_ora,
  NOT has_table_privilege(
    'anon',
    'mvp.maintenance_display_variant_inputs_v1',
    'SELECT'
  ) AS dati_privati_protetti,
  CASE
    WHEN calculated.new_result #>>
        '{calculation_details,maintenance,method}'
        = 'display_variant_year_v2'
      AND calculated.new_result #>>
        '{calculation_details,maintenance,representative_year_used}'
        = calculated.display_year::text
      AND NOT has_table_privilege(
        'anon',
        'mvp.maintenance_display_variant_inputs_v1',
        'SELECT'
      )
    THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM counts
CROSS JOIN calculated;
