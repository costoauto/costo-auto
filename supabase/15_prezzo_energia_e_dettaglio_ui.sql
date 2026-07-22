-- Auto TCO - prezzo elettrico pubblico e prezzi energia esposti alla UI.
--
-- ARERA non pubblica un prezzo finale domestico regionale confrontabile con
-- i prezzi carburante MIMIT. I prezzi zonali GME sono prezzi all'ingrosso e
-- non vengono trasformati artificialmente in tariffe regionali al dettaglio.
-- Per l'elettricita viene quindi usato il prezzo finale nazionale 2025 della
-- classe domestica DC (2.500-5.000 kWh/anno), pari a 31,32 cEUR/kWh.

BEGIN;

UPDATE mvp.charging_price_assumptions
SET period_end = DATE '2026-07-21'
WHERE period_end IS NULL
  AND period_start < DATE '2026-07-22';

INSERT INTO mvp.charging_price_assumptions (
  period_start,
  period_end,
  charging_type,
  price_eur_kwh,
  mix_weight,
  source_name,
  source_url,
  source_reference,
  confidence,
  notes
)
VALUES (
  DATE '2026-07-22',
  NULL,
  'home',
  0.3132,
  1.000000,
  'ARERA',
  'https://www.arera.it/fileadmin/allegati/com_stampa/26/Comunicato_stampa_ARERA__I_numeri_della_Relazione_Annuale_2025.pdf',
  'Prezzo finale medio 2025, clienti domestici classe DC 2.500-5.000 kWh/anno',
  'medium_high',
  'Riferimento nazionale comprensivo di imposte e oneri. Non e una tariffa personale e non rappresenta la ricarica pubblica.'
)
ON CONFLICT (period_start, charging_type, source_name) DO UPDATE
SET
  period_end = EXCLUDED.period_end,
  price_eur_kwh = EXCLUDED.price_eur_kwh,
  mix_weight = EXCLUDED.mix_weight,
  source_url = EXCLUDED.source_url,
  source_reference = EXCLUDED.source_reference,
  confidence = EXCLUDED.confidence,
  notes = EXCLUDED.notes;

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
  v_energy_details jsonb;
  v_thermal_unit text;
  v_region_code text;
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

    v_thermal_unit := CASE
      WHEN v_energy.fuel_type = 'ng' THEN '€/kg'
      WHEN v_energy.fuel_type = 'hydrogen' THEN '€/kg'
      ELSE '€/l'
    END;
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

    SELECT CASE
      WHEN catalog.fuel_type IN ('ng', 'hydrogen') THEN '€/kg'
      ELSE '€/l'
    END
    INTO v_thermal_unit
    FROM mvp.site_vehicle_catalog_eea_v2 AS catalog
    WHERE catalog.vehicle_cluster_id = trim(p_vehicle_cluster_id);
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
    'calculation_details',
    jsonb_build_object('fuel_or_energy', v_energy_details)
  );

  v_result := jsonb_set(
    v_result,
    '{descriptions,fuel_or_energy}',
    to_jsonb(
      'Costo calcolato da chilometri annui, consumo della versione e prezzo medio utilizzato.'::text
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

-- Verifica inclusa: interrompe lo script in caso di errore e poi mostra una
-- sola riga che deve terminare con "ok".
CREATE TEMP TABLE auto_tco_migration_15_check AS
WITH samples AS (
  SELECT
    (
      SELECT vehicle_cluster_id
      FROM mvp.site_vehicle_catalog_eea_v2
      WHERE powertrain_type = 'electric'
      ORDER BY registrations_count DESC, vehicle_cluster_id
      LIMIT 1
    ) AS electric_id,
    (
      SELECT vehicle_cluster_id
      FROM mvp.site_vehicle_catalog_eea_v2
      WHERE powertrain_type NOT IN ('electric', 'plug_in_hybrid')
        AND fuel_type IN ('petrol', 'diesel')
      ORDER BY registrations_count DESC, vehicle_cluster_id
      LIMIT 1
    ) AS thermal_id
), results AS (
  SELECT
    public.auto_tco_estimate(
      samples.electric_id, 15000, 5, 'italia'
    ) AS electric_result,
    public.auto_tco_estimate(
      samples.thermal_id, 15000, 5, 'lombardia'
    ) AS thermal_result
  FROM samples
)
SELECT
  (electric_result #>> '{calculation_details,fuel_or_energy,electricity_price_eur_kwh}')::numeric
    AS prezzo_elettrico,
  electric_result #>> '{calculation_details,fuel_or_energy,electricity_price_source}'
    AS fonte_elettricita,
  (thermal_result #>> '{calculation_details,fuel_or_energy,thermal_price_eur}')::numeric
    AS prezzo_carburante,
  thermal_result #>> '{calculation_details,fuel_or_energy,thermal_price_source}'
    AS fonte_carburante,
  CASE
    WHEN (electric_result #>> '{calculation_details,fuel_or_energy,electricity_price_eur_kwh}')::numeric = 0.3132
      AND thermal_result #>> '{calculation_details,fuel_or_energy,thermal_price_eur}' IS NOT NULL
      AND electric_result #>> '{monthly_costs,fuel_or_energy_eur}' IS NOT NULL
      AND thermal_result #>> '{monthly_costs,fuel_or_energy_eur}' IS NOT NULL
    THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM results;

DO $verify$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM auto_tco_migration_15_check
    WHERE verifica = 'ok'
  ) THEN
    RAISE EXCEPTION 'Verifica prezzi energia fallita';
  END IF;
END;
$verify$;

TABLE auto_tco_migration_15_check;

DROP TABLE auto_tco_migration_15_check;
