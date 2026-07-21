-- Auto TCO - completa i consumi mancanti senza sovrascrivere i dati originali.
--
-- Priorita usata:
--   1. consumo EEA della versione;
--   2. consumo del profilo originale collegato;
--   3. mediana dello stesso modello e della stessa alimentazione;
--   4. mediana della stessa marca, alimentazione e fascia di potenza;
--   5. mediana della stessa alimentazione e fascia di potenza;
--   6. mediana generale della stessa alimentazione.
--
-- Le stime restano separate dai valori originali e sono tracciate con metodo,
-- numerosita del campione e livello di affidabilita.

BEGIN;

CREATE TABLE IF NOT EXISTS mvp.vehicle_cluster_energy_inputs_v1 (
    vehicle_cluster_id text PRIMARY KEY,
    thermal_consumption_per_100km numeric,
    electric_consumption_kwh_100km numeric,
    thermal_method text,
    electric_method text,
    thermal_reference_count integer NOT NULL DEFAULT 0,
    electric_reference_count integer NOT NULL DEFAULT 0,
    input_status text NOT NULL,
    confidence text NOT NULL,
    built_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT vehicle_cluster_energy_inputs_status_check
        CHECK (input_status IN ('ready', 'missing')),
    CONSTRAINT vehicle_cluster_energy_inputs_confidence_check
        CHECK (confidence IN ('high', 'medium', 'medium_low', 'low', 'missing'))
);

TRUNCATE TABLE mvp.vehicle_cluster_energy_inputs_v1;

WITH source_values AS MATERIALIZED (
    SELECT
        c.vehicle_cluster_id,
        c.model_catalog_id,
        c.brand,
        c.model,
        c.fuel_type,
        c.powertrain_type,
        c.power_kw,
        CASE
            WHEN c.fuel_type IN ('petrol', 'petrol/electric', 'e85') THEN 'petrol'
            WHEN c.fuel_type IN ('diesel', 'diesel/electric') THEN 'diesel'
            WHEN c.fuel_type = 'lpg' THEN 'lpg'
            WHEN c.fuel_type = 'ng' THEN 'ng'
            WHEN c.fuel_type = 'hydrogen' THEN 'hydrogen'
            ELSE c.fuel_type
        END AS base_energy_type,
        CASE
            WHEN c.powertrain_type = 'plug_in_hybrid' THEN
                NULLIF(vp.phev_thermal_consumption_l_100km, 0)
            ELSE COALESCE(
                NULLIF(c.consumption_l_100km, 0),
                NULLIF(vp.consumption_l_100km, 0)
            )
        END AS thermal_direct,
        CASE
            WHEN c.powertrain_type = 'plug_in_hybrid'
             AND NULLIF(vp.phev_thermal_consumption_l_100km, 0) IS NOT NULL
                THEN 'profile_original'
            WHEN c.powertrain_type <> 'plug_in_hybrid'
             AND NULLIF(c.consumption_l_100km, 0) IS NOT NULL
                THEN 'eea_observed'
            WHEN c.powertrain_type <> 'plug_in_hybrid'
             AND NULLIF(vp.consumption_l_100km, 0) IS NOT NULL
                THEN 'profile_original'
            ELSE NULL
        END AS thermal_direct_method,
        COALESCE(
            NULLIF(c.electric_consumption_kwh_100km, 0),
            NULLIF(vp.electric_consumption_kwh_100km, 0)
        ) AS electric_direct,
        CASE
            WHEN NULLIF(c.electric_consumption_kwh_100km, 0) IS NOT NULL
                THEN 'eea_observed'
            WHEN NULLIF(vp.electric_consumption_kwh_100km, 0) IS NOT NULL
                THEN 'profile_original'
            ELSE NULL
        END AS electric_direct_method
    FROM mvp.site_vehicle_catalog_eea_v2 AS c
    LEFT JOIN mvp.vehicle_profiles AS vp
      ON vp.id = c.vehicle_profile_id
     AND vp.profile_status = 'active'
), peer_statistics AS MATERIALIZED (
    SELECT
        s.*,
        thermal_same_model.value AS thermal_same_model,
        thermal_same_model.reference_count AS thermal_same_model_count,
        thermal_same_brand_power.value AS thermal_same_brand_power,
        thermal_same_brand_power.reference_count AS thermal_same_brand_power_count,
        thermal_same_fuel_power.value AS thermal_same_fuel_power,
        thermal_same_fuel_power.reference_count AS thermal_same_fuel_power_count,
        thermal_same_fuel.value AS thermal_same_fuel,
        thermal_same_fuel.reference_count AS thermal_same_fuel_count,
        electric_same_model.value AS electric_same_model,
        electric_same_model.reference_count AS electric_same_model_count,
        electric_same_brand_power.value AS electric_same_brand_power,
        electric_same_brand_power.reference_count AS electric_same_brand_power_count,
        electric_same_power.value AS electric_same_power,
        electric_same_power.reference_count AS electric_same_power_count,
        electric_all.value AS electric_all,
        electric_all.reference_count AS electric_all_count
    FROM source_values AS s
    LEFT JOIN LATERAL (
        SELECT
            percentile_cont(0.5) WITHIN GROUP (ORDER BY x.thermal_direct)::numeric AS value,
            count(*)::integer AS reference_count
        FROM source_values AS x
        WHERE x.vehicle_cluster_id <> s.vehicle_cluster_id
          AND x.model_catalog_id = s.model_catalog_id
          AND x.base_energy_type = s.base_energy_type
          AND x.thermal_direct IS NOT NULL
    ) AS thermal_same_model ON true
    LEFT JOIN LATERAL (
        SELECT
            percentile_cont(0.5) WITHIN GROUP (ORDER BY x.thermal_direct)::numeric AS value,
            count(*)::integer AS reference_count
        FROM source_values AS x
        WHERE x.vehicle_cluster_id <> s.vehicle_cluster_id
          AND x.brand = s.brand
          AND x.base_energy_type = s.base_energy_type
          AND x.thermal_direct IS NOT NULL
          AND abs(x.power_kw - s.power_kw) <= greatest(10, s.power_kw * 0.20)
    ) AS thermal_same_brand_power ON true
    LEFT JOIN LATERAL (
        SELECT
            percentile_cont(0.5) WITHIN GROUP (ORDER BY x.thermal_direct)::numeric AS value,
            count(*)::integer AS reference_count
        FROM source_values AS x
        WHERE x.vehicle_cluster_id <> s.vehicle_cluster_id
          AND x.base_energy_type = s.base_energy_type
          AND x.thermal_direct IS NOT NULL
          AND abs(x.power_kw - s.power_kw) <= greatest(10, s.power_kw * 0.20)
    ) AS thermal_same_fuel_power ON true
    LEFT JOIN LATERAL (
        SELECT
            percentile_cont(0.5) WITHIN GROUP (ORDER BY x.thermal_direct)::numeric AS value,
            count(*)::integer AS reference_count
        FROM source_values AS x
        WHERE x.vehicle_cluster_id <> s.vehicle_cluster_id
          AND x.base_energy_type = s.base_energy_type
          AND x.thermal_direct IS NOT NULL
    ) AS thermal_same_fuel ON true
    LEFT JOIN LATERAL (
        SELECT
            percentile_cont(0.5) WITHIN GROUP (ORDER BY x.electric_direct)::numeric AS value,
            count(*)::integer AS reference_count
        FROM source_values AS x
        WHERE x.vehicle_cluster_id <> s.vehicle_cluster_id
          AND x.model_catalog_id = s.model_catalog_id
          AND x.powertrain_type = s.powertrain_type
          AND x.electric_direct IS NOT NULL
    ) AS electric_same_model ON true
    LEFT JOIN LATERAL (
        SELECT
            percentile_cont(0.5) WITHIN GROUP (ORDER BY x.electric_direct)::numeric AS value,
            count(*)::integer AS reference_count
        FROM source_values AS x
        WHERE x.vehicle_cluster_id <> s.vehicle_cluster_id
          AND x.brand = s.brand
          AND x.powertrain_type = s.powertrain_type
          AND x.electric_direct IS NOT NULL
          AND abs(x.power_kw - s.power_kw) <= greatest(10, s.power_kw * 0.20)
    ) AS electric_same_brand_power ON true
    LEFT JOIN LATERAL (
        SELECT
            percentile_cont(0.5) WITHIN GROUP (ORDER BY x.electric_direct)::numeric AS value,
            count(*)::integer AS reference_count
        FROM source_values AS x
        WHERE x.vehicle_cluster_id <> s.vehicle_cluster_id
          AND x.powertrain_type = s.powertrain_type
          AND x.electric_direct IS NOT NULL
          AND abs(x.power_kw - s.power_kw) <= greatest(10, s.power_kw * 0.20)
    ) AS electric_same_power ON true
    LEFT JOIN LATERAL (
        SELECT
            percentile_cont(0.5) WITHIN GROUP (ORDER BY x.electric_direct)::numeric AS value,
            count(*)::integer AS reference_count
        FROM source_values AS x
        WHERE x.vehicle_cluster_id <> s.vehicle_cluster_id
          AND x.powertrain_type = s.powertrain_type
          AND x.electric_direct IS NOT NULL
    ) AS electric_all ON true
), resolved AS (
    SELECT
        p.*,
        CASE
            WHEN p.powertrain_type = 'electric' THEN NULL::numeric
            ELSE COALESCE(
                p.thermal_direct,
                p.thermal_same_model,
                p.thermal_same_brand_power,
                p.thermal_same_fuel_power,
                p.thermal_same_fuel
            )
        END AS thermal_resolved,
        CASE
            WHEN p.powertrain_type = 'electric' THEN NULL::text
            WHEN p.thermal_direct IS NOT NULL THEN p.thermal_direct_method
            WHEN p.thermal_same_model IS NOT NULL THEN 'same_model_median'
            WHEN p.thermal_same_brand_power IS NOT NULL THEN 'same_brand_power_median'
            WHEN p.thermal_same_fuel_power IS NOT NULL THEN 'same_fuel_power_median'
            WHEN p.thermal_same_fuel IS NOT NULL THEN 'same_fuel_median'
            ELSE NULL
        END AS thermal_resolved_method,
        CASE
            WHEN p.powertrain_type = 'electric' THEN 0
            WHEN p.thermal_direct IS NOT NULL THEN 1
            WHEN p.thermal_same_model IS NOT NULL THEN p.thermal_same_model_count
            WHEN p.thermal_same_brand_power IS NOT NULL THEN p.thermal_same_brand_power_count
            WHEN p.thermal_same_fuel_power IS NOT NULL THEN p.thermal_same_fuel_power_count
            WHEN p.thermal_same_fuel IS NOT NULL THEN p.thermal_same_fuel_count
            ELSE 0
        END AS thermal_resolved_count,
        CASE
            WHEN p.powertrain_type NOT IN ('electric', 'plug_in_hybrid') THEN NULL::numeric
            ELSE COALESCE(
                p.electric_direct,
                p.electric_same_model,
                p.electric_same_brand_power,
                p.electric_same_power,
                p.electric_all
            )
        END AS electric_resolved,
        CASE
            WHEN p.powertrain_type NOT IN ('electric', 'plug_in_hybrid') THEN NULL::text
            WHEN p.electric_direct IS NOT NULL THEN p.electric_direct_method
            WHEN p.electric_same_model IS NOT NULL THEN 'same_model_median'
            WHEN p.electric_same_brand_power IS NOT NULL THEN 'same_brand_power_median'
            WHEN p.electric_same_power IS NOT NULL THEN 'same_powertrain_power_median'
            WHEN p.electric_all IS NOT NULL THEN 'same_powertrain_median'
            ELSE NULL
        END AS electric_resolved_method,
        CASE
            WHEN p.powertrain_type NOT IN ('electric', 'plug_in_hybrid') THEN 0
            WHEN p.electric_direct IS NOT NULL THEN 1
            WHEN p.electric_same_model IS NOT NULL THEN p.electric_same_model_count
            WHEN p.electric_same_brand_power IS NOT NULL THEN p.electric_same_brand_power_count
            WHEN p.electric_same_power IS NOT NULL THEN p.electric_same_power_count
            WHEN p.electric_all IS NOT NULL THEN p.electric_all_count
            ELSE 0
        END AS electric_resolved_count
    FROM peer_statistics AS p
)
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
    r.vehicle_cluster_id,
    round(r.thermal_resolved, 3),
    round(r.electric_resolved, 3),
    r.thermal_resolved_method,
    r.electric_resolved_method,
    r.thermal_resolved_count,
    r.electric_resolved_count,
    CASE
        WHEN r.powertrain_type = 'electric'
         AND r.electric_resolved IS NOT NULL THEN 'ready'
        WHEN r.powertrain_type = 'plug_in_hybrid'
         AND r.thermal_resolved IS NOT NULL
         AND r.electric_resolved IS NOT NULL THEN 'ready'
        WHEN r.powertrain_type NOT IN ('electric', 'plug_in_hybrid')
         AND r.thermal_resolved IS NOT NULL THEN 'ready'
        ELSE 'missing'
    END,
    CASE
        WHEN (
            r.powertrain_type = 'electric'
            AND r.electric_resolved_method = 'eea_observed'
        ) OR (
            r.powertrain_type NOT IN ('electric', 'plug_in_hybrid')
            AND r.thermal_resolved_method = 'eea_observed'
        ) THEN 'high'
        WHEN coalesce(r.thermal_resolved_method, '') IN ('profile_original', 'same_model_median')
          OR coalesce(r.electric_resolved_method, '') IN ('profile_original', 'same_model_median')
            THEN 'medium'
        WHEN coalesce(r.thermal_resolved_method, '') = 'same_brand_power_median'
          OR coalesce(r.electric_resolved_method, '') = 'same_brand_power_median'
            THEN 'medium_low'
        WHEN r.thermal_resolved IS NOT NULL OR r.electric_resolved IS NOT NULL
            THEN 'low'
        ELSE 'missing'
    END,
    now()
FROM resolved AS r;

COMMENT ON TABLE mvp.vehicle_cluster_energy_inputs_v1 IS
'Consumi risolti per il catalogo sito. I dati EEA e dei profili originali hanno priorita; le sole lacune sono colmate con mediane tecniche tracciate.';

CREATE OR REPLACE FUNCTION mvp.estimate_vehicle_cluster_energy_v1(
    p_vehicle_cluster_id text,
    p_annual_km integer,
    p_region_code text,
    p_as_of_date date DEFAULT CURRENT_DATE
)
RETURNS TABLE (
    vehicle_cluster_id text,
    annual_km integer,
    thermal_km numeric,
    electric_km numeric,
    thermal_consumption_l_100km numeric,
    electric_consumption_kwh_100km numeric,
    fuel_price_eur numeric,
    electricity_price_eur_kwh numeric,
    annual_energy_cost_eur numeric,
    monthly_energy_cost_eur numeric,
    calculation_status text,
    confidence text,
    assumptions text[],
    sources text[]
)
LANGUAGE plpgsql
STABLE
AS $function$
DECLARE
    v_catalog record;
    v_profile mvp.vehicle_profiles%ROWTYPE;
    v_inputs mvp.vehicle_cluster_energy_inputs_v1%ROWTYPE;
    v_region_code text;
    v_canonical_fuel text;
    v_service_mode text;
    v_fuel_price numeric;
    v_electricity_price numeric;
    v_mix_weight numeric;
    v_thermal_share numeric := 1;
    v_electric_share numeric := 0;
    v_thermal_km numeric := 0;
    v_electric_km numeric := 0;
    v_annual_thermal numeric := 0;
    v_annual_electric numeric := 0;
    v_status text := 'complete';
    v_confidence text := 'high';
    v_assumptions text[] := ARRAY[]::text[];
    v_sources text[] := ARRAY[]::text[];
BEGIN
    IF p_annual_km NOT BETWEEN 1000 AND 100000 THEN
        RAISE EXCEPTION 'p_annual_km deve essere compreso tra 1000 e 100000';
    END IF;

    IF p_as_of_date IS NULL THEN
        RAISE EXCEPTION 'p_as_of_date non puo essere NULL';
    END IF;

    v_region_code := lower(btrim(p_region_code));

    IF NOT EXISTS (
        SELECT 1 FROM mvp.tax_jurisdictions AS j
        WHERE j.region_code = v_region_code
    ) THEN
        RAISE EXCEPTION 'Area non supportata: %', p_region_code;
    END IF;

    SELECT * INTO v_catalog
    FROM mvp.site_vehicle_catalog_eea_v2 AS c
    WHERE c.vehicle_cluster_id = p_vehicle_cluster_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Versione EEA non disponibile: %', p_vehicle_cluster_id;
    END IF;

    SELECT * INTO v_inputs
    FROM mvp.vehicle_cluster_energy_inputs_v1 AS i
    WHERE i.vehicle_cluster_id = p_vehicle_cluster_id;

    IF v_catalog.vehicle_profile_id IS NOT NULL THEN
        SELECT * INTO v_profile
        FROM mvp.vehicle_profiles AS vp
        WHERE vp.id = v_catalog.vehicle_profile_id
          AND vp.profile_status = 'active';
    END IF;

    v_canonical_fuel := CASE
        WHEN v_catalog.fuel_type IN ('petrol', 'petrol/electric', 'e85') THEN 'petrol'
        WHEN v_catalog.fuel_type IN ('diesel', 'diesel/electric') THEN 'diesel'
        WHEN v_catalog.fuel_type = 'lpg' THEN 'lpg'
        WHEN v_catalog.fuel_type = 'ng' THEN 'ng'
        WHEN v_catalog.fuel_type = 'hydrogen' THEN 'hydrogen'
        ELSE NULL
    END;

    v_service_mode := CASE
        WHEN v_canonical_fuel IN ('petrol', 'diesel') THEN 'self'
        WHEN v_canonical_fuel IN ('lpg', 'ng') THEN 'served'
        ELSE NULL
    END;

    IF v_canonical_fuel IN ('petrol', 'diesel', 'lpg', 'ng') THEN
        IF v_region_code IN ('bolzano', 'trento') THEN
            SELECT p.average_price_eur INTO v_fuel_price
            FROM mvp.fuel_prices_rolling_12m AS p
            WHERE p.territory_code = v_region_code
              AND p.territory_level = 'autonomous_province'
              AND p.fuel_type = v_canonical_fuel
              AND p.service_mode = v_service_mode
              AND p.period_end <= p_as_of_date
            ORDER BY p.period_end DESC
            LIMIT 1;
        ELSE
            SELECT p.average_price_eur INTO v_fuel_price
            FROM mvp.fuel_prices_site_rolling_12m AS p
            WHERE p.region_code = v_region_code
              AND p.fuel_type = v_canonical_fuel
              AND p.service_mode = v_service_mode
              AND p.period_end <= p_as_of_date
            ORDER BY p.period_end DESC
            LIMIT 1;
        END IF;
    ELSIF v_canonical_fuel = 'hydrogen' THEN
        SELECT p.price_eur INTO v_fuel_price
        FROM mvp.energy_price_assumptions AS p
        WHERE p.fuel_type = 'hydrogen'
        ORDER BY p.updated_at DESC NULLS LAST
        LIMIT 1;
    END IF;

    IF v_catalog.fuel_type = 'e85' THEN
        v_assumptions := array_append(
            v_assumptions,
            'Per E85 viene usato il prezzo pubblico della benzina come riferimento prudenziale, perche non esiste una serie MIMIT E85 equivalente.'
        );
        v_confidence := 'low';
    ELSIF v_catalog.fuel_type = 'hydrogen' THEN
        v_assumptions := array_append(
            v_assumptions,
            'Per l idrogeno viene usata l assunzione di prezzo gia documentata nel database.'
        );
        v_confidence := 'low';
    END IF;

    IF v_catalog.powertrain_type IN ('electric', 'plug_in_hybrid') THEN
        SELECT
            round(sum(c.price_eur_kwh * c.mix_weight) / nullif(sum(c.mix_weight), 0), 4),
            sum(c.mix_weight)
        INTO v_electricity_price, v_mix_weight
        FROM mvp.charging_price_assumptions AS c
        WHERE p_as_of_date BETWEEN c.period_start
                               AND coalesce(c.period_end, DATE '9999-12-31');

        IF v_mix_weight IS NOT NULL AND abs(v_mix_weight - 1) > 0.0001 THEN
            v_electricity_price := NULL;
        END IF;
    END IF;

    IF v_catalog.powertrain_type = 'electric' THEN
        v_thermal_share := 0;
        v_electric_share := 1;
    ELSIF v_catalog.powertrain_type = 'plug_in_hybrid' THEN
        v_electric_share := coalesce(v_profile.phev_electric_share_default, 0.40);
        v_thermal_share := 1 - v_electric_share;
        v_assumptions := array_append(
            v_assumptions,
            format('Per la plug-in viene usata una quota elettrica di percorrenza del %s%%.', round(v_electric_share * 100))
        );
    END IF;

    v_thermal_km := round(p_annual_km * v_thermal_share, 2);
    v_electric_km := round(p_annual_km * v_electric_share, 2);

    IF v_inputs.confidence IN ('medium', 'medium_low', 'low') THEN
        v_confidence := v_inputs.confidence;
    END IF;

    IF coalesce(v_inputs.thermal_method, '') LIKE '%median%' THEN
        v_assumptions := array_append(
            v_assumptions,
            format('Consumo termico stimato con metodo %s su %s riferimenti comparabili.', v_inputs.thermal_method, v_inputs.thermal_reference_count)
        );
    END IF;

    IF coalesce(v_inputs.electric_method, '') LIKE '%median%' THEN
        v_assumptions := array_append(
            v_assumptions,
            format('Consumo elettrico stimato con metodo %s su %s riferimenti comparabili.', v_inputs.electric_method, v_inputs.electric_reference_count)
        );
    END IF;

    IF v_thermal_share > 0
       AND (v_fuel_price IS NULL OR v_inputs.thermal_consumption_per_100km IS NULL) THEN
        v_status := 'missing';
        v_confidence := 'missing';
        v_assumptions := array_append(v_assumptions, 'Manca un consumo termico o un prezzo compatibile.');
    END IF;

    IF v_electric_share > 0
       AND (v_electricity_price IS NULL OR v_inputs.electric_consumption_kwh_100km IS NULL) THEN
        v_status := 'missing';
        v_confidence := 'missing';
        v_assumptions := array_append(v_assumptions, 'Manca un consumo elettrico o un mix di ricarica valido.');
    END IF;

    IF v_canonical_fuel IS NULL AND v_thermal_share > 0 THEN
        v_status := 'missing';
        v_confidence := 'missing';
        v_assumptions := array_append(v_assumptions, 'Alimentazione non coperta.');
    END IF;

    IF v_status = 'complete' THEN
        IF v_thermal_share > 0 THEN
            v_annual_thermal := v_thermal_km / 100
                * v_inputs.thermal_consumption_per_100km
                * v_fuel_price;
        END IF;

        IF v_electric_share > 0 THEN
            v_annual_electric := v_electric_km / 100
                * v_inputs.electric_consumption_kwh_100km
                * v_electricity_price;
        END IF;

        v_sources := ARRAY[
            'https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b',
            'database://mvp.vehicle_cluster_energy_inputs_v1'
        ];

        IF v_canonical_fuel IN ('petrol', 'diesel', 'lpg', 'ng') THEN
            v_sources := array_append(v_sources, 'https://www.mimit.gov.it/it/prezzo-medio-carburanti');
        END IF;
    END IF;

    RETURN QUERY SELECT
        v_catalog.vehicle_cluster_id,
        p_annual_km,
        v_thermal_km,
        v_electric_km,
        v_inputs.thermal_consumption_per_100km,
        v_inputs.electric_consumption_kwh_100km,
        v_fuel_price,
        v_electricity_price,
        CASE WHEN v_status = 'complete' THEN round(v_annual_thermal + v_annual_electric, 2) END,
        CASE WHEN v_status = 'complete' THEN round((v_annual_thermal + v_annual_electric) / 12, 2) END,
        v_status,
        v_confidence,
        v_assumptions,
        v_sources;
END;
$function$;

REVOKE ALL ON TABLE mvp.vehicle_cluster_energy_inputs_v1 FROM PUBLIC;
REVOKE ALL ON FUNCTION mvp.estimate_vehicle_cluster_energy_v1(text, integer, text, date) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION mvp.estimate_vehicle_cluster_energy_v1(text, integer, text, date) TO auto_tco_web;

COMMIT;

-- Verifica inclusa: deve terminare con "ok" e zero input mancanti.
WITH catalog_count AS (
    SELECT count(*)::integer AS versioni_catalogo
    FROM mvp.site_vehicle_catalog_eea_v2
), counts AS (
    SELECT
        count(*)::integer AS versioni_totali,
        count(*) FILTER (WHERE input_status = 'ready')::integer AS input_pronti,
        count(*) FILTER (WHERE input_status = 'missing')::integer AS input_mancanti,
        count(*) FILTER (
            WHERE thermal_method IN ('eea_observed', 'profile_original')
               OR electric_method IN ('eea_observed', 'profile_original')
        )::integer AS con_dato_diretto,
        count(*) FILTER (
            WHERE coalesce(thermal_method, '') LIKE '%median%'
               OR coalesce(electric_method, '') LIKE '%median%'
        )::integer AS con_stima_controllata
    FROM mvp.vehicle_cluster_energy_inputs_v1
), sample AS (
    SELECT e.*
    FROM mvp.site_vehicle_catalog_eea_v2 AS c
    CROSS JOIN LATERAL mvp.estimate_vehicle_cluster_energy_v1(
        c.vehicle_cluster_id, 15000, 'italia', CURRENT_DATE
    ) AS e
    WHERE c.energy_data_status IN ('missing', 'partial')
    ORDER BY c.registrations_count DESC, c.vehicle_cluster_id
    LIMIT 1
)
SELECT
    c.versioni_totali,
    c.input_pronti,
    c.input_mancanti,
    c.con_dato_diretto,
    c.con_stima_controllata,
    s.calculation_status AS esempio_stato,
    s.monthly_energy_cost_eur AS esempio_euro_mese,
    CASE
        WHEN c.versioni_totali = catalog.versioni_catalogo
         AND c.input_pronti = c.versioni_totali
         AND c.input_mancanti = 0
         AND s.calculation_status = 'complete'
         AND s.monthly_energy_cost_eur > 0
            THEN 'ok'
        ELSE 'controllare'
    END AS verifica
FROM counts AS c
CROSS JOIN catalog_count AS catalog
CROSS JOIN sample AS s;
