\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - bollo PHEV calcolato sulla potenza termica verificata.
--
-- Il browser invia l'identificativo pubblico della variante selezionata, ma
-- non puo inviare liberamente i kW da tassare. La RPC risolve nuovamente la
-- variante sul server e accetta l'override solo quando la coppia potenza di
-- sistema / potenza termica e presente nel catalogo pubblico verificato.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

CREATE OR REPLACE FUNCTION mvp.estimate_tax_with_power_v1(
  p_region_code text,
  p_fuel_type text,
  p_hybrid_type text,
  p_registration_year integer,
  p_euro_class integer,
  p_taxable_power_kw numeric,
  p_ownership_years integer,
  p_average_over_ownership boolean,
  p_as_of_date date DEFAULT CURRENT_DATE
)
RETURNS jsonb
LANGUAGE plpgsql
STABLE
SET search_path = pg_catalog, public
AS $function$
DECLARE
  v_jurisdiction mvp.tax_jurisdictions%ROWTYPE;
  v_rate_low mvp.tax_rate_rules%ROWTYPE;
  v_rate_high mvp.tax_rate_rules%ROWTYPE;
  v_exemption mvp.tax_exemption_rules%ROWTYPE;
  v_super mvp.super_tax_rules%ROWTYPE;
  v_kw integer;
  v_year_count integer;
  v_start_age integer;
  v_age integer;
  v_year_offset integer;
  v_ordinary_raw numeric := 0;
  v_reduction numeric := 0;
  v_ordinary numeric := 0;
  v_super_tax numeric := 0;
  v_annual_tax numeric := 0;
  v_total_tax numeric := 0;
  v_tax_free_years integer := 0;
  v_taxed_years integer := 0;
  v_status text := 'complete';
  v_confidence text := 'high';
  v_assumptions text[] := ARRAY[]::text[];
  v_sources text[] := ARRAY[]::text[];
BEGIN
  IF p_as_of_date IS NULL
    OR p_registration_year NOT BETWEEN 1900 AND 2100
    OR p_euro_class NOT BETWEEN 0 AND 6
    OR p_taxable_power_kw IS NULL
    OR p_taxable_power_kw <= 0
    OR p_taxable_power_kw > 2000
    OR p_ownership_years NOT BETWEEN 1 AND 10
  THEN
    RAISE EXCEPTION 'Parametri fiscali non validi' USING ERRCODE = '22023';
  END IF;

  SELECT jurisdiction.*
  INTO v_jurisdiction
  FROM mvp.tax_jurisdictions AS jurisdiction
  WHERE jurisdiction.region_code = lower(btrim(p_region_code));

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Area bollo non supportata: %', p_region_code
      USING ERRCODE = '22023';
  END IF;

  v_kw := floor(p_taxable_power_kw)::integer;
  v_year_count := CASE
    WHEN p_average_over_ownership THEN p_ownership_years
    ELSE 1
  END;
  v_start_age := greatest(
    extract(year FROM p_as_of_date)::integer - p_registration_year,
    0
  );

  SELECT rule.*
  INTO v_rate_low
  FROM mvp.tax_rate_rules AS rule
  WHERE rule.region_code = v_jurisdiction.region_code
    AND rule.kw_from = 0
    AND rule.euro_class_from <= p_euro_class
    AND p_as_of_date BETWEEN rule.valid_from
                         AND coalesce(rule.valid_to, DATE '9999-12-31')
  ORDER BY rule.euro_class_from DESC
  LIMIT 1;

  SELECT rule.*
  INTO v_rate_high
  FROM mvp.tax_rate_rules AS rule
  WHERE rule.region_code = v_jurisdiction.region_code
    AND rule.kw_from = 100
    AND rule.euro_class_from <= p_euro_class
    AND p_as_of_date BETWEEN rule.valid_from
                         AND coalesce(rule.valid_to, DATE '9999-12-31')
  ORDER BY rule.euro_class_from DESC
  LIMIT 1;

  IF v_rate_low.id IS NULL OR v_rate_high.id IS NULL THEN
    RAISE EXCEPTION
      'Tariffa bollo non disponibile per area %, Euro %, data %',
      v_jurisdiction.region_code,
      p_euro_class,
      p_as_of_date;
  END IF;

  v_ordinary_raw := round(
    least(v_kw, 100) * v_rate_low.eur_per_kw
      + greatest(v_kw - 100, 0) * v_rate_high.eur_per_kw,
    2
  );

  FOR v_year_offset IN 0..(v_year_count - 1) LOOP
    v_age := v_start_age + v_year_offset;
    v_reduction := 0;
    v_super_tax := 0;
    v_exemption := NULL;
    v_super := NULL;

    SELECT exemption.*
    INTO v_exemption
    FROM mvp.tax_exemption_rules AS exemption
    WHERE exemption.region_code IN (
        v_jurisdiction.region_code,
        'italia'
      )
      AND exemption.fuel_type = p_fuel_type
      AND (
        exemption.hybrid_type IS NULL
        OR exemption.hybrid_type = p_hybrid_type
      )
      AND v_age >= exemption.vehicle_age_from
      AND (
        exemption.vehicle_age_to IS NULL
        OR v_age <= exemption.vehicle_age_to
      )
      AND (
        exemption.registration_year_from IS NULL
        OR p_registration_year >= exemption.registration_year_from
      )
      AND (
        exemption.registration_year_to IS NULL
        OR p_registration_year <= exemption.registration_year_to
      )
      AND p_as_of_date BETWEEN exemption.valid_from
                           AND coalesce(
                             exemption.valid_to,
                             DATE '9999-12-31'
                           )
    ORDER BY
      CASE
        WHEN exemption.region_code = v_jurisdiction.region_code THEN 0
        ELSE 1
      END,
      exemption.registration_year_from DESC NULLS LAST
    LIMIT 1;

    IF v_exemption.id IS NOT NULL THEN
      v_reduction := v_exemption.reduction_pct;
      v_sources := array_append(v_sources, v_exemption.source_url);
      IF v_exemption.notes IS NOT NULL THEN
        v_assumptions := array_append(v_assumptions, v_exemption.notes);
      END IF;
    END IF;

    v_ordinary := round(
      v_ordinary_raw * (1 - v_reduction / 100),
      2
    );

    SELECT rule.*
    INTO v_super
    FROM mvp.super_tax_rules AS rule
    WHERE v_age >= rule.vehicle_age_from
      AND (rule.vehicle_age_to IS NULL OR v_age <= rule.vehicle_age_to)
      AND p_as_of_date BETWEEN rule.valid_from
                           AND coalesce(rule.valid_to, DATE '9999-12-31')
    ORDER BY rule.vehicle_age_from DESC
    LIMIT 1;

    IF v_super.id IS NOT NULL
      AND v_reduction < 100
      AND v_kw > v_super.kw_threshold
    THEN
      v_super_tax := round(
        (v_kw - v_super.kw_threshold)
          * v_super.eur_per_excess_kw
          * (1 - v_super.reduction_pct / 100),
        2
      );
      v_sources := array_append(v_sources, v_super.source_url);
    END IF;

    v_annual_tax := round(v_ordinary + v_super_tax, 2);
    v_total_tax := v_total_tax + v_annual_tax;

    IF v_annual_tax = 0 THEN
      v_tax_free_years := v_tax_free_years + 1;
    ELSE
      v_taxed_years := v_taxed_years + 1;
    END IF;
  END LOOP;

  v_sources := array_append(v_sources, v_rate_low.source_url);

  IF v_jurisdiction.is_national_estimate THEN
    v_status := 'estimated';
    v_confidence := 'medium';
  ELSIF v_rate_low.rule_quality = 'derived_official'
    OR v_rate_high.rule_quality = 'derived_official'
  THEN
    v_status := 'estimated';
    v_confidence := 'medium_high';
  END IF;

  IF p_fuel_type IN ('petrol/electric', 'diesel/electric') THEN
    v_status := 'partial';
    v_confidence := 'medium_low';
    v_assumptions := array_append(
      v_assumptions,
      'Non sono applicate agevolazioni che richiedono informazioni non presenti nei dati pubblici del veicolo.'
    );
  END IF;

  v_assumptions := array_append(
    v_assumptions,
    'La potenza imponibile della PHEV e la potenza del solo motore termico verificata su una scheda tecnica pubblica.'
  );

  RETURN jsonb_build_object(
    'taxable_kw', v_kw,
    'registration_year', p_registration_year,
    'euro_class', p_euro_class,
    'ordinary_tax_before_reduction_eur', v_ordinary_raw,
    'tax_free_years', v_tax_free_years,
    'taxed_years', v_taxed_years,
    'total_tax_period_eur', round(v_total_tax, 2),
    'average_annual_tax_eur', round(v_total_tax / v_year_count, 2),
    'monthly_tax_eur', round(v_total_tax / (v_year_count * 12), 2),
    'calculation_status', v_status,
    'confidence', v_confidence,
    'assumptions', to_jsonb(v_assumptions),
    'sources', to_jsonb(ARRAY(
      SELECT DISTINCT source_value
      FROM unnest(v_sources) AS source_value
      WHERE source_value IS NOT NULL
    ))
  );
END;
$function$;

COMMENT ON FUNCTION mvp.estimate_tax_with_power_v1(
  text, text, text, integer, integer, numeric,
  integer, boolean, date
) IS
'Applica le regole fiscali esistenti a una potenza imponibile risolta e verificata lato server.';

REVOKE ALL ON FUNCTION mvp.estimate_tax_with_power_v1(
  text, text, text, integer, integer, numeric,
  integer, boolean, date
) FROM PUBLIC, anon, authenticated;

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
  v_model_id text;
  v_variant jsonb;
  v_profile_id integer;
  v_registration_year integer;
  v_euro_class integer;
  v_fuel_type text;
  v_hybrid_type text;
  v_thermal_power_kw numeric;
  v_system_power_kw numeric;
  v_tax jsonb;
  v_tax_details jsonb;
  v_old_tax numeric;
  v_new_tax numeric;
  v_delta numeric;
  v_subtotal numeric;
  v_total numeric;
BEGIN
  v_result := public.auto_tco_estimate(
    p_vehicle_cluster_id,
    p_annual_km,
    p_ownership_years,
    p_region_code
  );

  IF p_display_variant_id IS NULL
    OR trim(p_display_variant_id) = trim(p_vehicle_cluster_id)
  THEN
    RETURN v_result;
  END IF;

  IF length(trim(p_display_variant_id)) NOT BETWEEN 1 AND 180 THEN
    RAISE EXCEPTION 'Versione visualizzata non valida'
      USING ERRCODE = '22023';
  END IF;

  SELECT catalog.model_catalog_id
  INTO v_model_id
  FROM mvp.site_vehicle_catalog_unified_v1 AS catalog
  WHERE catalog.vehicle_cluster_id = trim(p_vehicle_cluster_id)
  ORDER BY catalog.registrations_count DESC
  LIMIT 1;

  IF v_model_id IS NULL THEN
    RAISE EXCEPTION 'Versione non disponibile' USING ERRCODE = '22023';
  END IF;

  SELECT version.item
  INTO v_variant
  FROM jsonb_array_elements(
    public.auto_tco_versions(v_model_id) -> 'items'
  ) AS version(item)
  WHERE version.item ->> 'display_variant_id' = trim(p_display_variant_id)
    AND version.item ->> 'vehicle_cluster_id'
      = trim(p_vehicle_cluster_id)
  LIMIT 1;

  IF v_variant IS NULL THEN
    RAISE EXCEPTION 'Versione visualizzata non disponibile'
      USING ERRCODE = '22023';
  END IF;

  IF v_variant ->> 'hybrid_type' <> 'plug_in_hybrid'
    OR v_variant ->> 'power_data_status' <> 'verified'
    OR v_variant ->> 'thermal_power_kw' IS NULL
  THEN
    RETURN v_result;
  END IF;

  v_thermal_power_kw := (v_variant ->> 'thermal_power_kw')::numeric;
  v_system_power_kw := NULLIF(
    v_variant ->> 'system_power_kw',
    ''
  )::numeric;
  v_fuel_type := v_variant ->> 'fuel_type';
  v_hybrid_type := v_variant ->> 'hybrid_type';
  v_registration_year := NULLIF(
    v_result #>> '{calculation_details,tax,registration_year}',
    ''
  )::integer;
  v_euro_class := NULLIF(
    v_result #>> '{calculation_details,tax,euro_class}',
    ''
  )::integer;

  IF v_registration_year IS NULL OR v_euro_class IS NULL THEN
    RAISE EXCEPTION 'Attributi fiscali della versione non disponibili';
  END IF;

  v_profile_id := CASE
    WHEN trim(p_vehicle_cluster_id) ~ '^profile:[0-9]{1,10}$'
      THEN substring(trim(p_vehicle_cluster_id) FROM 9)::integer
    ELSE NULL
  END;

  v_tax := mvp.estimate_tax_with_power_v1(
    lower(trim(p_region_code)),
    v_fuel_type,
    v_hybrid_type,
    v_registration_year,
    v_euro_class,
    v_thermal_power_kw,
    p_ownership_years,
    v_profile_id IS NULL,
    CURRENT_DATE
  );

  v_old_tax := NULLIF(
    v_result #>> '{monthly_costs,tax_eur}',
    ''
  )::numeric;
  v_new_tax := (v_tax ->> 'monthly_tax_eur')::numeric;

  IF v_old_tax IS NULL OR v_new_tax IS NULL THEN
    RAISE EXCEPTION 'Bollo della versione non disponibile';
  END IF;

  v_delta := v_new_tax - v_old_tax;
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
    '{monthly_costs,tax_eur}',
    to_jsonb(v_new_tax),
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

  v_tax_details := coalesce(
    v_result #> '{calculation_details,tax}',
    '{}'::jsonb
  ) || jsonb_build_object(
    'taxable_kw', (v_tax ->> 'taxable_kw')::integer,
    'taxable_power_basis', 'thermal_engine_power',
    'taxable_power_source',
      'Potenza del motore termico verificata su scheda tecnica pubblica',
    'thermal_power_kw', v_thermal_power_kw,
    'system_power_kw', v_system_power_kw,
    'average_annual_tax_eur',
      (v_tax ->> 'average_annual_tax_eur')::numeric,
    'calculation_status', v_tax ->> 'calculation_status',
    'confidence', v_tax ->> 'confidence',
    'assumptions', v_tax -> 'assumptions',
    'sources', v_tax -> 'sources'
  );

  v_result := jsonb_set(
    v_result,
    '{calculation_details,tax}',
    v_tax_details,
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,components,tax}',
    to_jsonb(v_tax ->> 'calculation_status'),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,confidence,tax}',
    to_jsonb(v_tax ->> 'confidence'),
    true
  );

  RETURN v_result;
END;
$function$;

COMMENT ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) IS
'Calcola il TCO e, per le PHEV verificate, usa la potenza termica della variante selezionata per il bollo.';

REVOKE ALL ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) FROM PUBLIC, authenticated;
GRANT EXECUTE ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) TO anon;

NOTIFY pgrst, 'reload schema';

-- Verifica integrata: potenze termiche PHEV e regressione non PHEV.
DO $block$
DECLARE
  v_model_id text;
  v_variant_204 jsonb;
  v_variant_245 jsonb;
  v_variant_272 jsonb;
  v_non_phev jsonb;
  v_result_204 jsonb;
  v_result_245 jsonb;
  v_result_272 jsonb;
  v_non_phev_base jsonb;
  v_non_phev_variant jsonb;
BEGIN
  SELECT catalog.model_catalog_id
  INTO v_model_id
  FROM mvp.phev_system_power_catalog_v1 AS catalog
  WHERE lower(catalog.brand) = 'cupra'
    AND lower(catalog.model) = 'formentor'
  LIMIT 1;

  SELECT item INTO v_variant_204
  FROM jsonb_array_elements(
    public.auto_tco_versions(v_model_id) -> 'items'
  ) AS version(item)
  WHERE round(NULLIF(item ->> 'system_power_cv', '')::numeric) = 204
    AND round(NULLIF(item ->> 'thermal_power_cv', '')::numeric) = 150
  LIMIT 1;

  SELECT item INTO v_variant_245
  FROM jsonb_array_elements(
    public.auto_tco_versions(v_model_id) -> 'items'
  ) AS version(item)
  WHERE round(NULLIF(item ->> 'system_power_cv', '')::numeric) = 245
    AND round(NULLIF(item ->> 'thermal_power_cv', '')::numeric) = 150
  LIMIT 1;

  SELECT item INTO v_variant_272
  FROM jsonb_array_elements(
    public.auto_tco_versions(v_model_id) -> 'items'
  ) AS version(item)
  WHERE round(NULLIF(item ->> 'system_power_cv', '')::numeric) = 272
    AND round(NULLIF(item ->> 'thermal_power_cv', '')::numeric) = 177
  LIMIT 1;

  SELECT item INTO v_non_phev
  FROM jsonb_array_elements(
    public.auto_tco_versions(v_model_id) -> 'items'
  ) AS version(item)
  WHERE item ->> 'hybrid_type' <> 'plug_in_hybrid'
  LIMIT 1;

  IF v_variant_204 IS NULL
    OR v_variant_245 IS NULL
    OR v_variant_272 IS NULL
    OR v_non_phev IS NULL
  THEN
    RAISE EXCEPTION 'Versioni di verifica non disponibili';
  END IF;

  v_result_204 := public.auto_tco_estimate_variant(
    v_variant_204 ->> 'vehicle_cluster_id',
    v_variant_204 ->> 'display_variant_id',
    15000, 5, 'italia'
  );
  v_result_245 := public.auto_tco_estimate_variant(
    v_variant_245 ->> 'vehicle_cluster_id',
    v_variant_245 ->> 'display_variant_id',
    15000, 5, 'italia'
  );
  v_result_272 := public.auto_tco_estimate_variant(
    v_variant_272 ->> 'vehicle_cluster_id',
    v_variant_272 ->> 'display_variant_id',
    15000, 5, 'italia'
  );
  v_non_phev_base := public.auto_tco_estimate(
    v_non_phev ->> 'vehicle_cluster_id',
    15000, 5, 'italia'
  );
  v_non_phev_variant := public.auto_tco_estimate_variant(
    v_non_phev ->> 'vehicle_cluster_id',
    v_non_phev ->> 'display_variant_id',
    15000, 5, 'italia'
  );

  IF (v_result_204 #>> '{calculation_details,tax,taxable_kw}')::integer
      <> floor((v_variant_204 ->> 'thermal_power_kw')::numeric)::integer
    OR (v_result_245 #>> '{calculation_details,tax,taxable_kw}')::integer
      <> floor((v_variant_245 ->> 'thermal_power_kw')::numeric)::integer
    OR (v_result_272 #>> '{calculation_details,tax,taxable_kw}')::integer
      <> floor((v_variant_272 ->> 'thermal_power_kw')::numeric)::integer
    OR v_result_204 #>> '{monthly_costs,tax_eur}'
      <> v_result_245 #>> '{monthly_costs,tax_eur}'
    OR (v_result_272 #>> '{monthly_costs,tax_eur}')::numeric
      <= (v_result_204 #>> '{monthly_costs,tax_eur}')::numeric
    OR v_result_204 #>> '{calculation_details,tax,taxable_power_basis}'
      <> 'thermal_engine_power'
    OR v_non_phev_base <> v_non_phev_variant
    OR has_function_privilege(
      'anon',
      'mvp.estimate_tax_with_power_v1(text,text,text,integer,integer,numeric,integer,boolean,date)',
      'EXECUTE'
    )
  THEN
    RAISE EXCEPTION 'Verifica bollo PHEV fallita';
  END IF;
END;
$block$;

COMMIT;

SELECT
  (result_204 #>> '{calculation_details,tax,taxable_kw}')::integer
    AS formentor_204_kw_imponibili,
  (result_245 #>> '{calculation_details,tax,taxable_kw}')::integer
    AS formentor_245_kw_imponibili,
  (result_272 #>> '{calculation_details,tax,taxable_kw}')::integer
    AS formentor_272_kw_imponibili,
  (result_204 #>> '{monthly_costs,tax_eur}')::numeric
    AS formentor_204_bollo_mese,
  (result_245 #>> '{monthly_costs,tax_eur}')::numeric
    AS formentor_245_bollo_mese,
  (result_272 #>> '{monthly_costs,tax_eur}')::numeric
    AS formentor_272_bollo_mese,
  NOT has_function_privilege(
    'anon',
    'mvp.estimate_tax_with_power_v1(text,text,text,integer,integer,numeric,integer,boolean,date)',
    'EXECUTE'
  ) AS motore_privato_protetto,
  CASE
    WHEN result_204 #>> '{calculation_details,tax,taxable_power_basis}'
      = 'thermal_engine_power'
      AND result_204 #>> '{monthly_costs,tax_eur}'
        = result_245 #>> '{monthly_costs,tax_eur}'
      AND (result_272 #>> '{monthly_costs,tax_eur}')::numeric
        > (result_204 #>> '{monthly_costs,tax_eur}')::numeric
    THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM (
  SELECT
    public.auto_tco_estimate_variant(
      version_204.item ->> 'vehicle_cluster_id',
      version_204.item ->> 'display_variant_id',
      15000, 5, 'italia'
    ) AS result_204,
    public.auto_tco_estimate_variant(
      version_245.item ->> 'vehicle_cluster_id',
      version_245.item ->> 'display_variant_id',
      15000, 5, 'italia'
    ) AS result_245,
    public.auto_tco_estimate_variant(
      version_272.item ->> 'vehicle_cluster_id',
      version_272.item ->> 'display_variant_id',
      15000, 5, 'italia'
    ) AS result_272
  FROM (
    SELECT model_catalog_id
    FROM mvp.phev_system_power_catalog_v1
    WHERE lower(brand) = 'cupra'
      AND lower(model) = 'formentor'
    LIMIT 1
  ) AS model
  CROSS JOIN LATERAL (
    SELECT item
    FROM jsonb_array_elements(
      public.auto_tco_versions(model.model_catalog_id) -> 'items'
    ) AS version(item)
    WHERE round(NULLIF(item ->> 'system_power_cv', '')::numeric) = 204
      AND round(NULLIF(item ->> 'thermal_power_cv', '')::numeric) = 150
    LIMIT 1
  ) AS version_204
  CROSS JOIN LATERAL (
    SELECT item
    FROM jsonb_array_elements(
      public.auto_tco_versions(model.model_catalog_id) -> 'items'
    ) AS version(item)
    WHERE round(NULLIF(item ->> 'system_power_cv', '')::numeric) = 245
      AND round(NULLIF(item ->> 'thermal_power_cv', '')::numeric) = 150
    LIMIT 1
  ) AS version_245
  CROSS JOIN LATERAL (
    SELECT item
    FROM jsonb_array_elements(
      public.auto_tco_versions(model.model_catalog_id) -> 'items'
    ) AS version(item)
    WHERE round(NULLIF(item ->> 'system_power_cv', '')::numeric) = 272
      AND round(NULLIF(item ->> 'thermal_power_cv', '')::numeric) = 177
    LIMIT 1
  ) AS version_272
) AS checks;
