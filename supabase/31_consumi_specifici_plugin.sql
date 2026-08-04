\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - consumi WLTP specifici delle varianti ibride plug-in.
--
-- Per le PHEV il WLTP pubblica consumi combinati ponderati di carburante ed
-- energia. Questi valori incorporano gia il rapporto standardizzato fra fase
-- elettrica e fase termica: non viene quindi applicata una seconda quota
-- arbitraria di chilometri elettrici. Dove la coppia completa non e
-- disponibile, il motore precedente resta il fallback.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

CREATE TABLE IF NOT EXISTS mvp.phev_variant_energy_catalog_v1 (
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
  weighted_thermal_l_100km numeric,
  thermal_empty_battery_l_100km numeric,
  weighted_electric_kwh_100km numeric,
  electric_range_wltp_km numeric,
  source_name text NOT NULL,
  source_url text NOT NULL,
  confidence text NOT NULL,
  imported_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT phev_variant_energy_years_check CHECK (
    year_from BETWEEN 1990 AND 2100
    AND (year_to IS NULL OR year_to BETWEEN year_from AND 2100)
  ),
  CONSTRAINT phev_variant_energy_values_check CHECK (
    system_power_kw > 0
    AND system_power_cv > 0
    AND thermal_power_kw > 0
    AND thermal_power_cv > 0
    AND (
      weighted_thermal_l_100km IS NULL
      OR weighted_thermal_l_100km BETWEEN 0.01 AND 20
    )
    AND (
      thermal_empty_battery_l_100km IS NULL
      OR thermal_empty_battery_l_100km BETWEEN 1 AND 30
    )
    AND (
      weighted_electric_kwh_100km IS NULL
      OR weighted_electric_kwh_100km BETWEEN 1 AND 50
    )
    AND (
      electric_range_wltp_km IS NULL
      OR electric_range_wltp_km BETWEEN 1 AND 500
    )
  ),
  CONSTRAINT phev_variant_energy_confidence_check CHECK (
    confidence IN ('high', 'medium', 'low')
  )
);

COMMENT ON TABLE mvp.phev_variant_energy_catalog_v1 IS
'Consumi WLTP PHEV per motorizzazione da schede tecniche pubbliche; tabella privata, consultabile dal sito soltanto tramite RPC controllata.';

REVOKE ALL ON TABLE mvp.phev_variant_energy_catalog_v1
  FROM PUBLIC, anon, authenticated;
REVOKE ALL ON SEQUENCE mvp.phev_variant_energy_catalog_v1_id_seq
  FROM PUBLIC, anon, authenticated;

TRUNCATE TABLE mvp.phev_variant_energy_catalog_v1 RESTART IDENTITY;

\ir ../scripts/adac-phev-energy.sql

CREATE INDEX IF NOT EXISTS idx_phev_variant_energy_model_year
ON mvp.phev_variant_energy_catalog_v1 (
  model_catalog_id,
  year_from,
  (COALESCE(year_to, 2099))
);

CREATE INDEX IF NOT EXISTS idx_phev_variant_energy_model_powers
ON mvp.phev_variant_energy_catalog_v1 (
  model_catalog_id,
  system_power_kw,
  thermal_power_kw
);

ANALYZE mvp.phev_variant_energy_catalog_v1;

CREATE TABLE IF NOT EXISTS mvp.phev_display_variant_energy_v1 (
  display_variant_id text PRIMARY KEY,
  vehicle_cluster_id text NOT NULL,
  model_catalog_id text NOT NULL,
  brand text NOT NULL,
  model text NOT NULL,
  year_from integer NOT NULL,
  year_to integer NOT NULL,
  system_power_kw numeric NOT NULL,
  system_power_cv numeric NOT NULL,
  thermal_power_kw numeric NOT NULL,
  thermal_power_cv numeric NOT NULL,
  weighted_thermal_l_100km numeric NOT NULL,
  weighted_electric_kwh_100km numeric NOT NULL,
  thermal_empty_battery_l_100km numeric,
  electric_range_wltp_km numeric,
  source_name text NOT NULL,
  source_urls text[] NOT NULL,
  source_records integer NOT NULL,
  confidence text NOT NULL,
  built_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT phev_display_variant_energy_years_check CHECK (
    year_from BETWEEN 1990 AND 2100
    AND year_to BETWEEN year_from AND 2100
  ),
  CONSTRAINT phev_display_variant_energy_values_check CHECK (
    weighted_thermal_l_100km BETWEEN 0.01 AND 20
    AND weighted_electric_kwh_100km BETWEEN 1 AND 50
    AND source_records > 0
  ),
  CONSTRAINT phev_display_variant_energy_confidence_check CHECK (
    confidence IN ('high', 'medium', 'low')
  )
);

COMMENT ON TABLE mvp.phev_display_variant_energy_v1 IS
'Collegamento privato fra varianti PHEV esposte e consumi WLTP ponderati specifici verificati.';

REVOKE ALL ON TABLE mvp.phev_display_variant_energy_v1
  FROM PUBLIC, anon, authenticated;

TRUNCATE TABLE mvp.phev_display_variant_energy_v1;

WITH model_ids AS (
  SELECT DISTINCT catalog.model_catalog_id
  FROM mvp.phev_variant_energy_catalog_v1 AS catalog
  WHERE catalog.weighted_thermal_l_100km IS NOT NULL
    AND catalog.weighted_electric_kwh_100km IS NOT NULL
), public_variants AS (
  SELECT DISTINCT ON (version.item ->> 'display_variant_id')
    version.item
  FROM model_ids AS model
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(model.model_catalog_id) -> 'items'
  ) AS version(item)
  WHERE version.item ->> 'hybrid_type' = 'plug_in_hybrid'
    AND version.item ->> 'power_data_status' = 'verified'
    AND NULLIF(version.item ->> 'display_variant_id', '') IS NOT NULL
    AND NULLIF(version.item ->> 'vehicle_cluster_id', '') IS NOT NULL
    AND NULLIF(version.item ->> 'model_catalog_id', '') IS NOT NULL
    AND NULLIF(version.item ->> 'system_power_kw', '') IS NOT NULL
    AND NULLIF(version.item ->> 'thermal_power_kw', '') IS NOT NULL
    AND NULLIF(version.item ->> 'year_from', '')::integer
      BETWEEN 1990 AND 2100
    AND NULLIF(version.item ->> 'year_to', '')::integer
      BETWEEN 1990 AND 2100
  ORDER BY
    version.item ->> 'display_variant_id',
    NULLIF(version.item ->> 'year_to', '')::integer DESC
), matched AS (
  SELECT
    variant.item,
    energy.weighted_thermal_l_100km,
    energy.weighted_electric_kwh_100km,
    energy.thermal_empty_battery_l_100km,
    energy.electric_range_wltp_km,
    energy.source_name,
    energy.source_urls,
    energy.source_records,
    energy.confidence
  FROM public_variants AS variant
  CROSS JOIN LATERAL (
    SELECT
      percentile_cont(0.5) WITHIN GROUP (
        ORDER BY catalog.weighted_thermal_l_100km
      )::numeric AS weighted_thermal_l_100km,
      percentile_cont(0.5) WITHIN GROUP (
        ORDER BY catalog.weighted_electric_kwh_100km
      )::numeric AS weighted_electric_kwh_100km,
      (
        percentile_cont(0.5) WITHIN GROUP (
          ORDER BY catalog.thermal_empty_battery_l_100km
        ) FILTER (
          WHERE catalog.thermal_empty_battery_l_100km IS NOT NULL
        )
      )::numeric AS thermal_empty_battery_l_100km,
      (
        percentile_cont(0.5) WITHIN GROUP (
          ORDER BY catalog.electric_range_wltp_km
        ) FILTER (
          WHERE catalog.electric_range_wltp_km IS NOT NULL
        )
      )::numeric AS electric_range_wltp_km,
      min(catalog.source_name) AS source_name,
      array_agg(
        DISTINCT catalog.source_url ORDER BY catalog.source_url
      ) AS source_urls,
      count(*)::integer AS source_records,
      CASE min(
        CASE catalog.confidence
          WHEN 'high' THEN 3
          WHEN 'medium' THEN 2
          ELSE 1
        END
      )
        WHEN 3 THEN 'high'
        WHEN 2 THEN 'medium'
        ELSE 'low'
      END AS confidence
    FROM mvp.phev_variant_energy_catalog_v1 AS catalog
    WHERE catalog.model_catalog_id = variant.item ->> 'model_catalog_id'
      AND abs(
        catalog.system_power_kw
          - (variant.item ->> 'system_power_kw')::numeric
      ) <= 1
      AND abs(
        catalog.thermal_power_kw
          - (variant.item ->> 'thermal_power_kw')::numeric
      ) <= 1
      AND catalog.year_from <= (variant.item ->> 'year_to')::integer
      AND coalesce(catalog.year_to, 2099)
        >= (variant.item ->> 'year_from')::integer
      AND catalog.weighted_thermal_l_100km IS NOT NULL
      AND catalog.weighted_electric_kwh_100km IS NOT NULL
  ) AS energy
  WHERE energy.weighted_thermal_l_100km > 0
    AND energy.weighted_electric_kwh_100km > 0
    AND energy.source_records > 0
)
INSERT INTO mvp.phev_display_variant_energy_v1 (
  display_variant_id,
  vehicle_cluster_id,
  model_catalog_id,
  brand,
  model,
  year_from,
  year_to,
  system_power_kw,
  system_power_cv,
  thermal_power_kw,
  thermal_power_cv,
  weighted_thermal_l_100km,
  weighted_electric_kwh_100km,
  thermal_empty_battery_l_100km,
  electric_range_wltp_km,
  source_name,
  source_urls,
  source_records,
  confidence
)
SELECT
  item ->> 'display_variant_id',
  item ->> 'vehicle_cluster_id',
  item ->> 'model_catalog_id',
  item ->> 'brand',
  item ->> 'model',
  (item ->> 'year_from')::integer,
  (item ->> 'year_to')::integer,
  (item ->> 'system_power_kw')::numeric,
  (item ->> 'system_power_cv')::numeric,
  (item ->> 'thermal_power_kw')::numeric,
  (item ->> 'thermal_power_cv')::numeric,
  round(weighted_thermal_l_100km, 3),
  round(weighted_electric_kwh_100km, 3),
  round(thermal_empty_battery_l_100km, 3),
  round(electric_range_wltp_km, 1),
  source_name,
  source_urls,
  source_records,
  confidence
FROM matched;

CREATE INDEX IF NOT EXISTS idx_phev_display_variant_energy_cluster
ON mvp.phev_display_variant_energy_v1 (
  vehicle_cluster_id,
  display_variant_id
);

CREATE INDEX IF NOT EXISTS idx_phev_display_variant_energy_model
ON mvp.phev_display_variant_energy_v1 (
  model_catalog_id,
  year_from,
  year_to
);

ANALYZE mvp.phev_display_variant_energy_v1;

-- Conserva il motore precedente, incluse le correzioni di bollo e
-- svalutazione, quindi modifica soltanto il costo energetico PHEV.
DO $block$
BEGIN
  IF to_regprocedure(
    'mvp.auto_tco_estimate_variant_before_variant_energy_v1(text,text,integer,integer,text)'
  ) IS NULL THEN
    IF to_regprocedure(
      'public.auto_tco_estimate_variant(text,text,integer,integer,text)'
    ) IS NULL THEN
      RAISE EXCEPTION
        'Funzione public.auto_tco_estimate_variant non disponibile';
    END IF;

    EXECUTE
      'ALTER FUNCTION public.auto_tco_estimate_variant(text, text, integer, integer, text) '
      'RENAME TO auto_tco_estimate_variant_before_variant_energy_v1';
    EXECUTE
      'ALTER FUNCTION public.auto_tco_estimate_variant_before_variant_energy_v1(text, text, integer, integer, text) '
      'SET SCHEMA mvp';
  END IF;
END;
$block$;

REVOKE ALL ON FUNCTION
  mvp.auto_tco_estimate_variant_before_variant_energy_v1(
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
  v_energy mvp.phev_display_variant_energy_v1%ROWTYPE;
  v_old_cost numeric;
  v_new_cost numeric;
  v_delta numeric;
  v_subtotal numeric;
  v_total numeric;
  v_fuel_price numeric;
  v_electricity_price numeric;
  v_energy_details jsonb;
  v_assumptions jsonb;
BEGIN
  v_result := mvp.auto_tco_estimate_variant_before_variant_energy_v1(
    p_vehicle_cluster_id,
    p_display_variant_id,
    p_annual_km,
    p_ownership_years,
    p_region_code
  );

  SELECT energy.*
  INTO v_energy
  FROM mvp.phev_display_variant_energy_v1 AS energy
  WHERE energy.display_variant_id = trim(p_display_variant_id)
    AND energy.vehicle_cluster_id = trim(p_vehicle_cluster_id);

  IF NOT FOUND THEN
    RETURN v_result;
  END IF;

  v_old_cost := NULLIF(
    v_result #>> '{monthly_costs,fuel_or_energy_eur}',
    ''
  )::numeric;
  v_fuel_price := NULLIF(
    v_result #>> '{calculation_details,fuel_or_energy,thermal_price_eur}',
    ''
  )::numeric;
  v_electricity_price := NULLIF(
    v_result #>> '{calculation_details,fuel_or_energy,electricity_price_eur_kwh}',
    ''
  )::numeric;

  IF v_old_cost IS NULL
    OR v_fuel_price IS NULL
    OR v_electricity_price IS NULL
  THEN
    RETURN v_result;
  END IF;

  v_new_cost := round(
    p_annual_km::numeric / 100
      * (
        v_energy.weighted_thermal_l_100km * v_fuel_price
        + v_energy.weighted_electric_kwh_100km
          * v_electricity_price
      )
      / 12,
    2
  );
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

  v_result := jsonb_set(
    v_result,
    '{monthly_costs,fuel_or_energy_eur}',
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

  v_energy_details := (
    coalesce(
      v_result #> '{calculation_details,fuel_or_energy}',
      '{}'::jsonb
    ) - 'thermal_km' - 'electric_km'
  ) || jsonb_strip_nulls(jsonb_build_object(
    'method', 'variant_wltp_weighted_combined_v1',
    'thermal_consumption_per_100km',
      v_energy.weighted_thermal_l_100km,
    'electric_consumption_kwh_100km',
      v_energy.weighted_electric_kwh_100km,
    'thermal_consumption_empty_battery_l_100km',
      v_energy.thermal_empty_battery_l_100km,
    'electric_range_wltp_km', v_energy.electric_range_wltp_km,
    'base_monthly_energy_cost_eur', v_old_cost,
    'variant_monthly_energy_cost_eur', v_new_cost,
    'source_name', v_energy.source_name,
    'source_urls', to_jsonb(v_energy.source_urls),
    'source_records', v_energy.source_records,
    'variant_energy_confidence', v_energy.confidence,
    'wltp_usage_assumption',
      'I consumi PHEV combinati ponderati presuppongono ricariche regolari secondo il ciclo WLTP.'
  ));

  v_result := jsonb_set(
    v_result,
    '{calculation_details,fuel_or_energy}',
    v_energy_details,
    true
  );
  v_result := jsonb_set(
    v_result,
    '{descriptions,fuel_or_energy}',
    to_jsonb(
      'Costo basato sui consumi WLTP combinati ponderati della versione plug-in e sui prezzi di carburante ed energia utilizzati; presuppone ricariche regolari.'::text
    ),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,energy_variant_method}',
    to_jsonb('variant_wltp_weighted_combined'::text),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,energy_variant_confidence}',
    to_jsonb(v_energy.confidence),
    true
  );

  v_assumptions := coalesce(v_result -> 'assumptions', '[]'::jsonb)
    || jsonb_build_array(
      'Per la PHEV selezionata sono usati i consumi WLTP combinati ponderati specifici della motorizzazione; il risultato presuppone ricariche regolari.'
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
'Calcola il TCO applicando bollo, svalutazione e consumi WLTP specifici della variante PHEV quando disponibili.';

REVOKE ALL ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) FROM PUBLIC, authenticated;
GRANT EXECUTE ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) TO anon;

NOTIFY pgrst, 'reload schema';

-- Verifica integrata: controlla formula, regressione non PHEV e protezione
-- delle tabelle private. La migrazione fallisce e fa rollback in caso di
-- anomalia.
DO $block$
DECLARE
  v_mapping record;
  v_result jsonb;
  v_expected numeric;
  v_checked integer := 0;
  v_invalid integer;
  v_private_catalog_read boolean;
  v_private_mapping_read boolean;
  v_non_phev_id text;
  v_non_phev_base jsonb;
  v_non_phev_variant jsonb;
BEGIN
  SELECT count(*)
  INTO v_invalid
  FROM mvp.phev_display_variant_energy_v1 AS energy
  WHERE energy.weighted_thermal_l_100km NOT BETWEEN 0.01 AND 20
    OR energy.weighted_electric_kwh_100km NOT BETWEEN 1 AND 50
    OR energy.source_records <= 0
    OR cardinality(energy.source_urls) = 0;

  SELECT has_table_privilege(
    'anon',
    'mvp.phev_variant_energy_catalog_v1',
    'SELECT'
  ) INTO v_private_catalog_read;
  SELECT has_table_privilege(
    'anon',
    'mvp.phev_display_variant_energy_v1',
    'SELECT'
  ) INTO v_private_mapping_read;

  FOR v_mapping IN
    SELECT DISTINCT ON (energy.model_catalog_id)
      energy.*
    FROM mvp.phev_display_variant_energy_v1 AS energy
    ORDER BY
      energy.model_catalog_id,
      energy.source_records DESC,
      energy.display_variant_id
    LIMIT 12
  LOOP
    v_result := public.auto_tco_estimate_variant(
      v_mapping.vehicle_cluster_id,
      v_mapping.display_variant_id,
      15000, 5, 'italia'
    );
    v_expected := round(
      15000::numeric / 100
        * (
          v_mapping.weighted_thermal_l_100km
            * (v_result #>> '{calculation_details,fuel_or_energy,thermal_price_eur}')::numeric
          + v_mapping.weighted_electric_kwh_100km
            * (v_result #>> '{calculation_details,fuel_or_energy,electricity_price_eur_kwh}')::numeric
        )
        / 12,
      2
    );

    IF (v_result #>> '{monthly_costs,fuel_or_energy_eur}')::numeric
        <> v_expected
      OR v_result #>> '{calculation_details,fuel_or_energy,method}'
        <> 'variant_wltp_weighted_combined_v1'
      OR v_result #>> '{calculation_details,fuel_or_energy,thermal_km}'
        IS NOT NULL
      OR v_result #>> '{calculation_details,fuel_or_energy,electric_km}'
        IS NOT NULL
    THEN
      RAISE EXCEPTION
        'Consumo variante errato per %',
        v_mapping.display_variant_id;
    END IF;

    v_checked := v_checked + 1;
  END LOOP;

  SELECT catalog.vehicle_cluster_id
  INTO v_non_phev_id
  FROM mvp.site_vehicle_catalog_unified_v1 AS catalog
  WHERE coalesce(catalog.hybrid_type, 'none') <> 'plug_in_hybrid'
  ORDER BY catalog.registrations_count DESC, catalog.vehicle_cluster_id
  LIMIT 1;

  v_non_phev_base :=
    mvp.auto_tco_estimate_variant_before_variant_energy_v1(
      v_non_phev_id,
      v_non_phev_id,
      15000, 5, 'italia'
    );
  v_non_phev_variant := public.auto_tco_estimate_variant(
    v_non_phev_id,
    v_non_phev_id,
    15000, 5, 'italia'
  );

  IF v_invalid <> 0
    OR v_private_catalog_read
    OR v_private_mapping_read
    OR v_checked < 5
    OR v_non_phev_base <> v_non_phev_variant
  THEN
    RAISE EXCEPTION
      'Verifica consumi PHEV fallita: anomalie %, catalogo leggibile %, collegamenti leggibili %, campioni %, regressione %',
      v_invalid,
      v_private_catalog_read,
      v_private_mapping_read,
      v_checked,
      v_non_phev_base <> v_non_phev_variant;
  END IF;
END;
$block$;

COMMIT;

WITH counts AS (
  SELECT
    count(*)::integer AS varianti_con_consumo_specifico,
    count(DISTINCT model_catalog_id)::integer AS modelli_coperti,
    count(DISTINCT brand)::integer AS marche_coperte,
    count(*) FILTER (WHERE confidence = 'high')::integer
      AS consumi_alta_affidabilita
  FROM mvp.phev_display_variant_energy_v1
), formentor AS (
  SELECT
    max(weighted_thermal_l_100km) FILTER (
      WHERE round(system_power_cv) = 204
    ) AS termico_204,
    max(weighted_electric_kwh_100km) FILTER (
      WHERE round(system_power_cv) = 204
    ) AS elettrico_204,
    max(weighted_thermal_l_100km) FILTER (
      WHERE round(system_power_cv) = 245
    ) AS termico_245,
    max(weighted_electric_kwh_100km) FILTER (
      WHERE round(system_power_cv) = 245
    ) AS elettrico_245,
    max(weighted_thermal_l_100km) FILTER (
      WHERE round(system_power_cv) = 272
    ) AS termico_272,
    max(weighted_electric_kwh_100km) FILTER (
      WHERE round(system_power_cv) = 272
    ) AS elettrico_272
  FROM mvp.phev_display_variant_energy_v1
  WHERE lower(brand) = 'cupra'
    AND lower(model) = 'formentor'
), sample AS (
  SELECT result
  FROM mvp.phev_display_variant_energy_v1 AS energy
  CROSS JOIN LATERAL (
    SELECT public.auto_tco_estimate_variant(
      energy.vehicle_cluster_id,
      energy.display_variant_id,
      15000, 5, 'italia'
    ) AS result
  ) AS calculated
  ORDER BY energy.source_records DESC, energy.display_variant_id
  LIMIT 1
)
SELECT
  counts.varianti_con_consumo_specifico,
  counts.modelli_coperti,
  counts.marche_coperte,
  counts.consumi_alta_affidabilita,
  formentor.termico_204 AS formentor_204_l_100km,
  formentor.elettrico_204 AS formentor_204_kwh_100km,
  formentor.termico_245 AS formentor_245_l_100km,
  formentor.elettrico_245 AS formentor_245_kwh_100km,
  formentor.termico_272 AS formentor_272_l_100km,
  formentor.elettrico_272 AS formentor_272_kwh_100km,
  sample.result #>> '{monthly_costs,fuel_or_energy_eur}'
    AS esempio_energia_mese,
  sample.result #>> '{calculation_details,fuel_or_energy,method}'
    AS esempio_metodo,
  NOT has_table_privilege(
    'anon',
    'mvp.phev_variant_energy_catalog_v1',
    'SELECT'
  ) AND NOT has_table_privilege(
    'anon',
    'mvp.phev_display_variant_energy_v1',
    'SELECT'
  ) AS dati_privati_protetti,
  CASE
    WHEN counts.varianti_con_consumo_specifico >= 80
      AND counts.modelli_coperti >= 40
      AND counts.consumi_alta_affidabilita
        = counts.varianti_con_consumo_specifico
      AND formentor.termico_204 IS NOT NULL
      AND formentor.elettrico_204 IS NOT NULL
      AND formentor.termico_245 IS NOT NULL
      AND formentor.elettrico_245 IS NOT NULL
      AND formentor.termico_272 IS NOT NULL
      AND formentor.elettrico_272 IS NOT NULL
      AND sample.result #>> '{calculation_details,fuel_or_energy,method}'
        = 'variant_wltp_weighted_combined_v1'
      AND NOT has_table_privilege(
        'anon',
        'mvp.phev_variant_energy_catalog_v1',
        'SELECT'
      )
      AND NOT has_table_privilege(
        'anon',
        'mvp.phev_display_variant_energy_v1',
        'SELECT'
      )
    THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM counts
CROSS JOIN formentor
CROSS JOIN sample;
