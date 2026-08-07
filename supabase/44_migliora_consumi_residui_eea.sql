\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - migliora i consumi residui con osservazioni EEA dello stesso
-- modello, della stessa alimentazione e della stessa potenza motore.
--
-- La correzione e volutamente prudente:
--   * usa soltanto anni compresi nell'intervallo mostrato all'utente;
--   * per le PHEV confronta la potenza termica, non quella di sistema;
--   * aggrega i consumi pesandoli per le immatricolazioni osservate;
--   * assegna al massimo affidabilita medium;
--   * non modifica le tabelle sorgente o i consumi delle altre versioni.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

CREATE TABLE IF NOT EXISTS mvp.residual_eea_variant_energy_v1 (
  display_variant_id text PRIMARY KEY,
  vehicle_cluster_id text NOT NULL,
  model_catalog_id text NOT NULL,
  brand text NOT NULL,
  model text NOT NULL,
  year_from integer NOT NULL,
  year_to integer NOT NULL,
  fuel_type text NOT NULL,
  hybrid_type text NOT NULL,
  matched_power_kw numeric NOT NULL,
  thermal_consumption_per_100km numeric,
  electric_consumption_kwh_100km numeric,
  source_year_from integer NOT NULL,
  source_year_to integer NOT NULL,
  source_groups integer NOT NULL,
  source_records integer NOT NULL,
  registrations_count bigint NOT NULL,
  source_methods text[] NOT NULL,
  method text NOT NULL,
  confidence text NOT NULL,
  source_name text NOT NULL,
  source_url text NOT NULL,
  built_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT residual_eea_variant_energy_years_check CHECK (
    year_from BETWEEN 1990 AND 2100
    AND year_to BETWEEN year_from AND 2100
    AND source_year_from BETWEEN year_from AND year_to
    AND source_year_to BETWEEN source_year_from AND year_to
  ),
  CONSTRAINT residual_eea_variant_energy_counts_check CHECK (
    source_groups > 0
    AND source_records > 0
    AND registrations_count >= 3
  ),
  CONSTRAINT residual_eea_variant_energy_confidence_check CHECK (
    confidence = 'medium'
  )
);

COMMENT ON TABLE mvp.residual_eea_variant_energy_v1 IS
'Collegamenti privati e verificabili fra versioni pubbliche con consumo debole e osservazioni EEA dello stesso modello, alimentazione, potenza e intervallo di anni.';

REVOKE ALL ON mvp.residual_eea_variant_energy_v1
FROM PUBLIC, anon, authenticated;

TRUNCATE TABLE mvp.residual_eea_variant_energy_v1;

CREATE OR REPLACE FUNCTION pg_temp.safe_tco_energy_resolution_v1(
  p_vehicle_cluster_id text,
  p_display_variant_id text
)
RETURNS jsonb
LANGUAGE plpgsql
VOLATILE
AS $function$
DECLARE
  v_result jsonb;
BEGIN
  -- In caso di riesecuzione, ricostruisce il piano dal motore precedente
  -- alla correzione, evitando che le righe gia migliorate si autoescludano.
  IF to_regprocedure(
    'mvp.auto_tco_estimate_variant_before_residual_eea_v1(text,text,integer,integer,text)'
  ) IS NOT NULL THEN
    EXECUTE
      'SELECT mvp.auto_tco_estimate_variant_before_residual_eea_v1($1,$2,$3,$4,$5)'
    INTO v_result
    USING
      p_vehicle_cluster_id,
      p_display_variant_id,
      15000,
      5,
      'italia';
    RETURN v_result;
  END IF;

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

CREATE TEMP TABLE public_energy_candidates_v1
ON COMMIT DROP
AS
WITH brand_item AS (
  SELECT brand.item
  FROM jsonb_array_elements(
    public.auto_tco_brands() -> 'items'
  ) AS brand(item)
), model_item AS (
  SELECT DISTINCT ON (model.item ->> 'model_catalog_id')
    model.item
  FROM brand_item AS brand
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_models(brand.item ->> 'brand_key') -> 'items'
  ) AS model(item)
  WHERE NULLIF(model.item ->> 'model_catalog_id', '') IS NOT NULL
  ORDER BY model.item ->> 'model_catalog_id'
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
), public_version AS (
  SELECT DISTINCT ON (
    model_catalog_id,
    item ->> 'display_variant_id',
    item ->> 'vehicle_cluster_id'
  )
    model_catalog_id,
    item ->> 'brand' AS brand,
    item ->> 'model' AS model,
    item ->> 'version_label' AS version_label,
    item ->> 'display_variant_id' AS display_variant_id,
    item ->> 'vehicle_cluster_id' AS vehicle_cluster_id,
    nullif(item ->> 'vehicle_profile_id', '')::integer
      AS vehicle_profile_id,
    item ->> 'fuel_type' AS fuel_type,
    coalesce(nullif(item ->> 'hybrid_type', ''), 'none') AS hybrid_type,
    nullif(item ->> 'year_from', '')::integer AS year_from,
    nullif(item ->> 'year_to', '')::integer AS year_to,
    coalesce(
      nullif(item ->> 'thermal_power_kw', '')::numeric,
      nullif(item ->> 'power_kw', '')::numeric
    ) AS matched_power_kw,
    item
  FROM version_item
  WHERE nullif(item ->> 'display_variant_id', '') IS NOT NULL
    AND nullif(item ->> 'vehicle_cluster_id', '') IS NOT NULL
  ORDER BY
    model_catalog_id,
    item ->> 'display_variant_id',
    item ->> 'vehicle_cluster_id',
    nullif(item ->> 'year_to', '')::integer DESC NULLS LAST
), current_result AS (
  SELECT
    version.*,
    pg_temp.safe_tco_energy_resolution_v1(
      version.vehicle_cluster_id,
      version.display_variant_id
    ) AS payload
  FROM public_version AS version
), weak_version AS (
  SELECT
    current_result.*,
    coalesce(
      nullif(
        payload #>> '{quality,energy_variant_confidence}',
        ''
      ),
      nullif(
        payload #>> '{quality,energy_source_confidence}',
        ''
      ),
      nullif(
        payload #>>
          '{calculation_details,fuel_or_energy,variant_energy_confidence}',
        ''
      ),
      nullif(input.confidence, ''),
      nullif(profile.energy_input_confidence, ''),
      nullif(profile.confidence, ''),
      item ->> 'observation_quality',
      'missing'
    ) AS current_confidence
  FROM current_result
  LEFT JOIN mvp.vehicle_cluster_energy_inputs_v1 AS input
    ON input.vehicle_cluster_id = current_result.vehicle_cluster_id
  LEFT JOIN mvp.vehicle_profiles AS profile
    ON profile.id = current_result.vehicle_profile_id
), matched AS (
  SELECT
    version.model_catalog_id,
    version.brand,
    version.model,
    version.version_label,
    version.display_variant_id,
    version.vehicle_cluster_id,
    version.fuel_type,
    version.hybrid_type,
    version.year_from,
    version.year_to,
    version.matched_power_kw,
    source.historical_version_id,
    source.representative_year,
    source.power_kw AS source_power_kw,
    source.consumption_l_100km,
    source.electric_consumption_kwh_100km,
    source.registrations_count,
    source.source_records_count,
    source.energy_method,
    source.confidence AS source_confidence
  FROM weak_version AS version
  JOIN mvp.eea_historical_versions_compact_v1 AS source
    ON lower(source.brand) = lower(version.brand)
   AND lower(source.model) = lower(version.model)
   AND source.fuel_type = version.fuel_type
   AND source.hybrid_type = version.hybrid_type
   AND abs(source.power_kw - version.matched_power_kw) <= 1.0
   AND source.representative_year
     BETWEEN version.year_from AND version.year_to
   AND source.confidence IN ('high', 'medium')
  WHERE version.current_confidence IN (
      'medium_low', 'semiauto_low', 'low', 'missing'
    )
    AND version.payload ->> '_audit_error' IS NULL
    AND version.payload #>> '{quality,status}' = 'ready'
    AND version.year_from IS NOT NULL
    AND version.year_to IS NOT NULL
    AND version.matched_power_kw IS NOT NULL
), aggregated AS (
  SELECT
    model_catalog_id,
    brand,
    model,
    version_label,
    display_variant_id,
    vehicle_cluster_id,
    fuel_type,
    hybrid_type,
    year_from,
    year_to,
    matched_power_kw,
    round(
      sum(
        consumption_l_100km * registrations_count
      ) FILTER (WHERE consumption_l_100km > 0)
      / nullif(
        sum(registrations_count) FILTER (
          WHERE consumption_l_100km > 0
        ),
        0
      ),
      3
    ) AS thermal_consumption_per_100km,
    round(
      sum(
        electric_consumption_kwh_100km * registrations_count
      ) FILTER (WHERE electric_consumption_kwh_100km > 0)
      / nullif(
        sum(registrations_count) FILTER (
          WHERE electric_consumption_kwh_100km > 0
        ),
        0
      ),
      3
    ) AS electric_consumption_kwh_100km,
    min(representative_year) AS source_year_from,
    max(representative_year) AS source_year_to,
    count(DISTINCT historical_version_id)::integer AS source_groups,
    sum(source_records_count)::integer AS source_records,
    sum(registrations_count)::bigint AS registrations_count,
    array_agg(
      DISTINCT energy_method ORDER BY energy_method
    ) AS source_methods
  FROM matched
  GROUP BY
    model_catalog_id,
    brand,
    model,
    version_label,
    display_variant_id,
    vehicle_cluster_id,
    fuel_type,
    hybrid_type,
    year_from,
    year_to,
    matched_power_kw
)
SELECT *
FROM aggregated
WHERE registrations_count >= 3
  AND source_records > 0
  AND (
    (
      hybrid_type = 'plug_in_hybrid'
      AND thermal_consumption_per_100km > 0
      AND electric_consumption_kwh_100km > 0
    )
    OR (
      fuel_type = 'electric'
      AND electric_consumption_kwh_100km > 0
    )
    OR (
      fuel_type <> 'electric'
      AND hybrid_type <> 'plug_in_hybrid'
      AND thermal_consumption_per_100km > 0
    )
  );

CREATE UNIQUE INDEX ON public_energy_candidates_v1 (
  display_variant_id,
  vehicle_cluster_id
);
ANALYZE public_energy_candidates_v1;

INSERT INTO mvp.residual_eea_variant_energy_v1 (
  display_variant_id,
  vehicle_cluster_id,
  model_catalog_id,
  brand,
  model,
  year_from,
  year_to,
  fuel_type,
  hybrid_type,
  matched_power_kw,
  thermal_consumption_per_100km,
  electric_consumption_kwh_100km,
  source_year_from,
  source_year_to,
  source_groups,
  source_records,
  registrations_count,
  source_methods,
  method,
  confidence,
  source_name,
  source_url,
  built_at
)
SELECT
  display_variant_id,
  vehicle_cluster_id,
  model_catalog_id,
  brand,
  model,
  year_from,
  year_to,
  fuel_type,
  hybrid_type,
  matched_power_kw,
  thermal_consumption_per_100km,
  electric_consumption_kwh_100km,
  source_year_from,
  source_year_to,
  source_groups,
  source_records,
  registrations_count,
  source_methods,
  'eea_same_model_power_year_range_weighted_v1',
  'medium',
  'European Environment Agency - CO2 monitoring for cars',
  'https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b',
  now()
FROM public_energy_candidates_v1;

CREATE INDEX IF NOT EXISTS idx_residual_eea_energy_model_v1
ON mvp.residual_eea_variant_energy_v1 (
  brand,
  model,
  year_from,
  year_to
);

ANALYZE mvp.residual_eea_variant_energy_v1;

DO $block$
BEGIN
  IF to_regprocedure(
    'mvp.auto_tco_estimate_variant_before_residual_eea_v1(text,text,integer,integer,text)'
  ) IS NULL THEN
    IF to_regprocedure(
      'public.auto_tco_estimate_variant(text,text,integer,integer,text)'
    ) IS NULL THEN
      RAISE EXCEPTION
        'Funzione public.auto_tco_estimate_variant non disponibile';
    END IF;

    EXECUTE
      'ALTER FUNCTION public.auto_tco_estimate_variant(text,text,integer,integer,text) '
      'RENAME TO auto_tco_estimate_variant_before_residual_eea_v1';
    EXECUTE
      'ALTER FUNCTION public.auto_tco_estimate_variant_before_residual_eea_v1(text,text,integer,integer,text) '
      'SET SCHEMA mvp';
  END IF;
END;
$block$;

REVOKE ALL ON FUNCTION
  mvp.auto_tco_estimate_variant_before_residual_eea_v1(
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
  v_energy mvp.residual_eea_variant_energy_v1%ROWTYPE;
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
  v_result := mvp.auto_tco_estimate_variant_before_residual_eea_v1(
    p_vehicle_cluster_id,
    p_display_variant_id,
    p_annual_km,
    p_ownership_years,
    p_region_code
  );

  SELECT energy.*
  INTO v_energy
  FROM mvp.residual_eea_variant_energy_v1 AS energy
  WHERE energy.display_variant_id = trim(p_display_variant_id)
    AND energy.vehicle_cluster_id = trim(p_vehicle_cluster_id);

  IF NOT FOUND THEN
    RETURN v_result;
  END IF;

  v_old_cost := nullif(
    v_result #>> '{monthly_costs,fuel_or_energy_eur}',
    ''
  )::numeric;
  v_fuel_price := nullif(
    v_result #>>
      '{calculation_details,fuel_or_energy,thermal_price_eur}',
    ''
  )::numeric;
  v_electricity_price := nullif(
    v_result #>>
      '{calculation_details,fuel_or_energy,electricity_price_eur_kwh}',
    ''
  )::numeric;

  IF v_old_cost IS NULL
    OR (
      v_energy.thermal_consumption_per_100km IS NOT NULL
      AND v_fuel_price IS NULL
    )
    OR (
      v_energy.electric_consumption_kwh_100km IS NOT NULL
      AND v_electricity_price IS NULL
    )
  THEN
    RETURN v_result;
  END IF;

  v_new_cost := round(
    p_annual_km::numeric / 100
      * (
        coalesce(
          v_energy.thermal_consumption_per_100km * v_fuel_price,
          0
        )
        + coalesce(
          v_energy.electric_consumption_kwh_100km
            * v_electricity_price,
          0
        )
      )
      / 12,
    2
  );
  v_delta := v_new_cost - v_old_cost;

  v_subtotal := CASE
    WHEN v_result #>> '{monthly_costs,available_subtotal_eur}' IS NULL
      THEN NULL
    ELSE round(
      (v_result #>>
        '{monthly_costs,available_subtotal_eur}')::numeric + v_delta,
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
    'method', v_energy.method,
    'energy_confidence', v_energy.confidence,
    'thermal_consumption_per_100km',
      v_energy.thermal_consumption_per_100km,
    'electric_consumption_kwh_100km',
      v_energy.electric_consumption_kwh_100km,
    'base_monthly_energy_cost_eur', v_old_cost,
    'resolved_monthly_energy_cost_eur', v_new_cost,
    'source_name', v_energy.source_name,
    'source_urls', jsonb_build_array(v_energy.source_url),
    'source_year_from', v_energy.source_year_from,
    'source_year_to', v_energy.source_year_to,
    'source_groups', v_energy.source_groups,
    'source_records', v_energy.source_records,
    'registrations_count', v_energy.registrations_count,
    'source_methods', to_jsonb(v_energy.source_methods)
  ));

  v_result := jsonb_set(
    v_result,
    '{calculation_details,fuel_or_energy}',
    v_energy_details,
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,energy_source_method}',
    to_jsonb(v_energy.method),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,energy_source_confidence}',
    to_jsonb(v_energy.confidence),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{descriptions,fuel_or_energy}',
    to_jsonb(
      'Costo calcolato da chilometri annui, prezzo medio utilizzato e consumi EEA osservati su auto dello stesso modello, alimentazione, potenza e periodo.'::text
    ),
    true
  );

  SELECT coalesce(jsonb_agg(assumption.value), '[]'::jsonb)
  INTO v_assumptions
  FROM jsonb_array_elements_text(
    coalesce(v_result -> 'assumptions', '[]'::jsonb)
  ) AS assumption(value)
  WHERE assumption.value NOT IN (
    'Il consumo mancante nella singola osservazione e stato ricostruito usando registrazioni EEA dello stesso modello.',
    'Il consumo mancante nella singola osservazione e stato stimato usando registrazioni EEA tecnicamente comparabili.'
  );

  v_assumptions := coalesce(v_assumptions, '[]'::jsonb)
    || jsonb_build_array(
      'Il consumo e una media ponderata delle immatricolazioni EEA dello stesso modello, alimentazione e potenza negli anni compresi nella versione selezionata.'
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
'Calcola il TCO e applica, alle sole versioni risolte, consumi EEA dello stesso modello, alimentazione, potenza e intervallo temporale.';

REVOKE ALL ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) FROM PUBLIC, authenticated;
GRANT EXECUTE ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) TO anon;

NOTIFY pgrst, 'reload schema';

CREATE TEMP TABLE residual_eea_energy_checks_v1
ON COMMIT DROP
AS
SELECT
  energy.*,
  mvp.auto_tco_estimate_variant_before_residual_eea_v1(
    energy.vehicle_cluster_id,
    energy.display_variant_id,
    15000,
    5,
    'italia'
  ) AS old_result,
  public.auto_tco_estimate_variant(
    energy.vehicle_cluster_id,
    energy.display_variant_id,
    15000,
    5,
    'italia'
  ) AS new_result
FROM mvp.residual_eea_variant_energy_v1 AS energy;

CREATE INDEX ON residual_eea_energy_checks_v1 (brand, model);
ANALYZE residual_eea_energy_checks_v1;

DO $verification$
DECLARE
  v_resolved integer;
  v_not_ready integer;
  v_wrong_method integer;
  v_invalid_cost integer;
  v_other_component_changes integer;
  v_private_read boolean;
BEGIN
  SELECT
    count(*),
    count(*) FILTER (
      WHERE new_result #>> '{quality,status}' IS DISTINCT FROM 'ready'
    ),
    count(*) FILTER (
      WHERE new_result #>>
        '{calculation_details,fuel_or_energy,method}'
        IS DISTINCT FROM method
        OR new_result #>> '{quality,energy_source_confidence}'
          IS DISTINCT FROM 'medium'
    ),
    count(*) FILTER (
      WHERE nullif(
        new_result #>> '{monthly_costs,fuel_or_energy_eur}',
        ''
      )::numeric NOT BETWEEN 0.01 AND 800
    ),
    count(*) FILTER (
      WHERE old_result #>> '{monthly_costs,depreciation_eur}'
          IS DISTINCT FROM
            new_result #>> '{monthly_costs,depreciation_eur}'
        OR old_result #>> '{monthly_costs,tax_eur}'
          IS DISTINCT FROM new_result #>> '{monthly_costs,tax_eur}'
        OR old_result #>> '{monthly_costs,insurance_eur}'
          IS DISTINCT FROM new_result #>> '{monthly_costs,insurance_eur}'
        OR old_result #>> '{monthly_costs,maintenance_eur}'
          IS DISTINCT FROM new_result #>> '{monthly_costs,maintenance_eur}'
    )
  INTO
    v_resolved,
    v_not_ready,
    v_wrong_method,
    v_invalid_cost,
    v_other_component_changes
  FROM residual_eea_energy_checks_v1;

  v_private_read := has_table_privilege(
    'anon',
    'mvp.residual_eea_variant_energy_v1',
    'SELECT'
  );

  IF v_resolved < 40
    OR v_resolved > 78
    OR v_not_ready <> 0
    OR v_wrong_method <> 0
    OR v_invalid_cost <> 0
    OR v_other_component_changes <> 0
    OR v_private_read
  THEN
    RAISE EXCEPTION
      'Verifica fallita: risolte %, non ready %, metodo errato %, costi invalidi %, altre componenti cambiate %, tabella leggibile %',
      v_resolved,
      v_not_ready,
      v_wrong_method,
      v_invalid_cost,
      v_other_component_changes,
      v_private_read;
  END IF;
END;
$verification$;

SELECT
  count(*) AS versioni_migliorate,
  count(*) FILTER (
    WHERE thermal_consumption_per_100km IS NOT NULL
      AND electric_consumption_kwh_100km IS NULL
  ) AS versioni_termiche,
  count(*) FILTER (
    WHERE thermal_consumption_per_100km IS NULL
      AND electric_consumption_kwh_100km IS NOT NULL
  ) AS versioni_elettriche,
  count(*) FILTER (
    WHERE thermal_consumption_per_100km IS NOT NULL
      AND electric_consumption_kwh_100km IS NOT NULL
  ) AS versioni_plugin,
  sum(source_records) AS record_sorgente,
  sum(registrations_count) AS immatricolazioni_rappresentate,
  round(avg(abs(
    (new_result #>> '{monthly_costs,fuel_or_energy_eur}')::numeric
      - (old_result #>> '{monthly_costs,fuel_or_energy_eur}')::numeric
  )), 2) AS variazione_media_assoluta_mese,
  max(abs(
    (new_result #>> '{monthly_costs,fuel_or_energy_eur}')::numeric
      - (old_result #>> '{monthly_costs,fuel_or_energy_eur}')::numeric
  )) AS variazione_massima_assoluta_mese,
  NOT has_table_privilege(
    'anon',
    'mvp.residual_eea_variant_energy_v1',
    'SELECT'
  ) AS dati_privati_protetti,
  'ok' AS verifica
FROM residual_eea_energy_checks_v1;

COMMIT;
