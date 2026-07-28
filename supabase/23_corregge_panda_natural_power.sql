-- Auto TCO - corregge la Fiat Panda Natural Power.
--
-- La precedente riga 2012-2020 da 80 CV accorpava due motorizzazioni
-- commercialmente diverse e, soprattutto, era collegata a un profilo
-- successivo da 84 CV con consumo stimato. Questa migrazione usa soltanto
-- dati ufficiali FIAT e crea tre profili tecnici dedicati:
--
--   * 2012-2018: 80 CV a metano, 3,1 kg/100 km (ciclo omologativo NEDC);
--   * 2019-2020: 70 CV a metano, 3,5 kg/100 km (NEDC correlato);
--   * 2021:      70 CV a metano, 4,1 kg/100 km (WLTP).
--
-- Il 2021 resta separato perche il consumo WLTP italiano differisce di oltre
-- il 10% dal valore NEDC correlato del listino 2020. I profili conservano il
-- prezzo nuovo ufficiale e usano la curva di svalutazione interna gia
-- adottata dal progetto, senza modificare alcun dato originale.

\set ON_ERROR_STOP on

BEGIN;

SET LOCAL statement_timeout = '15min';

CREATE TEMP TABLE panda_natural_power_specs (
  source_type text PRIMARY KEY,
  display_name text NOT NULL,
  representative_year integer NOT NULL,
  year_from integer NOT NULL,
  year_to integer NOT NULL,
  power_kw numeric NOT NULL,
  power_cv integer NOT NULL,
  consumption_kg_100km numeric NOT NULL,
  euro_class integer NOT NULL,
  estimated_new_price_eur numeric NOT NULL,
  source_url text NOT NULL,
  source_notes text NOT NULL,
  energy_method text NOT NULL,
  curated_version_id text NOT NULL,
  display_order integer NOT NULL
) ON COMMIT DROP;

INSERT INTO panda_natural_power_specs (
  source_type,
  display_name,
  representative_year,
  year_from,
  year_to,
  power_kw,
  power_cv,
  consumption_kg_100km,
  euro_class,
  estimated_new_price_eur,
  source_url,
  source_notes,
  energy_method,
  curated_version_id,
  display_order
)
VALUES
  (
    'fiat_official_panda_natural_power_80_2012_2018',
    'Fiat Panda 2012-2018 - Metano - 80 CV',
    2015,
    2012,
    2018,
    59,
    80,
    3.1,
    5,
    13950,
    'https://www.media.stellantis.com/it-it/fiat/press/fiat-panda-natural-power-al-via-gli-ordini-del-primo-due-cilindri-a-metano',
    'FIAT, lancio italiano 2012: 0.9 TwinAir Turbo Natural Power, 59 kW/80 CV a metano, consumo combinato 3,1 kg/100 km e prezzo Pop 13.950 euro chiavi in mano. L intervallo termina prima della versione depotenziata a 70 CV.',
    'fiat_official_nedc_cng_2012',
    'panda-2012-ng-80-2012-2018',
    80
  ),
  (
    'fiat_official_panda_natural_power_70_2019_2020',
    'Fiat Panda 2019-2020 - Metano - 70 CV',
    2020,
    2019,
    2020,
    52,
    70,
    3.5,
    6,
    16250,
    'https://www.media.stellantis.com/uploads/it/attachment/newpandamy_200609_listino-5edf815990101.pdf',
    'FIAT, listino italiano 9 giugno 2020: 0.9 TwinAir Turbo Natural Power, 52 kW/70 CV a metano, consumo combinato 3,5 kg/100 km NEDC correlato e prezzo Easy 16.250 euro chiavi in mano.',
    'fiat_official_correlated_nedc_cng_2020',
    'panda-2012-ng-70-2019-2020',
    81
  ),
  (
    'fiat_official_panda_natural_power_70_2021',
    'Fiat Panda 2021 - Metano - 70 CV',
    2021,
    2021,
    2021,
    52,
    70,
    4.1,
    6,
    17050,
    'https://www.media.stellantis.com/uploads/it/model-pricelist/210318_newlist_pandamy21-60531dfe313a2.pdf',
    'FIAT, listino italiano 18 marzo 2021: 0.9 TwinAir Turbo Natural Power, 52 kW/70 CV a metano, consumo combinato WLTP 4,1 kg/100 km e prezzo City Life 17.050 euro chiavi in mano.',
    'fiat_official_wltp_cng_2021',
    'panda-2012-ng-70-2021',
    82
  );

DO $profiles$
DECLARE
  v_seed_model_id integer;
  v_brand_factor numeric;
  v_profile_id integer;
  v_spec panda_natural_power_specs%ROWTYPE;
BEGIN
  SELECT min(catalog.seed_model_id)
  INTO v_seed_model_id
  FROM mvp.site_vehicle_catalog_publishable_v1 AS catalog
  JOIN mvp.site_vehicle_model_curations_v1 AS curation
    ON curation.source_model_catalog_id = catalog.model_catalog_id
  WHERE curation.public_model_id = 'curated:fiat:panda-2012'
    AND catalog.seed_model_id IS NOT NULL;

  IF v_seed_model_id IS NULL THEN
    RAISE EXCEPTION
      'Impossibile creare i profili Panda Natural Power: seed model assente';
  END IF;

  SELECT COALESCE(
    percentile_cont(0.5) WITHIN GROUP (
      ORDER BY profile.depreciation_brand_factor
    ),
    1.0
  )::numeric
  INTO v_brand_factor
  FROM mvp.vehicle_profiles AS profile
  WHERE lower(profile.brand) = 'fiat'
    AND profile.profile_status = 'active'
    AND profile.depreciation_brand_factor IS NOT NULL;

  FOR v_spec IN
    SELECT *
    FROM panda_natural_power_specs
    ORDER BY year_from
  LOOP
    SELECT profile.id
    INTO v_profile_id
    FROM mvp.vehicle_profiles AS profile
    WHERE profile.source_type = v_spec.source_type
    ORDER BY profile.id
    LIMIT 1;

    IF v_profile_id IS NULL THEN
      INSERT INTO mvp.vehicle_profiles (
        display_name,
        brand,
        model,
        representative_year,
        year_from,
        year_to,
        fuel_type,
        hybrid_type,
        power_kw,
        power_cv,
        segment,
        body_type,
        brand_tier,
        consumption_l_100km,
        confidence,
        source_notes,
        seed_model_id,
        profile_kind,
        source_type,
        source_records_count,
        popularity_score,
        profile_status,
        euro_class,
        estimated_new_price_eur,
        depreciation_category,
        depreciation_brand_factor,
        depreciation_notes,
        uncertainty_profile_kind,
        energy_input_source,
        energy_input_confidence
      )
      VALUES (
        v_spec.display_name,
        'Fiat',
        'Panda',
        v_spec.representative_year,
        v_spec.year_from,
        v_spec.year_to,
        'ng',
        'none',
        v_spec.power_kw,
        v_spec.power_cv,
        'A',
        'hatchback',
        'mainstream',
        v_spec.consumption_kg_100km,
        'high',
        v_spec.source_notes,
        v_seed_model_id,
        'curated_commercial_profile_v1',
        v_spec.source_type,
        1,
        0,
        'active',
        v_spec.euro_class,
        v_spec.estimated_new_price_eur,
        'city_utilitaria',
        v_brand_factor,
        'Prezzo nuovo FIAT ufficiale della versione di accesso del periodo; svalutazione calcolata con la curva interna trasparente per utilitarie e il fattore mediano FIAT.',
        'official_specs_internal_depreciation_curve',
        v_spec.energy_method,
        'high'
      )
      RETURNING id INTO v_profile_id;
    ELSE
      UPDATE mvp.vehicle_profiles
      SET
        display_name = v_spec.display_name,
        brand = 'Fiat',
        model = 'Panda',
        representative_year = v_spec.representative_year,
        year_from = v_spec.year_from,
        year_to = v_spec.year_to,
        fuel_type = 'ng',
        hybrid_type = 'none',
        power_kw = v_spec.power_kw,
        power_cv = v_spec.power_cv,
        segment = 'A',
        body_type = 'hatchback',
        brand_tier = 'mainstream',
        consumption_l_100km = v_spec.consumption_kg_100km,
        confidence = 'high',
        source_notes = v_spec.source_notes,
        seed_model_id = v_seed_model_id,
        profile_kind = 'curated_commercial_profile_v1',
        source_records_count = 1,
        popularity_score = 0,
        profile_status = 'active',
        euro_class = v_spec.euro_class,
        estimated_new_price_eur = v_spec.estimated_new_price_eur,
        depreciation_category = 'city_utilitaria',
        depreciation_brand_factor = v_brand_factor,
        depreciation_notes =
          'Prezzo nuovo FIAT ufficiale della versione di accesso del periodo; svalutazione calcolata con la curva interna trasparente per utilitarie e il fattore mediano FIAT.',
        uncertainty_profile_kind =
          'official_specs_internal_depreciation_curve',
        energy_input_source = v_spec.energy_method,
        energy_input_confidence = 'high'
      WHERE id = v_profile_id;
    END IF;

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
    VALUES (
      'profile:' || v_profile_id::text,
      v_spec.consumption_kg_100km,
      NULL,
      v_spec.energy_method,
      NULL,
      1,
      0,
      'ready',
      'high',
      now()
    )
    ON CONFLICT (vehicle_cluster_id) DO UPDATE
    SET
      thermal_consumption_per_100km =
        EXCLUDED.thermal_consumption_per_100km,
      electric_consumption_kwh_100km =
        EXCLUDED.electric_consumption_kwh_100km,
      thermal_method = EXCLUDED.thermal_method,
      electric_method = EXCLUDED.electric_method,
      thermal_reference_count = EXCLUDED.thermal_reference_count,
      electric_reference_count = EXCLUDED.electric_reference_count,
      input_status = EXCLUDED.input_status,
      confidence = EXCLUDED.confidence,
      built_at = EXCLUDED.built_at;
  END LOOP;
END;
$profiles$;

-- Elimina la vecchia riga accorpata e rende la migrazione ripetibile.
DELETE FROM mvp.site_vehicle_version_curations_v1
WHERE curated_version_id IN (
  'panda-2012-ng-80-2012-2020',
  'panda-2012-ng-80-2012-2018',
  'panda-2012-ng-70-2019-2020',
  'panda-2012-ng-70-2021'
);

INSERT INTO mvp.site_vehicle_version_curations_v1 (
  curated_version_id,
  public_model_id,
  calculation_vehicle_cluster_id,
  year_from,
  year_to,
  fuel_type,
  hybrid_type,
  powertrain_type,
  power_kw,
  power_cv,
  transmission_label,
  gear_count,
  commercial_name,
  source_name,
  source_url,
  source_note,
  confidence,
  display_order,
  is_active,
  updated_at
)
SELECT
  spec.curated_version_id,
  'curated:fiat:panda-2012',
  'profile:' || profile.id::text,
  spec.year_from,
  spec.year_to,
  'ng',
  'none',
  'combustion',
  spec.power_kw,
  spec.power_cv,
  'Manuale',
  5,
  '0.9 TwinAir Turbo Natural Power',
  'FIAT - dati tecnici e listini ufficiali',
  spec.source_url,
  spec.source_notes,
  'high',
  spec.display_order,
  true,
  now()
FROM panda_natural_power_specs AS spec
JOIN mvp.vehicle_profiles AS profile
  ON profile.source_type = spec.source_type
 AND profile.profile_status = 'active';

NOTIFY pgrst, 'reload schema';

-- Verifica inclusa: le tre versioni devono essere pubblicate, collegate a
-- profili ufficiali distinti e produrre un TCO completo usando €/kg.
WITH versions AS (
  SELECT item
  FROM jsonb_array_elements(
    public.auto_tco_versions('curated:fiat:panda-2012') -> 'items'
  ) AS item
), natural_power AS (
  SELECT
    item,
    public.auto_tco_estimate(
      item ->> 'vehicle_cluster_id',
      15000,
      5,
      'italia'
    ) AS result
  FROM versions
  WHERE item ->> 'fuel_type' = 'ng'
), summary AS (
  SELECT
    count(*)::integer AS versioni_metano,
    count(*) FILTER (
      WHERE item ->> 'version_label' =
        '2012-2018 ' || chr(183) || ' Metano ' || chr(183) || ' 80 CV'
    )::integer AS versione_80_cv,
    count(*) FILTER (
      WHERE item ->> 'version_label' =
        '2019-2020 ' || chr(183) || ' Metano ' || chr(183) || ' 70 CV'
    )::integer AS versione_70_cv_nedc,
    count(*) FILTER (
      WHERE item ->> 'version_label' =
        '2021 ' || chr(183) || ' Metano ' || chr(183) || ' 70 CV'
    )::integer AS versione_70_cv_wltp,
    count(*) FILTER (
      WHERE item ->> 'vehicle_cluster_id' ~ '^profile:[0-9]+$'
        AND result #>> '{quality,status}' = 'ready'
        AND COALESCE(
          (result #>> '{monthly_costs,total_monthly_eur}')::numeric,
          0
        ) > 0
    )::integer AS calcoli_ready,
    count(*) FILTER (
      WHERE result #>> '{calculation_details,fuel_or_energy,thermal_price_unit}'
        LIKE '%/kg'
    )::integer AS prezzi_per_kg,
    array_agg(
      DISTINCT (
        result
          #>> '{calculation_details,fuel_or_energy,thermal_consumption_per_100km}'
      )::numeric
      ORDER BY (
        result
          #>> '{calculation_details,fuel_or_energy,thermal_consumption_per_100km}'
      )::numeric
    ) AS consumi_usati
  FROM natural_power
)
SELECT
  versioni_metano,
  versione_80_cv,
  versione_70_cv_nedc,
  versione_70_cv_wltp,
  calcoli_ready,
  prezzi_per_kg,
  consumi_usati,
  CASE
    WHEN versioni_metano = 3
      AND versione_80_cv = 1
      AND versione_70_cv_nedc = 1
      AND versione_70_cv_wltp = 1
      AND calcoli_ready = 3
      AND prezzi_per_kg = 3
      AND consumi_usati = ARRAY[3.1, 3.5, 4.1]::numeric[]
      THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM summary;

DO $verify$
DECLARE
  v_old_rows integer;
  v_published integer;
  v_ready integer;
  v_consumptions numeric[];
BEGIN
  SELECT count(*)::integer
  INTO v_old_rows
  FROM mvp.site_vehicle_version_curations_v1
  WHERE curated_version_id = 'panda-2012-ng-80-2012-2020';

  WITH versions AS (
    SELECT item
    FROM jsonb_array_elements(
      public.auto_tco_versions('curated:fiat:panda-2012') -> 'items'
    ) AS item
    WHERE item ->> 'fuel_type' = 'ng'
  ), calculations AS (
    SELECT
      item,
      public.auto_tco_estimate(
        item ->> 'vehicle_cluster_id',
        15000,
        5,
        'italia'
      ) AS result
    FROM versions
  )
  SELECT
    count(*)::integer,
    count(*) FILTER (
      WHERE result #>> '{quality,status}' = 'ready'
        AND result
          #>> '{calculation_details,fuel_or_energy,thermal_price_unit}'
          LIKE '%/kg'
    )::integer,
    array_agg(
      DISTINCT (
        result
          #>> '{calculation_details,fuel_or_energy,thermal_consumption_per_100km}'
      )::numeric
      ORDER BY (
        result
          #>> '{calculation_details,fuel_or_energy,thermal_consumption_per_100km}'
      )::numeric
    )
  INTO v_published, v_ready, v_consumptions
  FROM calculations;

  IF v_old_rows <> 0
    OR v_published <> 3
    OR v_ready <> 3
    OR v_consumptions <> ARRAY[3.1, 3.5, 4.1]::numeric[]
  THEN
    RAISE EXCEPTION
      'Verifica Panda Natural Power fallita: vecchie %, pubblicate %, ready %, consumi %',
      v_old_rows,
      v_published,
      v_ready,
      v_consumptions;
  END IF;
END;
$verify$;

COMMIT;
