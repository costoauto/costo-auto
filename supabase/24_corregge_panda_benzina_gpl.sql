-- Auto TCO - corregge le principali Panda benzina e GPL.
--
-- Le vecchie righe commerciali accorpavano periodi nei quali cambiavano
-- consumo omologato, ciclo di prova oppure trazione. Questa migrazione usa
-- esclusivamente schede tecniche e listini ufficiali FIAT/Stellantis e
-- pubblica intervalli soltanto quando i dati di calcolo restano omogenei.
--
-- La migrazione:
--   * separa TwinAir 85 CV 4x2 e 4x4;
--   * separa i periodi con consumi diversi;
--   * corregge il periodo della TwinAir Cross da 90 CV;
--   * divide la 1.2 FIRE benzina e la 1.2 EasyPower GPL;
--   * estende la Natural Power WLTP da 70 CV al 2022;
--   * conserva come riga distinta la serie speciale 4x40 del 2023.

\set ON_ERROR_STOP on

BEGIN;

SET LOCAL statement_timeout = '15min';

CREATE TEMP TABLE panda24_specs (
  source_type text PRIMARY KEY,
  curated_version_id text NOT NULL UNIQUE,
  profile_kind text NOT NULL,
  display_name text NOT NULL,
  representative_year integer NOT NULL,
  year_from integer NOT NULL,
  year_to integer NOT NULL,
  fuel_type text NOT NULL,
  power_kw numeric NOT NULL,
  power_cv integer NOT NULL,
  consumption_per_100km numeric NOT NULL,
  euro_class integer NOT NULL,
  estimated_new_price_eur numeric NOT NULL,
  transmission_label text NOT NULL,
  gear_count integer,
  commercial_name text NOT NULL,
  source_url text NOT NULL,
  source_notes text NOT NULL,
  energy_method text NOT NULL,
  confidence text NOT NULL,
  display_order integer NOT NULL
) ON COMMIT DROP;

INSERT INTO panda24_specs (
  source_type,
  curated_version_id,
  profile_kind,
  display_name,
  representative_year,
  year_from,
  year_to,
  fuel_type,
  power_kw,
  power_cv,
  consumption_per_100km,
  euro_class,
  estimated_new_price_eur,
  transmission_label,
  gear_count,
  commercial_name,
  source_url,
  source_notes,
  energy_method,
  confidence,
  display_order
)
VALUES
  (
    'fiat_official_panda_fire_69_petrol_2012_2018',
    'panda-2012-petrol-69-2012-2018',
    'curated_panda_fire69_v1',
    'Fiat Panda 2012-2018 - Benzina - 69 CV',
    2015,
    2012,
    2018,
    'petrol',
    51,
    69,
    5.2,
    5,
    10200,
    'Manuale o Dualogic',
    5,
    '1.2 FIRE',
    'https://www.media.stellantis.com/uploads/ie/IR/2011/FIAT/2012_FIAT_Panda_Technical.pdf',
    'FIAT, scheda tecnica Panda 2012: 1.2 FIRE 69 CV e consumo combinato 5,2 l/100 km. Il listino italiano di lancio parte da 10.200 euro. I listini Euro 6 successivi riportano 5,1 l/100 km, differenza non materiale per una versione commerciale unica.',
    'fiat_official_nedc_petrol_2012',
    'high',
    30
  ),
  (
    'fiat_official_panda_fire_69_petrol_2019_2020',
    'panda-2012-petrol-69-2019-2020',
    'curated_panda_fire69_v1',
    'Fiat Panda 2019-2020 - Benzina - 69 CV',
    2019,
    2019,
    2020,
    'petrol',
    51,
    69,
    5.4,
    6,
    11550,
    'Manuale',
    5,
    '1.2 FIRE',
    'https://www.media.stellantis.com/uploads/it/2019/FIAT/Listini/191023_Fiat_Panda_listino.pdf',
    'FIAT, listino italiano 23 ottobre 2019: 1.2 FIRE 69 CV Euro 6d-Temp, consumi NEDC correlati da 4,9 a 5,9 l/100 km secondo allestimento. Si usa 5,4 l/100 km, punto centrale dichiarato dell intervallo, e il prezzo Pop di 11.550 euro.',
    'fiat_official_correlated_nedc_midpoint_petrol_2019',
    'medium_high',
    31
  ),
  (
    'fiat_official_panda_twinair_85_4x2_2012_2018',
    'panda-2012-petrol-85-4x2-2012-2018',
    'curated_panda_twinair85_4x2_v1',
    'Fiat Panda 2012-2018 - Benzina - 85 CV - 4x2',
    2017,
    2012,
    2018,
    'petrol',
    62.5,
    85,
    4.2,
    5,
    13550,
    'Manuale o Dualogic',
    5,
    '4x2',
    'https://www.media.stellantis.com/uploads/it/2017/FIAT/Listini/170530_Fiat_Panda_listino.pdf',
    'FIAT: la scheda tecnica 2012 e il listino italiano 2017 confermano TwinAir 85 CV 4x2 con consumo combinato 4,1-4,2 l/100 km. Si usa il valore prudente 4,2 e il prezzo Easy 2017 di 13.550 euro.',
    'fiat_official_nedc_petrol_4x2_2012_2017',
    'high',
    10
  ),
  (
    'fiat_official_panda_twinair_85_4x2_2019',
    'panda-2012-petrol-85-4x2-2019',
    'curated_panda_twinair85_4x2_v1',
    'Fiat Panda 2019 - Benzina - 85 CV - 4x2',
    2019,
    2019,
    2019,
    'petrol',
    62.5,
    85,
    4.7,
    6,
    18050,
    'Manuale',
    5,
    '4x2',
    'https://www.media.stellantis.com/uploads/it/2019/FIAT/Listini/191023_Fiat_Panda_listino.pdf',
    'FIAT, listino italiano 23 ottobre 2019: TwinAir 85 CV 4x2 Trussardi, consumo combinato NEDC correlato 4,7 l/100 km e prezzo 18.050 euro.',
    'fiat_official_correlated_nedc_petrol_4x2_2019',
    'high',
    11
  ),
  (
    'fiat_official_panda_twinair_85_4x4_2012_2018',
    'panda-2012-petrol-85-4x4-2012-2018',
    'curated_panda_twinair85_4x4_v1',
    'Fiat Panda 2012-2018 - Benzina - 85 CV - 4x4',
    2017,
    2012,
    2018,
    'petrol',
    62.5,
    85,
    4.9,
    6,
    17400,
    'Manuale',
    6,
    '4x4',
    'https://www.media.stellantis.com/uploads/it/2017/FIAT/Listini/170530_Fiat_Panda_listino.pdf',
    'FIAT: la Panda TwinAir 85 CV 4x4 viene introdotta nel 2012; il listino italiano 2017 conferma 4,9 l/100 km, cambio manuale a 6 marce e prezzo 17.400 euro.',
    'fiat_official_nedc_petrol_4x4_2012_2017',
    'high',
    12
  ),
  (
    'fiat_official_panda_twinair_85_4x4_2019_2020',
    'panda-2012-petrol-85-4x4-2019-2020',
    'curated_panda_twinair85_4x4_v1',
    'Fiat Panda 2019-2020 - Benzina - 85 CV - 4x4',
    2019,
    2019,
    2020,
    'petrol',
    62.5,
    85,
    5.4,
    6,
    17050,
    'Manuale',
    6,
    '4x4',
    'https://www.media.stellantis.com/uploads/it/2019/FIAT/Listini/191023_Fiat_Panda_listino.pdf',
    'FIAT, listino italiano 23 ottobre 2019: TwinAir 85 CV 4x4, consumo NEDC correlato 5,1-5,7 l/100 km secondo allestimento. Si usa il punto centrale 5,4 l/100 km e il prezzo della 4x4 di accesso, 17.050 euro.',
    'fiat_official_correlated_nedc_midpoint_petrol_4x4_2019',
    'medium_high',
    13
  ),
  (
    'fiat_official_panda_twinair_85_4x4_2021_2022',
    'panda-2012-petrol-85-4x4-2021-2022',
    'curated_panda_twinair85_4x4_v1',
    'Fiat Panda 2021-2022 - Benzina - 85 CV - 4x4',
    2022,
    2021,
    2022,
    'petrol',
    63,
    85,
    6.9,
    6,
    18450,
    'Manuale',
    6,
    '4x4',
    'https://www.media.stellantis.com/uploads/it/model-pricelist/newlist_pandamy21_03_02_2022-620f5db8ebd40.pdf',
    'FIAT, listino italiano 3 febbraio 2022: TwinAir 85 CV 4x4 Euro 6d-Final, consumo combinato WLTP 6,9 l/100 km e prezzo Wild 18.450 euro. Nei listini MY23 non compare piu.',
    'fiat_official_wltp_petrol_4x4_2022',
    'high',
    14
  ),
  (
    'fiat_official_panda_twinair_90_cross_2014_2018',
    'panda-2012-petrol-90-cross-2014-2018',
    'curated_panda_twinair90_cross_v1',
    'Fiat Panda 2014-2018 - Benzina - 90 CV - Cross 4x4',
    2017,
    2014,
    2018,
    'petrol',
    66.2,
    90,
    4.9,
    6,
    19400,
    'Manuale',
    6,
    'Cross 4x4',
    'https://www.media.stellantis.com/uploads/it/2017/FIAT/Listini/170530_Fiat_Panda_listino.pdf',
    'FIAT: Panda Cross TwinAir 90 CV introdotta nel 2014. Il listino italiano 2017 conferma 66,19 kW, trazione 4x4, cambio a 6 marce, consumo 4,9 l/100 km e prezzo 19.400 euro. Dal listino 2019 la Cross torna a 85 CV.',
    'fiat_official_nedc_petrol_cross_2017',
    'high',
    20
  ),
  (
    'fiat_official_panda_easypower_69_lpg_2012_2018',
    'panda-2012-lpg-69-2012-2018',
    'curated_panda_easypower69_v1',
    'Fiat Panda 2012-2018 - GPL - 69 CV',
    2015,
    2012,
    2018,
    'lpg',
    51,
    69,
    6.6,
    5,
    12200,
    'Manuale',
    5,
    '1.2 EasyPower',
    'https://www.media.stellantis.com/it-it/fiat/press/la-nuova-fiat-panda-anche-in-versione-easypower-a-doppia-alimentazione-gpl-benzina',
    'FIAT, lancio italiano 4 maggio 2012: 1.2 EasyPower 69 CV, consumo combinato a GPL 6,6 l/100 km e prezzo Pop 12.200 euro. Il listino 2017 riporta 6,5 l/100 km, differenza non materiale per una sola versione commerciale.',
    'fiat_official_nedc_lpg_2012',
    'high',
    70
  ),
  (
    'fiat_official_panda_easypower_69_lpg_2019_2020',
    'panda-2012-lpg-69-2019-2020',
    'curated_panda_easypower69_v1',
    'Fiat Panda 2019-2020 - GPL - 69 CV',
    2020,
    2019,
    2020,
    'lpg',
    51,
    69,
    7.2,
    6,
    14750,
    'Manuale',
    5,
    '1.2 EasyPower',
    'https://www.media.stellantis.com/uploads/it/attachment/newpandamy_200609_listino-5edf815990101.pdf',
    'FIAT, listino italiano 9 giugno 2020: 1.2 EasyPower 69 CV Euro 6d-Temp, consumo a GPL 7,2 l/100 km NEDC correlato e prezzo Easy 14.750 euro.',
    'fiat_official_correlated_nedc_lpg_2020',
    'high',
    71
  ),
  (
    'fiat_official_panda_easypower_69_lpg_2021_2023',
    'panda-2012-lpg-69-2021-2023',
    'curated_panda_easypower69_v1',
    'Fiat Panda 2021-2023 - GPL - 69 CV',
    2022,
    2021,
    2023,
    'lpg',
    51,
    69,
    7.6,
    6,
    15500,
    'Manuale',
    5,
    '1.2 EasyPower',
    'https://www.media.stellantis.com/uploads/it/model-pricelist/newlist_pandamy21_03_02_2022-620f5db8ebd40.pdf',
    'FIAT, listini italiani 2021-2023: consumo combinato WLTP a GPL compreso tra 7,4 e 7,7 l/100 km. Si usa il valore rappresentativo 7,6 l/100 km e il prezzo Panda GPL 2022 di 15.500 euro.',
    'fiat_official_wltp_midpoint_lpg_2021_2023',
    'medium_high',
    72
  );

DO $profiles$
DECLARE
  v_seed_model_id integer;
  v_brand_factor numeric;
  v_profile_id integer;
  v_spec panda24_specs%ROWTYPE;
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
      'Impossibile creare i profili Panda benzina/GPL: seed model assente';
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
    FROM panda24_specs
    ORDER BY display_order, year_from
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
        v_spec.fuel_type,
        'none',
        v_spec.power_kw,
        v_spec.power_cv,
        'A',
        'hatchback',
        'mainstream',
        v_spec.consumption_per_100km,
        v_spec.confidence,
        v_spec.source_notes,
        v_seed_model_id,
        v_spec.profile_kind,
        v_spec.source_type,
        1,
        0,
        'active',
        v_spec.euro_class,
        v_spec.estimated_new_price_eur,
        'city_utilitaria',
        v_brand_factor,
        'Prezzo nuovo FIAT ufficiale della versione rappresentativa del periodo; svalutazione calcolata con la curva interna trasparente per utilitarie e il fattore mediano FIAT.',
        'official_specs_internal_depreciation_curve',
        v_spec.energy_method,
        v_spec.confidence
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
        fuel_type = v_spec.fuel_type,
        hybrid_type = 'none',
        power_kw = v_spec.power_kw,
        power_cv = v_spec.power_cv,
        segment = 'A',
        body_type = 'hatchback',
        brand_tier = 'mainstream',
        consumption_l_100km = v_spec.consumption_per_100km,
        confidence = v_spec.confidence,
        source_notes = v_spec.source_notes,
        seed_model_id = v_seed_model_id,
        profile_kind = v_spec.profile_kind,
        source_records_count = 1,
        popularity_score = 0,
        profile_status = 'active',
        euro_class = v_spec.euro_class,
        estimated_new_price_eur = v_spec.estimated_new_price_eur,
        depreciation_category = 'city_utilitaria',
        depreciation_brand_factor = v_brand_factor,
        depreciation_notes =
          'Prezzo nuovo FIAT ufficiale della versione rappresentativa del periodo; svalutazione calcolata con la curva interna trasparente per utilitarie e il fattore mediano FIAT.',
        uncertainty_profile_kind =
          'official_specs_internal_depreciation_curve',
        energy_input_source = v_spec.energy_method,
        energy_input_confidence = v_spec.confidence
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
      v_spec.consumption_per_100km,
      NULL,
      v_spec.energy_method,
      NULL,
      1,
      0,
      'ready',
      CASE
        WHEN v_spec.confidence = 'medium_high' THEN 'medium'
        ELSE v_spec.confidence
      END,
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

-- Il listino FIAT di febbraio 2022 conferma ancora la Natural Power 70 CV
-- con consumo WLTP 4,1 kg/100 km.
UPDATE mvp.vehicle_profiles
SET
  display_name = 'Fiat Panda 2021-2022 - Metano - 70 CV',
  representative_year = 2022,
  year_to = 2022,
  estimated_new_price_eur = 17800,
  source_notes =
    'FIAT, listino italiano 3 febbraio 2022: 0.9 TwinAir Turbo Natural Power, 52 kW/70 CV, consumo combinato WLTP 4,1 kg/100 km e prezzo City Life 17.800 euro.',
  depreciation_notes =
    'Prezzo nuovo FIAT ufficiale 2022; svalutazione calcolata con la curva interna trasparente per utilitarie e il fattore mediano FIAT.'
WHERE source_type = 'fiat_official_panda_natural_power_70_2021';

UPDATE mvp.site_vehicle_version_curations_v1
SET
  year_to = 2022,
  commercial_name = 'Natural Power',
  source_url =
    'https://www.media.stellantis.com/uploads/it/model-pricelist/newlist_pandamy21_03_02_2022-620f5db8ebd40.pdf',
  source_note =
    'FIAT, listino italiano 3 febbraio 2022: Natural Power 70 CV, 4,1 kg/100 km WLTP. Nei listini MY23 non compare piu.',
  confidence = 'high',
  updated_at = now()
WHERE curated_version_id = 'panda-2012-ng-70-2021';

-- Mantiene riconoscibile la serie speciale senza duplicare il nome del motore.
UPDATE mvp.site_vehicle_version_curations_v1
SET
  commercial_name = '4x40',
  updated_at = now()
WHERE curated_version_id = 'panda-2012-petrol-85-4x40-2023';

-- Rimuove gli accorpamenti precedenti e rende il file idempotente.
DELETE FROM mvp.site_vehicle_version_curations_v1
WHERE curated_version_id IN (
  'panda-2012-petrol-85-2012-2021',
  'panda-2012-petrol-90-cross-2014-2020',
  'panda-2012-petrol-69-2012-2021',
  'panda-2012-lpg-69-2012-2023'
)
OR curated_version_id IN (
  SELECT curated_version_id
  FROM panda24_specs
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
  spec.fuel_type,
  'none',
  'combustion',
  spec.power_kw,
  spec.power_cv,
  spec.transmission_label,
  spec.gear_count,
  spec.commercial_name,
  'FIAT - schede tecniche e listini ufficiali',
  spec.source_url,
  spec.source_notes,
  spec.confidence,
  spec.display_order,
  true,
  now()
FROM panda24_specs AS spec
JOIN mvp.vehicle_profiles AS profile
  ON profile.source_type = spec.source_type
 AND profile.profile_status = 'active';

NOTIFY pgrst, 'reload schema';

-- Verifica unica: tutti i nuovi profili devono essere pubblicati, usare il
-- consumo previsto e restituire un TCO pronto.
WITH calculations AS (
  SELECT
    spec.curated_version_id,
    spec.consumption_per_100km,
    spec.commercial_name,
    version.calculation_vehicle_cluster_id,
    public.auto_tco_estimate(
      version.calculation_vehicle_cluster_id,
      15000,
      5,
      'italia'
    ) AS result
  FROM panda24_specs AS spec
  JOIN mvp.site_vehicle_version_curations_v1 AS version
    ON version.curated_version_id = spec.curated_version_id
), api_versions AS (
  SELECT item
  FROM jsonb_array_elements(
    public.auto_tco_versions('curated:fiat:panda-2012') -> 'items'
  ) AS item
), summary AS (
  SELECT
    (SELECT count(*) FROM panda24_specs)::integer AS versioni_corrette,
    count(*)::integer AS profili_collegati,
    count(*) FILTER (
      WHERE result #>> '{quality,status}' = 'ready'
        AND COALESCE(
          (result #>> '{monthly_costs,total_monthly_eur}')::numeric,
          0
        ) > 0
    )::integer AS calcoli_ready,
    count(*) FILTER (
      WHERE abs(
        (
          result
            #>> '{calculation_details,fuel_or_energy,thermal_consumption_per_100km}'
        )::numeric - consumption_per_100km
      ) > 0.001
    )::integer AS consumi_errati,
    count(*) FILTER (
      WHERE commercial_name IN ('4x2', '4x4', 'Cross 4x4')
    )::integer AS varianti_trazione,
    (
      SELECT count(*)::integer
      FROM api_versions
      WHERE item ->> 'commercial_name' IN ('4x2', '4x4', 'Cross 4x4')
        AND item ->> 'vehicle_cluster_id' IN (
          SELECT calculation_vehicle_cluster_id
          FROM calculations
        )
    ) AS varianti_esposte,
    (
      SELECT count(*)::integer
      FROM api_versions
      WHERE item ->> 'version_label' =
        '2021-2022 ' || chr(183) || ' Metano ' || chr(183) || ' 70 CV'
    ) AS natural_power_estesa,
    (
      SELECT count(*)::integer
      FROM mvp.site_vehicle_version_curations_v1
      WHERE curated_version_id IN (
        'panda-2012-petrol-85-2012-2021',
        'panda-2012-petrol-90-cross-2014-2020',
        'panda-2012-petrol-69-2012-2021',
        'panda-2012-lpg-69-2012-2023'
      )
    ) AS vecchi_accorpamenti
  FROM calculations
)
SELECT
  versioni_corrette,
  profili_collegati,
  calcoli_ready,
  consumi_errati,
  varianti_trazione,
  varianti_esposte,
  natural_power_estesa,
  vecchi_accorpamenti,
  CASE
    WHEN versioni_corrette = 11
      AND profili_collegati = 11
      AND calcoli_ready = 11
      AND consumi_errati = 0
      AND varianti_trazione = 6
      AND varianti_esposte = 6
      AND natural_power_estesa = 1
      AND vecchi_accorpamenti = 0
      THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM summary;

DO $verify$
DECLARE
  v_expected integer;
  v_linked integer;
  v_ready integer;
  v_wrong_consumption integer;
  v_old_rows integer;
  v_natural_power integer;
BEGIN
  SELECT count(*)::integer
  INTO v_expected
  FROM panda24_specs;

  WITH calculations AS (
    SELECT
      spec.consumption_per_100km,
      version.calculation_vehicle_cluster_id,
      public.auto_tco_estimate(
        version.calculation_vehicle_cluster_id,
        15000,
        5,
        'italia'
      ) AS result
    FROM panda24_specs AS spec
    JOIN mvp.site_vehicle_version_curations_v1 AS version
      ON version.curated_version_id = spec.curated_version_id
  )
  SELECT
    count(*)::integer,
    count(*) FILTER (
      WHERE result #>> '{quality,status}' = 'ready'
        AND COALESCE(
          (result #>> '{monthly_costs,total_monthly_eur}')::numeric,
          0
        ) > 0
    )::integer,
    count(*) FILTER (
      WHERE abs(
        (
          result
            #>> '{calculation_details,fuel_or_energy,thermal_consumption_per_100km}'
        )::numeric - consumption_per_100km
      ) > 0.001
    )::integer
  INTO v_linked, v_ready, v_wrong_consumption
  FROM calculations;

  SELECT count(*)::integer
  INTO v_old_rows
  FROM mvp.site_vehicle_version_curations_v1
  WHERE curated_version_id IN (
    'panda-2012-petrol-85-2012-2021',
    'panda-2012-petrol-90-cross-2014-2020',
    'panda-2012-petrol-69-2012-2021',
    'panda-2012-lpg-69-2012-2023'
  );

  SELECT count(*)::integer
  INTO v_natural_power
  FROM jsonb_array_elements(
    public.auto_tco_versions('curated:fiat:panda-2012') -> 'items'
  ) AS item
  WHERE item ->> 'version_label' =
    '2021-2022 ' || chr(183) || ' Metano ' || chr(183) || ' 70 CV';

  IF v_expected <> 11
    OR v_linked <> 11
    OR v_ready <> 11
    OR v_wrong_consumption <> 0
    OR v_old_rows <> 0
    OR v_natural_power <> 1
  THEN
    RAISE EXCEPTION
      'Verifica Panda benzina/GPL fallita: attese %, collegate %, ready %, consumi errati %, vecchie %, Natural Power %',
      v_expected,
      v_linked,
      v_ready,
      v_wrong_consumption,
      v_old_rows,
      v_natural_power;
  END IF;
END;
$verify$;

COMMIT;
