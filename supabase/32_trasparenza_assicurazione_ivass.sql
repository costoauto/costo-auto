\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - trasparenza della stima RC Auto.
--
-- L'importo non viene modificato: resta il premio medio territoriale IVASS
-- piu recente disponibile, diviso per dodici. La API espone periodo, area,
-- numerosita, dispersione e assenza di correzioni per modello/conducente.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

DO $block$
BEGIN
  IF to_regprocedure(
    'mvp.auto_tco_estimate_before_insurance_details_v1(text,integer,integer,text)'
  ) IS NULL THEN
    IF to_regprocedure(
      'public.auto_tco_estimate(text,integer,integer,text)'
    ) IS NULL THEN
      RAISE EXCEPTION 'Funzione public.auto_tco_estimate non disponibile';
    END IF;

    EXECUTE
      'ALTER FUNCTION public.auto_tco_estimate(text, integer, integer, text) '
      'RENAME TO auto_tco_estimate_before_insurance_details_v1';
    EXECUTE
      'ALTER FUNCTION public.auto_tco_estimate_before_insurance_details_v1(text, integer, integer, text) '
      'SET SCHEMA mvp';
  END IF;
END;
$block$;

REVOKE ALL ON FUNCTION
  mvp.auto_tco_estimate_before_insurance_details_v1(
    text, integer, integer, text
  )
FROM PUBLIC, anon, authenticated;

CREATE OR REPLACE FUNCTION public.auto_tco_estimate(
  p_vehicle_cluster_id text,
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
  v_insurance record;
  v_insurance_details jsonb;
  v_region_code text;
  v_period_label text;
BEGIN
  v_result := mvp.auto_tco_estimate_before_insurance_details_v1(
    p_vehicle_cluster_id,
    p_annual_km,
    p_ownership_years,
    p_region_code
  );

  v_region_code := lower(trim(p_region_code));

  SELECT * INTO v_insurance
  FROM mvp.estimate_vehicle_insurance_v1(
    v_region_code,
    CURRENT_DATE
  );

  v_period_label := CASE extract(quarter FROM v_insurance.reference_period_end)::integer
    WHEN 1 THEN 'I trimestre '
    WHEN 2 THEN 'II trimestre '
    WHEN 3 THEN 'III trimestre '
    ELSE 'IV trimestre '
  END || extract(year FROM v_insurance.reference_period_end)::integer::text;

  v_insurance_details := jsonb_strip_nulls(jsonb_build_object(
    'method', 'ivass_latest_territorial_average_v1',
    'area_code', v_insurance.region_code,
    'area_name', v_insurance.region_name,
    'source_area_code', v_insurance.source_region_code,
    'territorial_granularity',
      CASE
        WHEN v_insurance.source_region_code = 'italia' THEN 'national'
        WHEN v_insurance.source_region_code <> v_insurance.region_code
          THEN 'combined_region'
        ELSE 'region'
      END,
    'reference_period_start', v_insurance.reference_period_start,
    'reference_period_end', v_insurance.reference_period_end,
    'reference_period_label', v_period_label,
    'annual_average_premium_eur', v_insurance.annual_premium_eur,
    'monthly_average_premium_eur', v_insurance.monthly_premium_eur,
    'coefficient_variation_pct',
      v_insurance.coefficient_variation_pct,
    'contracts_count', v_insurance.contracts_count,
    'vehicle_specific_adjustment_applied',
      v_insurance.model_adjustment_applied,
    'driver_specific_adjustment_applied', false,
    'calculation_status', v_insurance.calculation_status,
    'confidence', v_insurance.confidence,
    'source_name', 'IVASS - Indagine IPER',
    'sources', to_jsonb(v_insurance.sources),
    'scope_note',
      'Media territoriale dei premi RC Auto effettivamente pagati; non è un preventivo personale né una stima specifica del modello.'
  ));

  v_result := jsonb_set(
    v_result,
    '{calculation_details,insurance}',
    v_insurance_details,
    true
  );
  v_result := jsonb_set(
    v_result,
    '{descriptions,insurance}',
    to_jsonb(
      'Media dei premi RC Auto effettivamente pagati nell''area selezionata; non è un preventivo personale né una stima specifica del modello.'::text
    ),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,insurance_method}',
    to_jsonb('ivass_latest_territorial_average'::text),
    true
  );

  RETURN v_result;
END;
$function$;

COMMENT ON FUNCTION public.auto_tco_estimate(
  text, integer, integer, text
) IS
'Calcola il TCO ed espone periodo, area e fonte della media RC Auto IVASS senza applicare coefficienti arbitrari per veicolo o conducente.';

REVOKE ALL ON FUNCTION public.auto_tco_estimate(
  text, integer, integer, text
) FROM PUBLIC, authenticated;
GRANT EXECUTE ON FUNCTION public.auto_tco_estimate(
  text, integer, integer, text
) TO anon;

NOTIFY pgrst, 'reload schema';

-- Verifica integrata: importi invariati, dettagli presenti anche attraverso
-- l'endpoint variante e motore precedente non accessibile al browser.
DO $block$
DECLARE
  v_vehicle_id text;
  v_old jsonb;
  v_new jsonb;
  v_variant jsonb;
  v_italia record;
  v_campania record;
  v_basilicata record;
BEGIN
  SELECT catalog.vehicle_cluster_id
  INTO v_vehicle_id
  FROM mvp.site_vehicle_catalog_unified_v1 AS catalog
  ORDER BY catalog.registrations_count DESC, catalog.vehicle_cluster_id
  LIMIT 1;

  v_old := mvp.auto_tco_estimate_before_insurance_details_v1(
    v_vehicle_id, 15000, 5, 'italia'
  );
  v_new := public.auto_tco_estimate(
    v_vehicle_id, 15000, 5, 'italia'
  );
  v_variant := public.auto_tco_estimate_variant(
    v_vehicle_id, v_vehicle_id, 15000, 5, 'italia'
  );

  SELECT * INTO v_italia
  FROM mvp.estimate_vehicle_insurance_v1('italia', CURRENT_DATE);
  SELECT * INTO v_campania
  FROM mvp.estimate_vehicle_insurance_v1('campania', CURRENT_DATE);
  SELECT * INTO v_basilicata
  FROM mvp.estimate_vehicle_insurance_v1('basilicata', CURRENT_DATE);

  IF v_old -> 'monthly_costs' <> v_new -> 'monthly_costs'
    OR v_new #>> '{calculation_details,insurance,method}'
      <> 'ivass_latest_territorial_average_v1'
    OR v_variant #>> '{calculation_details,insurance,method}'
      <> 'ivass_latest_territorial_average_v1'
    OR (v_new #>> '{calculation_details,insurance,annual_average_premium_eur}')::numeric
      <> v_italia.annual_premium_eur
    OR (v_new #>> '{calculation_details,insurance,monthly_average_premium_eur}')::numeric
      <> v_italia.monthly_premium_eur
    OR (v_new #>> '{calculation_details,insurance,vehicle_specific_adjustment_applied}')::boolean
    OR (v_new #>> '{calculation_details,insurance,driver_specific_adjustment_applied}')::boolean
    OR v_campania.monthly_premium_eur <= v_basilicata.monthly_premium_eur
    OR has_function_privilege(
      'anon',
      'mvp.auto_tco_estimate_before_insurance_details_v1(text,integer,integer,text)',
      'EXECUTE'
    )
  THEN
    RAISE EXCEPTION 'Verifica trasparenza assicurazione fallita';
  END IF;
END;
$block$;

COMMIT;

WITH sample_vehicle AS (
  SELECT catalog.vehicle_cluster_id
  FROM mvp.site_vehicle_catalog_unified_v1 AS catalog
  ORDER BY catalog.registrations_count DESC, catalog.vehicle_cluster_id
  LIMIT 1
), results AS (
  SELECT
    public.auto_tco_estimate(
      sample_vehicle.vehicle_cluster_id,
      15000,
      5,
      'italia'
    ) AS payload,
    campania.monthly_premium_eur AS campania_mese,
    basilicata.monthly_premium_eur AS basilicata_mese
  FROM sample_vehicle
  CROSS JOIN LATERAL mvp.estimate_vehicle_insurance_v1(
    'campania', CURRENT_DATE
  ) AS campania
  CROSS JOIN LATERAL mvp.estimate_vehicle_insurance_v1(
    'basilicata', CURRENT_DATE
  ) AS basilicata
)
SELECT
  payload #>> '{calculation_details,insurance,reference_period_label}'
    AS periodo_ivass,
  (payload #>> '{calculation_details,insurance,annual_average_premium_eur}')::numeric
    AS premio_italia_annuo,
  (payload #>> '{calculation_details,insurance,monthly_average_premium_eur}')::numeric
    AS premio_italia_mese,
  campania_mese,
  basilicata_mese,
  round(
    campania_mese - basilicata_mese,
    2
  ) AS differenza_regionale_mese,
  payload #>> '{calculation_details,insurance,source_name}'
    AS fonte,
  NOT (
    payload #>> '{calculation_details,insurance,vehicle_specific_adjustment_applied}'
  )::boolean AS nessun_coefficiente_auto_inventato,
  NOT has_function_privilege(
    'anon',
    'mvp.auto_tco_estimate_before_insurance_details_v1(text,integer,integer,text)',
    'EXECUTE'
  ) AS motore_privato_protetto,
  CASE
    WHEN payload #>> '{calculation_details,insurance,method}'
        = 'ivass_latest_territorial_average_v1'
      AND payload #>> '{calculation_details,insurance,source_name}'
        = 'IVASS - Indagine IPER'
      AND campania_mese > basilicata_mese
      AND NOT (
        payload #>> '{calculation_details,insurance,vehicle_specific_adjustment_applied}'
      )::boolean
      AND NOT has_function_privilege(
        'anon',
        'mvp.auto_tco_estimate_before_insurance_details_v1(text,integer,integer,text)',
        'EXECUTE'
      )
    THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM results;
