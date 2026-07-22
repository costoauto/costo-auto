-- Auto TCO - stima trasparente della manutenzione.
--
-- Include manutenzione ordinaria e usura/riparazioni prevedibili.
-- Esclude pneumatici, revisione, incidenti e batteria di trazione.
-- La metodologia ACI giustifica il calcolo per km; i rapporti fra
-- alimentazioni elettrificate e termiche sono calibrati su dati DOE/ANL.

BEGIN;

CREATE TABLE IF NOT EXISTS mvp.maintenance_powertrain_rules_v1 (
  rule_code text PRIMARY KEY,
  base_eur_per_km numeric(8, 4) NOT NULL,
  confidence text NOT NULL,
  source_name text NOT NULL,
  source_url text NOT NULL,
  notes text NOT NULL,
  CONSTRAINT maintenance_powertrain_rate_positive
    CHECK (base_eur_per_km > 0)
);

CREATE TABLE IF NOT EXISTS mvp.maintenance_age_rules_v1 (
  age_from integer PRIMARY KEY,
  age_to integer,
  age_factor numeric(8, 4) NOT NULL,
  notes text NOT NULL,
  CONSTRAINT maintenance_age_bounds
    CHECK (age_from >= 0 AND (age_to IS NULL OR age_to >= age_from)),
  CONSTRAINT maintenance_age_factor_positive
    CHECK (age_factor > 0)
);

CREATE TABLE IF NOT EXISTS mvp.maintenance_power_rules_v1 (
  kw_from integer PRIMARY KEY,
  kw_to integer,
  power_factor numeric(8, 4) NOT NULL,
  notes text NOT NULL,
  CONSTRAINT maintenance_power_bounds
    CHECK (kw_from >= 0 AND (kw_to IS NULL OR kw_to >= kw_from)),
  CONSTRAINT maintenance_power_factor_positive
    CHECK (power_factor > 0)
);

REVOKE ALL ON mvp.maintenance_powertrain_rules_v1 FROM PUBLIC;
REVOKE ALL ON mvp.maintenance_age_rules_v1 FROM PUBLIC;
REVOKE ALL ON mvp.maintenance_power_rules_v1 FROM PUBLIC;

INSERT INTO mvp.maintenance_powertrain_rules_v1 (
  rule_code,
  base_eur_per_km,
  confidence,
  source_name,
  source_url,
  notes
)
VALUES
  (
    'petrol', 0.0500, 'medium_low',
    'ACI / modello interno Auto TCO',
    'https://www.aci.it/fileadmin/documenti/servizi_online/Costi_chilometrici/Metodologia_2022.pdf',
    'Base italiana per manutenzione e riparazioni prevedibili, espressa per km.'
  ),
  (
    'diesel', 0.0520, 'medium_low',
    'ACI / modello interno Auto TCO',
    'https://www.aci.it/fileadmin/documenti/servizi_online/Costi_chilometrici/Metodologia_2022.pdf',
    'Leggero incremento prudenziale per i sistemi di alimentazione ed emissione diesel.'
  ),
  (
    'hybrid', 0.0460, 'medium_low',
    'Argonne National Laboratory / U.S. DOE',
    'https://afdc.energy.gov/files/u/publication/total_cost_of_ownership_quantification.pdf',
    'Rapporto relativo rispetto al termico applicato alla base italiana.'
  ),
  (
    'plug_in_hybrid', 0.0440, 'medium_low',
    'Argonne National Laboratory / U.S. DOE',
    'https://afdc.energy.gov/files/u/publication/total_cost_of_ownership_quantification.pdf',
    'Rapporto relativo rispetto al termico applicato alla base italiana.'
  ),
  (
    'electric', 0.0300, 'medium',
    'U.S. Department of Energy',
    'https://www.energy.gov/cmei/vehicles/articles/fotw-1190-june-14-2021-battery-electric-vehicles-have-lower-scheduled',
    'Rapporto 6,1/10,1 rispetto al termico applicato alla base italiana.'
  ),
  (
    'other', 0.0500, 'low',
    'ACI / modello interno Auto TCO',
    'https://www.aci.it/fileadmin/documenti/servizi_online/Costi_chilometrici/Metodologia_2022.pdf',
    'Fallback prudenziale quando l alimentazione non rientra nei gruppi principali.'
  )
ON CONFLICT (rule_code) DO UPDATE
SET
  base_eur_per_km = EXCLUDED.base_eur_per_km,
  confidence = EXCLUDED.confidence,
  source_name = EXCLUDED.source_name,
  source_url = EXCLUDED.source_url,
  notes = EXCLUDED.notes;

INSERT INTO mvp.maintenance_age_rules_v1 (
  age_from, age_to, age_factor, notes
)
VALUES
  (0, 2, 0.7000, 'Auto nuova o quasi nuova; maggiore copertura di garanzia.'),
  (3, 5, 0.8500, 'Prima fase di manutenzione ordinaria consolidata.'),
  (6, 9, 1.0000, 'Fascia di riferimento del modello.'),
  (10, 14, 1.2500, 'Aumenta l usura prevedibile dei componenti.'),
  (15, 19, 1.4500, 'Maggiore frequenza attesa di interventi per usura.'),
  (20, NULL, 1.6500, 'Veicolo anziano; stima prudenziale, non include guasti eccezionali.')
ON CONFLICT (age_from) DO UPDATE
SET
  age_to = EXCLUDED.age_to,
  age_factor = EXCLUDED.age_factor,
  notes = EXCLUDED.notes;

INSERT INTO mvp.maintenance_power_rules_v1 (
  kw_from, kw_to, power_factor, notes
)
VALUES
  (0, 69, 0.8500, 'Utilitaria o motorizzazione di potenza contenuta.'),
  (70, 110, 1.0000, 'Fascia di riferimento.'),
  (111, 150, 1.1200, 'Componenti mediamente piu costosi o sollecitati.'),
  (151, 200, 1.2500, 'Motorizzazione ad alte prestazioni.'),
  (201, NULL, 1.4000, 'Motorizzazione ad altissime prestazioni.')
ON CONFLICT (kw_from) DO UPDATE
SET
  kw_to = EXCLUDED.kw_to,
  power_factor = EXCLUDED.power_factor,
  notes = EXCLUDED.notes;

CREATE OR REPLACE FUNCTION mvp.estimate_maintenance_v1(
  p_fuel_type text,
  p_hybrid_type text,
  p_representative_year integer,
  p_power_kw numeric,
  p_annual_km integer,
  p_ownership_years integer,
  p_as_of_date date DEFAULT CURRENT_DATE
)
RETURNS jsonb
LANGUAGE plpgsql
STABLE
AS $function$
DECLARE
  v_rule_code text;
  v_powertrain mvp.maintenance_powertrain_rules_v1%ROWTYPE;
  v_age_rule mvp.maintenance_age_rules_v1%ROWTYPE;
  v_power_rule mvp.maintenance_power_rules_v1%ROWTYPE;
  v_start_age integer;
  v_age integer;
  v_year_offset integer;
  v_annual_cost numeric;
  v_total_cost numeric := 0;
  v_confidence text;
BEGIN
  IF p_annual_km NOT BETWEEN 1000 AND 100000 THEN
    RAISE EXCEPTION 'Chilometri annui non validi' USING ERRCODE = '22023';
  END IF;

  IF p_ownership_years NOT BETWEEN 1 AND 10 THEN
    RAISE EXCEPTION 'Anni di possesso non validi' USING ERRCODE = '22023';
  END IF;

  IF p_as_of_date IS NULL THEN
    RAISE EXCEPTION 'Data di calcolo non valida' USING ERRCODE = '22023';
  END IF;

  v_rule_code := CASE
    WHEN lower(coalesce(p_fuel_type, '')) = 'electric'
      OR lower(coalesce(p_hybrid_type, '')) = 'electric'
      THEN 'electric'
    WHEN lower(coalesce(p_hybrid_type, '')) = 'plug_in_hybrid'
      OR lower(coalesce(p_fuel_type, '')) IN ('petrol/electric', 'diesel/electric')
        AND lower(coalesce(p_hybrid_type, '')) = 'plug_in_hybrid'
      THEN 'plug_in_hybrid'
    WHEN lower(coalesce(p_hybrid_type, '')) = 'hybrid'
      OR lower(coalesce(p_fuel_type, '')) IN ('petrol/electric', 'diesel/electric')
      THEN 'hybrid'
    WHEN lower(coalesce(p_fuel_type, '')) = 'diesel'
      THEN 'diesel'
    WHEN lower(coalesce(p_fuel_type, '')) IN ('petrol', 'lpg', 'ng')
      THEN 'petrol'
    ELSE 'other'
  END;

  SELECT * INTO v_powertrain
  FROM mvp.maintenance_powertrain_rules_v1
  WHERE rule_code = v_rule_code;

  SELECT * INTO v_power_rule
  FROM mvp.maintenance_power_rules_v1
  WHERE greatest(floor(coalesce(p_power_kw, 90))::integer, 0) >= kw_from
    AND (
      kw_to IS NULL
      OR greatest(floor(coalesce(p_power_kw, 90))::integer, 0) <= kw_to
    )
  ORDER BY kw_from DESC
  LIMIT 1;

  v_start_age := greatest(
    extract(year FROM p_as_of_date)::integer
      - coalesce(p_representative_year, extract(year FROM p_as_of_date)::integer),
    0
  );

  FOR v_year_offset IN 0..(p_ownership_years - 1) LOOP
    v_age := v_start_age + v_year_offset;

    SELECT * INTO v_age_rule
    FROM mvp.maintenance_age_rules_v1
    WHERE v_age >= age_from
      AND (age_to IS NULL OR v_age <= age_to)
    ORDER BY age_from DESC
    LIMIT 1;

    v_annual_cost := round(
      p_annual_km
      * v_powertrain.base_eur_per_km
      * v_age_rule.age_factor
      * v_power_rule.power_factor,
      2
    );

    v_total_cost := v_total_cost + v_annual_cost;
  END LOOP;

  v_confidence := v_powertrain.confidence;
  IF p_representative_year IS NULL OR p_power_kw IS NULL THEN
    v_confidence := 'low';
  END IF;

  RETURN jsonb_build_object(
    'monthly_maintenance_eur',
      round(v_total_cost / (p_ownership_years * 12), 2),
    'average_annual_maintenance_eur',
      round(v_total_cost / p_ownership_years, 2),
    'total_maintenance_period_eur', round(v_total_cost, 2),
    'base_eur_per_km', v_powertrain.base_eur_per_km,
    'powertrain_rule', v_rule_code,
    'power_factor', v_power_rule.power_factor,
    'starting_age_years', v_start_age,
    'annual_km', p_annual_km,
    'ownership_years', p_ownership_years,
    'calculation_status', 'estimated',
    'confidence', v_confidence,
    'description',
      'Stima di tagliandi, materiali di consumo e usura prevedibile basata su chilometri, eta, alimentazione e potenza.',
    'exclusions', jsonb_build_array(
      'pneumatici',
      'revisione obbligatoria',
      'incidenti e carrozzeria',
      'batteria di trazione',
      'guasti eccezionali'
    ),
    'sources', jsonb_build_array(
      jsonb_build_object(
        'name', 'ACI - Metodologia costi chilometrici',
        'url', 'https://www.aci.it/fileadmin/documenti/servizi_online/Costi_chilometrici/Metodologia_2022.pdf'
      ),
      jsonb_build_object(
        'name', 'ACI - Annuario statistico 2025, spesa manutenzione e riparazione 2024',
        'url', 'https://aci.gov.it/attivita-e-progetti/studi-e-ricerche/annuario-statistico'
      ),
      jsonb_build_object(
        'name', v_powertrain.source_name,
        'url', v_powertrain.source_url
      )
    )
  );
END;
$function$;

REVOKE ALL ON FUNCTION mvp.estimate_maintenance_v1(
  text, text, integer, numeric, integer, integer, date
) FROM PUBLIC;

-- Conserva una copia privata del payload precedente. In caso di riesecuzione
-- la copia esiste gia e non viene sovrascritta con il wrapper nuovo.
DO $rename_previous$
BEGIN
  IF to_regprocedure(
    'public.auto_tco_estimate_without_maintenance_v1(text,integer,integer,text)'
  ) IS NULL THEN
    EXECUTE
      'ALTER FUNCTION public.auto_tco_estimate(text, integer, integer, text) '
      'RENAME TO auto_tco_estimate_without_maintenance_v1';
  END IF;
END;
$rename_previous$;

REVOKE ALL ON FUNCTION public.auto_tco_estimate_without_maintenance_v1(
  text, integer, integer, text
) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.auto_tco_estimate_without_maintenance_v1(
  text, integer, integer, text
) FROM anon;

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
  v_maintenance jsonb;
  v_profile_id integer;
  v_year integer;
  v_fuel_type text;
  v_hybrid_type text;
  v_power_kw numeric;
  v_monthly numeric;
  v_subtotal numeric;
  v_total numeric;
  v_excluded jsonb;
BEGIN
  v_result := public.auto_tco_estimate_without_maintenance_v1(
    p_vehicle_cluster_id,
    p_annual_km,
    p_ownership_years,
    p_region_code
  );

  IF trim(p_vehicle_cluster_id) ~ '^profile:[0-9]{1,10}$' THEN
    v_profile_id := substring(trim(p_vehicle_cluster_id) FROM 9)::integer;

    SELECT
      profile.representative_year,
      profile.fuel_type,
      profile.hybrid_type,
      profile.power_kw
    INTO
      v_year,
      v_fuel_type,
      v_hybrid_type,
      v_power_kw
    FROM mvp.vehicle_profiles AS profile
    WHERE profile.id = v_profile_id
      AND profile.profile_status = 'active';
  ELSE
    SELECT
      2025,
      catalog.fuel_type,
      catalog.hybrid_type,
      catalog.power_kw
    INTO
      v_year,
      v_fuel_type,
      v_hybrid_type,
      v_power_kw
    FROM mvp.site_vehicle_catalog_eea_v2 AS catalog
    WHERE catalog.vehicle_cluster_id = trim(p_vehicle_cluster_id);
  END IF;

  v_maintenance := mvp.estimate_maintenance_v1(
    v_fuel_type,
    v_hybrid_type,
    v_year,
    v_power_kw,
    p_annual_km,
    p_ownership_years,
    CURRENT_DATE
  );

  v_monthly := (v_maintenance ->> 'monthly_maintenance_eur')::numeric;
  v_subtotal := round(
    coalesce((v_result #>> '{monthly_costs,available_subtotal_eur}')::numeric, 0)
      + v_monthly,
    2
  );
  v_total := CASE
    WHEN v_result #>> '{monthly_costs,total_monthly_eur}' IS NULL THEN NULL
    ELSE round(
      (v_result #>> '{monthly_costs,total_monthly_eur}')::numeric
        + v_monthly,
      2
    )
  END;

  v_result := jsonb_set(
    v_result,
    '{monthly_costs,maintenance_eur}',
    to_jsonb(v_monthly),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{monthly_costs,available_subtotal_eur}',
    to_jsonb(v_subtotal),
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
    to_jsonb(v_maintenance ->> 'description'),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,components,maintenance}',
    to_jsonb(v_maintenance ->> 'calculation_status'),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,confidence,maintenance}',
    to_jsonb(v_maintenance ->> 'confidence'),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{calculation_details,maintenance}',
    v_maintenance,
    true
  );

  SELECT coalesce(jsonb_agg(item), '[]'::jsonb)
  INTO v_excluded
  FROM jsonb_array_elements(
    coalesce(v_result -> 'excluded_components', '[]'::jsonb)
  ) AS items(item)
  WHERE item ->> 'code' <> 'maintenance';

  v_result := jsonb_set(
    v_result,
    '{excluded_components}',
    v_excluded,
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
CREATE TEMP TABLE auto_tco_migration_17_check AS
WITH samples AS (
  SELECT
    (
      SELECT vehicle_cluster_id
      FROM mvp.site_vehicle_catalog_eea_v2
      WHERE fuel_type = 'petrol'
        AND power_kw IS NOT NULL
        AND depreciation_data_status <> 'missing'
      ORDER BY registrations_count DESC, vehicle_cluster_id
      LIMIT 1
    ) AS petrol_id,
    (
      SELECT vehicle_cluster_id
      FROM mvp.site_vehicle_catalog_eea_v2
      WHERE powertrain_type = 'electric' AND power_kw IS NOT NULL
      ORDER BY registrations_count DESC, vehicle_cluster_id
      LIMIT 1
    ) AS electric_id
), results AS (
  SELECT
    public.auto_tco_estimate(petrol_id, 15000, 5, 'italia') AS petrol,
    public.auto_tco_estimate(electric_id, 15000, 5, 'italia') AS electric,
    public.auto_tco_estimate(petrol_id, 30000, 5, 'italia') AS petrol_30k
  FROM samples
)
SELECT
  (petrol #>> '{monthly_costs,maintenance_eur}')::numeric
    AS manutenzione_benzina,
  (electric #>> '{monthly_costs,maintenance_eur}')::numeric
    AS manutenzione_elettrica,
  (petrol_30k #>> '{monthly_costs,maintenance_eur}')::numeric
    AS manutenzione_benzina_30000_km,
  petrol #>> '{quality,confidence,maintenance}'
    AS affidabilita,
  jsonb_array_length(petrol -> 'excluded_components')
    AS componenti_ancora_escluse,
  CASE
    WHEN (petrol #>> '{monthly_costs,maintenance_eur}')::numeric > 0
      AND (electric #>> '{monthly_costs,maintenance_eur}')::numeric > 0
      AND (electric #>> '{monthly_costs,maintenance_eur}')::numeric
        < (petrol #>> '{monthly_costs,maintenance_eur}')::numeric
      AND (petrol_30k #>> '{monthly_costs,maintenance_eur}')::numeric
        > (petrol #>> '{monthly_costs,maintenance_eur}')::numeric
      AND petrol #>> '{monthly_costs,total_monthly_eur}' IS NOT NULL
      AND NOT EXISTS (
        SELECT 1
        FROM jsonb_array_elements(
          petrol -> 'excluded_components'
        ) AS items(item)
        WHERE item ->> 'code' = 'maintenance'
      )
    THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM results;

DO $verify$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM auto_tco_migration_17_check
    WHERE verifica = 'ok'
  ) THEN
    RAISE EXCEPTION 'Verifica manutenzione fallita';
  END IF;
END;
$verify$;

TABLE auto_tco_migration_17_check;

DROP TABLE auto_tco_migration_17_check;
