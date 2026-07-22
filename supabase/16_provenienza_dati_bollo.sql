-- Auto TCO - provenienza degli attributi fiscali e nota sulle regole future.
--
-- Non modifica i dati originali e non inventa un anno di modello:
-- * per i cluster EEA correnti, il 2025 e l'anno della coorte di nuove
--   immatricolazioni coperta dal dataset EEA 2025;
-- * Euro 6 e diretto solo quando confermato da un profilo tecnico recente;
--   negli altri casi e una derivazione normativa dichiarata;
-- * per i profili storici restano validi anno ed Euro gia presenti nel DB.

BEGIN;

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
  v_profile_id integer;
  v_result jsonb;
  v_energy record;
  v_tax record;
  v_energy_details jsonb;
  v_tax_details jsonb;
  v_thermal_unit text;
  v_region_code text;
  v_direct_euro integer;
BEGIN
  IF p_vehicle_cluster_id IS NULL
    OR length(trim(p_vehicle_cluster_id)) NOT BETWEEN 1 AND 64
  THEN
    RAISE EXCEPTION 'Versione non valida' USING ERRCODE = '22023';
  END IF;

  IF p_annual_km NOT BETWEEN 1000 AND 100000 THEN
    RAISE EXCEPTION 'Chilometri annui non validi' USING ERRCODE = '22023';
  END IF;

  IF p_ownership_years NOT BETWEEN 1 AND 10 THEN
    RAISE EXCEPTION 'Anni di possesso non validi' USING ERRCODE = '22023';
  END IF;

  IF p_region_code IS NULL
    OR length(trim(p_region_code)) NOT BETWEEN 1 AND 60
  THEN
    RAISE EXCEPTION 'Area non valida' USING ERRCODE = '22023';
  END IF;

  v_region_code := lower(trim(p_region_code));

  IF trim(p_vehicle_cluster_id) ~ '^profile:[0-9]{1,10}$' THEN
    v_profile_id := substring(trim(p_vehicle_cluster_id) FROM 9)::integer;

    IF NOT EXISTS (
      SELECT 1
      FROM mvp.site_vehicle_catalog_unified_v1 AS catalog
      WHERE catalog.vehicle_cluster_id = trim(p_vehicle_cluster_id)
        AND catalog.source_kind = 'original_historical_profile'
    ) THEN
      RAISE EXCEPTION 'Versione non disponibile' USING ERRCODE = '22023';
    END IF;

    v_result := mvp.estimate_vehicle_tco_ui_v4(
      v_profile_id,
      p_annual_km,
      p_ownership_years,
      v_region_code,
      CURRENT_DATE
    );

    SELECT * INTO v_energy
    FROM mvp.estimate_vehicle_energy_v1(
      v_profile_id,
      p_annual_km,
      v_region_code,
      CURRENT_DATE
    );

    SELECT * INTO v_tax
    FROM mvp.estimate_vehicle_tax_v1(
      v_profile_id,
      v_region_code,
      CURRENT_DATE
    );

    v_thermal_unit := CASE
      WHEN v_energy.fuel_type IN ('ng', 'hydrogen') THEN '€/kg'
      ELSE '€/l'
    END;

    v_tax_details := jsonb_strip_nulls(jsonb_build_object(
      'registration_year', v_tax.representative_year,
      'registration_year_source', 'Profilo storico del database',
      'euro_class', v_tax.euro_class,
      'euro_class_source', 'Profilo tecnico del database',
      'taxable_kw', v_tax.taxable_kw,
      'region_code', v_tax.region_code,
      'calculation_mode', 'Regole vigenti applicate al bollo annuo corrente',
      'future_law_note',
        'La stima non prevede eventuali modifiche legislative future.'
    ));
  ELSE
    IF NOT EXISTS (
      SELECT 1
      FROM mvp.site_vehicle_catalog_eea_v2
      WHERE vehicle_cluster_id = trim(p_vehicle_cluster_id)
    ) THEN
      RAISE EXCEPTION 'Versione non disponibile' USING ERRCODE = '22023';
    END IF;

    v_result := mvp.estimate_vehicle_cluster_tco_ui_v2(
      trim(p_vehicle_cluster_id),
      p_annual_km,
      p_ownership_years,
      v_region_code,
      CURRENT_DATE
    );

    SELECT * INTO v_energy
    FROM mvp.estimate_vehicle_cluster_energy_v1(
      trim(p_vehicle_cluster_id),
      p_annual_km,
      v_region_code,
      CURRENT_DATE
    );

    SELECT * INTO v_tax
    FROM mvp.estimate_vehicle_cluster_tax_ownership_v1(
      trim(p_vehicle_cluster_id),
      v_region_code,
      p_ownership_years,
      CURRENT_DATE
    );

    SELECT CASE
      WHEN profile.profile_kind = 'recent_wltp_2025'
        AND profile.representative_year = 2025
        AND profile.euro_class BETWEEN 0 AND 6
      THEN profile.euro_class
    END
    INTO v_direct_euro
    FROM mvp.site_vehicle_catalog_eea_v2 AS catalog
    LEFT JOIN mvp.vehicle_profiles AS profile
      ON profile.id = catalog.vehicle_profile_id
    WHERE catalog.vehicle_cluster_id = trim(p_vehicle_cluster_id);

    SELECT CASE
      WHEN catalog.fuel_type IN ('ng', 'hydrogen') THEN '€/kg'
      ELSE '€/l'
    END
    INTO v_thermal_unit
    FROM mvp.site_vehicle_catalog_eea_v2 AS catalog
    WHERE catalog.vehicle_cluster_id = trim(p_vehicle_cluster_id);

    v_tax_details := jsonb_strip_nulls(jsonb_build_object(
      'registration_year', 2025,
      'registration_year_source',
        'EEA 2025, coorte di autovetture nuove immatricolate nel 2025',
      'euro_class', v_tax.assumed_euro_class,
      'euro_class_source', CASE
        WHEN v_direct_euro = v_tax.assumed_euro_class
          THEN 'Profilo tecnico recente collegato alla versione'
        ELSE 'Derivata dall''anno di nuova immatricolazione secondo il Regolamento (CE) 715/2007'
      END,
      'taxable_kw', v_tax.taxable_kw,
      'region_code', v_tax.region_code,
      'tax_free_years', v_tax.tax_free_years,
      'taxed_years', v_tax.taxed_years,
      'calculation_mode',
        'Regole oggi vigenti mantenute costanti nel periodo selezionato',
      'future_law_note',
        'La stima non prevede eventuali modifiche legislative future.'
    ));
  END IF;

  v_energy_details := jsonb_strip_nulls(jsonb_build_object(
    'thermal_price_eur', v_energy.fuel_price_eur,
    'thermal_price_unit', v_thermal_unit,
    'thermal_price_area', v_region_code,
    'thermal_price_source',
      CASE WHEN v_energy.fuel_price_eur IS NOT NULL
        THEN 'MIMIT, media ultimi 12 mesi disponibili'
      END,
    'electricity_price_eur_kwh', v_energy.electricity_price_eur_kwh,
    'electricity_price_area',
      CASE WHEN v_energy.electricity_price_eur_kwh IS NOT NULL
        THEN 'italia'
      END,
    'electricity_price_source',
      CASE WHEN v_energy.electricity_price_eur_kwh IS NOT NULL
        THEN 'ARERA, prezzo finale medio domestico 2025 classe DC'
      END,
    'thermal_consumption_per_100km',
      COALESCE(
        to_jsonb(v_energy)->'thermal_consumption_l_100km',
        to_jsonb(v_energy)->'thermal_consumption_per_100km'
      ),
    'electric_consumption_kwh_100km',
      to_jsonb(v_energy)->'electric_consumption_kwh_100km',
    'thermal_km', v_energy.thermal_km,
    'electric_km', v_energy.electric_km
  ));

  v_result := v_result || jsonb_build_object(
    'calculation_details', jsonb_build_object(
      'fuel_or_energy', v_energy_details,
      'tax', v_tax_details
    )
  );

  v_result := jsonb_set(
    v_result,
    '{descriptions,fuel_or_energy}',
    to_jsonb(
      'Costo calcolato da chilometri annui, consumo della versione e prezzo medio utilizzato.'::text
    ),
    true
  );

  v_result := jsonb_set(
    v_result,
    '{descriptions,tax}',
    to_jsonb(
      'Bollo stimato con le regole fiscali oggi disponibili; eventuali modifiche legislative future non sono prevedibili.'::text
    ),
    true
  );

  RETURN v_result;
END;
$function$;

REVOKE ALL ON FUNCTION public.auto_tco_estimate(
  text, integer, integer, text
) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.auto_tco_estimate(
  text, integer, integer, text
) FROM anon;
GRANT EXECUTE ON FUNCTION public.auto_tco_estimate(
  text, integer, integer, text
) TO anon;

COMMIT;

NOTIFY pgrst, 'reload schema';

-- Verifica inclusa: una sola riga, deve terminare con "ok".
CREATE TEMP TABLE auto_tco_migration_16_check AS
WITH current_sample AS (
  SELECT vehicle_cluster_id
  FROM mvp.site_vehicle_catalog_eea_v2
  WHERE power_kw IS NOT NULL
  ORDER BY registrations_count DESC, vehicle_cluster_id
  LIMIT 1
), historical_sample AS (
  SELECT vehicle_cluster_id
  FROM mvp.site_vehicle_catalog_unified_v1
  WHERE source_kind = 'original_historical_profile'
  ORDER BY registrations_count DESC, vehicle_cluster_id
  LIMIT 1
), results AS (
  SELECT
    public.auto_tco_estimate(
      current_sample.vehicle_cluster_id, 15000, 5, 'italia'
    ) AS current_result,
    CASE WHEN historical_sample.vehicle_cluster_id IS NOT NULL THEN
      public.auto_tco_estimate(
        historical_sample.vehicle_cluster_id, 15000, 5, 'italia'
      )
    END AS historical_result
  FROM current_sample
  LEFT JOIN historical_sample ON true
)
SELECT
  current_result #>> '{calculation_details,tax,registration_year}'
    AS anno_corrente,
  current_result #>> '{calculation_details,tax,registration_year_source}'
    AS fonte_anno_corrente,
  current_result #>> '{calculation_details,tax,euro_class}'
    AS euro_corrente,
  current_result #>> '{calculation_details,tax,euro_class_source}'
    AS fonte_euro_corrente,
  historical_result #>> '{calculation_details,tax,registration_year}'
    AS anno_storico,
  CASE
    WHEN current_result #>> '{calculation_details,tax,registration_year}' = '2025'
      AND current_result #>> '{calculation_details,tax,euro_class}' = '6'
      AND current_result #>> '{calculation_details,tax,registration_year_source}'
        LIKE 'EEA 2025%'
      AND current_result #>> '{descriptions,tax}' LIKE '%modifiche legislative future%'
      AND (
        historical_result IS NULL
        OR historical_result #>> '{calculation_details,tax,registration_year}' IS NOT NULL
      )
    THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM results;

DO $verify$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM auto_tco_migration_16_check
    WHERE verifica = 'ok'
  ) THEN
    RAISE EXCEPTION 'Verifica provenienza dati bollo fallita';
  END IF;
END;
$verify$;

TABLE auto_tco_migration_16_check;

DROP TABLE auto_tco_migration_16_check;
