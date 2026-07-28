-- Auto TCO - completa e compatta la gamma Fiat Panda.
--
-- Decisioni di prodotto:
--   * nel menu modelli rimane un solo elemento "Panda";
--   * Grande Panda resta un modello separato;
--   * le generazioni della Panda sono distinguibili dagli anni nella versione;
--   * le motorizzazioni EEA spurie non vengono esposte come versioni commerciali;
--   * ogni versione pubblicata conserva un vero cluster di calcolo.
--
-- Fonti principali:
--   * documentazione tecnica e comunicati ufficiali FIAT/Stellantis;
--   * guide CO2 MIMIT;
--   * manuale tecnico FIAT Panda 169 del 2009.

\set ON_ERROR_STOP on

BEGIN;

SET LOCAL statement_timeout = '15min';

CREATE TEMP TABLE panda22_specs (
  curated_version_id text PRIMARY KEY,
  public_model_id text NOT NULL,
  year_from integer NOT NULL,
  year_to integer NOT NULL,
  fuel_type text NOT NULL,
  hybrid_type text NOT NULL,
  powertrain_type text NOT NULL,
  display_power_kw numeric,
  display_power_cv integer,
  calculation_target_cv integer NOT NULL,
  max_power_delta_cv integer NOT NULL,
  transmission_label text,
  gear_count integer,
  commercial_name text,
  preferred_year integer NOT NULL,
  source_name text NOT NULL,
  source_url text NOT NULL,
  source_note text,
  confidence text NOT NULL,
  display_order integer NOT NULL,
  is_required boolean NOT NULL
) ON COMMIT DROP;

INSERT INTO panda22_specs (
  curated_version_id,
  public_model_id,
  year_from,
  year_to,
  fuel_type,
  hybrid_type,
  powertrain_type,
  display_power_kw,
  display_power_cv,
  calculation_target_cv,
  max_power_delta_cv,
  transmission_label,
  gear_count,
  commercial_name,
  preferred_year,
  source_name,
  source_url,
  source_note,
  confidence,
  display_order,
  is_required
)
VALUES
  (
    'panda-2003-petrol-54-2003-2010',
    'curated:fiat:panda-2012',
    2003, 2010,
    'petrol', 'none', 'combustion',
    40, 54,
    54, 2,
    'Manuale', 5,
    '1.1 FIRE',
    2007,
    'FIAT - manuale tecnico Panda 169',
    'https://elearneditor.fiat.com/naselearnprod/IT/00/169_PANDA/00_169_PANDA_603.81.647_IT_01_09.09_L_LG/00_169_PANDA_603.81.647_IT_01_09.09_L_LG.pdf',
    'Il manuale FIAT del 2009 conferma motore 1.1, 40 kW e 54 CV; FIAT include ancora motorizzazioni da 54 CV nella gamma 2010.',
    'high', 210, true
  ),
  (
    'panda-2003-petrol-60-2003-2010',
    'curated:fiat:panda-2012',
    2003, 2010,
    'petrol', 'none', 'combustion',
    44, 60,
    60, 2,
    'Manuale o Dualogic', 5,
    '1.2 FIRE',
    2007,
    'FIAT - manuale tecnico Panda 169',
    'https://elearneditor.fiat.com/naselearnprod/IT/00/169_PANDA/00_169_PANDA_603.81.647_IT_01_09.09_L_LG/00_169_PANDA_603.81.647_IT_01_09.09_L_LG.pdf',
    'Il manuale FIAT del 2009 conferma motore 1.2 Euro 4, 44 kW e 60 CV.',
    'high', 220, true
  ),
  (
    'panda-2003-petrol-69-2009-2012',
    'curated:fiat:panda-2012',
    2009, 2012,
    'petrol', 'none', 'combustion',
    51, 69,
    69, 3,
    'Manuale o Dualogic', 5,
    '1.2 FIRE Euro 5',
    2011,
    'FIAT - Panda Model Year 2009 e Panda Classic',
    'https://www.media.stellantis.com/it-it/fiat/press/panda-2009-un-look-rinnovato-per-il-leader-del-segmento',
    'FIAT introduce il 1.2 da 69 CV con la gamma 2009; Panda Classic resta ordinabile nel 2012.',
    'high', 230, true
  ),
  (
    'panda-2003-diesel-70-2004-2010',
    'curated:fiat:panda-2012',
    2004, 2010,
    'diesel', 'none', 'combustion',
    51, 70,
    70, 3,
    'Manuale', 5,
    '1.3 Multijet',
    2007,
    'FIAT - gamma Panda e manuale tecnico Panda 169',
    'https://www.media.stellantis.com/it-it/fiat/press/fiat-panda-4x4-adventure-la-nuova-versione-off-road-pronta-a-tutto',
    'Il Multijet arriva nel 2004; FIAT conferma ancora la versione da 70 CV nella gamma 4x4 del 2009.',
    'medium_high', 240, true
  ),
  (
    'panda-2003-diesel-75-2006-2012',
    'curated:fiat:panda-2012',
    2006, 2012,
    'diesel', 'none', 'combustion',
    55, 75,
    75, 3,
    'Manuale', 5,
    '1.3 Multijet',
    2010,
    'FIAT - manuale tecnico Panda 169 e Panda Classic',
    'https://www.media.stellantis.com/it-it/fiat/press/al-via-gli-ordini-di-fiat-panda-classic',
    'Il manuale FIAT riporta 55 kW/75 CV; la versione è confermata sulla Panda Classic del 2012.',
    'high', 250, true
  ),
  (
    'panda-2003-petrol-100-2006-2010',
    'curated:fiat:panda-2012',
    2006, 2010,
    'petrol', 'none', 'combustion',
    74, 100,
    100, 3,
    'Manuale', 6,
    '1.4 FIRE 16V 100 HP',
    2008,
    'FIAT - Panda 100 HP',
    'https://www.media.stellantis.com/it-it/fiat/press/buon-compleanno-panda-quarant-anni-di-successi-raccontati-dai-suoi-protagonisti',
    'FIAT colloca il debutto della Panda 100 HP nel 2006 e conferma il motore 1.4 da 100 CV.',
    'high', 260, true
  ),
  (
    'panda-2003-lpg-60-2009-2010',
    'curated:fiat:panda-2012',
    2009, 2010,
    'lpg', 'none', 'combustion',
    44, 60,
    60, 3,
    'Manuale', 5,
    '1.2 GPL',
    2010,
    'FIAT - lancio gamma GPL 2009',
    'https://www.media.stellantis.com/it-it/fiat/press/grande-punto-bravo-e-panda-nasce-l-offerta-fiat-alimentata-a-gpl-e-benzina',
    'FIAT presenta nel gennaio 2009 la Panda GPL con motore 1.2 da 60 CV.',
    'high', 270, true
  ),
  (
    'panda-2003-lpg-69-2010-2012',
    'curated:fiat:panda-2012',
    2010, 2012,
    'lpg', 'none', 'combustion',
    51, 69,
    69, 3,
    'Manuale', 5,
    '1.2 GPL Euro 5',
    2011,
    'FIAT - gamma Panda 169 Euro 5',
    'https://www.media.stellantis.com/it-it/download-model-document/94',
    'La scheda tecnica FIAT distingue la successiva motorizzazione GPL da 69 CV.',
    'medium_high', 280, true
  ),
  (
    'panda-2003-ng-60-2006-2010',
    'curated:fiat:panda-2012',
    2006, 2010,
    'ng', 'none', 'combustion',
    44, 60,
    60, 2,
    'Manuale', 5,
    '1.2 FIRE Natural Power',
    2008,
    'FIAT - storia ufficiale Panda',
    'https://www.media.stellantis.com/it-it/fiat/press/buon-compleanno-panda-quarant-anni-di-successi-raccontati-dai-suoi-protagonisti',
    'FIAT colloca nel 2006 il debutto della Panda Natural Power con motore 1.2 FIRE.',
    'medium_high', 290, false
  ),
  (
    'panda-2003-ng-70-2010-2012',
    'curated:fiat:panda-2012',
    2010, 2012,
    'ng', 'none', 'combustion',
    51, 70,
    70, 3,
    'Manuale', 5,
    '1.4 FIRE Natural Power Euro 5',
    2011,
    'FIAT - gamma Natural Power 2011',
    'https://www.media.stellantis.com/it-it/fiat/press/fiat-egrave-golden-sponsor-di-mobilitytech-2011',
    'FIAT riporta 70 CV a metano per il propulsore bi-fuel Euro 5.',
    'medium_high', 300, false
  ),
  (
    'panda-2012-hybrid-65-2025-2026',
    'curated:fiat:panda-2012',
    2025, 2026,
    'petrol', 'hybrid', 'hybrid',
    48, 65,
    68, 4,
    'Manuale', 6,
    '1.0 FireFly mild hybrid Panda/Pandina',
    2025,
    'FIAT - gamma Panda e Pandina',
    'https://www.media.stellantis.com/it-it/fiat/press/la-gamma-panda-si-rinnova-e-si-completa',
    'La gamma italiana corrente indica esplicitamente Pandina 1.0 65 CV Hybrid.',
    'high', 105, true
  ),
  (
    'grande-panda-hybrid-110-2025-2026',
    'curated:fiat:grande-panda',
    2025, 2026,
    'petrol', 'hybrid', 'hybrid',
    81, 110,
    100, 8,
    'Automatico eDCT', 6,
    '1.2 T-Gen3 Hybrid 48V',
    2025,
    'FIAT - scheda tecnica Grande Panda ibrida',
    'https://www.fiat.it/content/dam/fiat2023/it/trimcomparison/grande-panda/hybrid/Scheda_Comparativa_Grande_Panda_Ibrida_MY26_ITA.pdf',
    '110 CV è la potenza combinata commerciale; il termico eroga 100 CV ed è il riferimento usato per trovare il cluster di calcolo.',
    'high', 20, true
  ),
  (
    'grande-panda-petrol-100-2026',
    'curated:fiat:grande-panda',
    2026, 2026,
    'petrol', 'none', 'combustion',
    74, 100,
    100, 8,
    'Manuale', 6,
    '1.2 T-Gen3 Turbo',
    2025,
    'FIAT - gamma Grande Panda benzina',
    'https://www.fiat.it/mondo-fiat/news/fiat-annuncia-grande-panda-benzina',
    'FIAT dichiara 100 CV, 205 Nm e cambio manuale a 6 marce.',
    'high', 30, true
  );

-- Tutte le generazioni con nome commerciale Panda restano nello stesso modello.
-- Dal 2003 in avanti vengono però sostituite dalle versioni curate, così le
-- combinazioni EEA spurie non ricompaiono nel menu.
UPDATE mvp.site_vehicle_model_curations_v1
SET
  replace_source_year_from = 2003,
  replace_source_year_to = 2100,
  include_uncurated_source_versions = true,
  source_name = 'FIAT/Stellantis + MIMIT + ADEME',
  source_url = 'https://www.media.stellantis.com/it-it/fiat',
  confidence = 'medium_high',
  updated_at = now()
WHERE public_model_id = 'curated:fiat:panda-2012';

-- La versione da 65 CV sostituisce nella gamma corrente la precedente
-- denominazione commerciale Hybrid da 70 CV.
UPDATE mvp.site_vehicle_version_curations_v1
SET
  year_to = 2024,
  source_note = 'Versione mild hybrid da 70 CV commercializzata prima dell aggiornamento di gamma a 65 CV.',
  updated_at = now()
WHERE curated_version_id = 'panda-2012-hybrid-70-2020-2025';

-- La Grande Panda elettrica è ancora a listino nel 2026.
UPDATE mvp.site_vehicle_version_curations_v1
SET
  year_to = 2026,
  source_name = 'FIAT - gamma Grande Panda',
  source_url = 'https://www.fiat.it/modello/grande-panda-elettrica',
  source_note = 'Versione elettrica da 83 kW/113 CV, distinta da Grande Panda ibrida e benzina.',
  confidence = 'high',
  updated_at = now()
WHERE curated_version_id = 'grande-panda-electric-113-2025';

-- La Grande Panda Hybrid non compare ancora come cluster tecnico autonomo nel
-- dataset EEA disponibile: i soli cluster ibridi associati a "Panda" sono le
-- Panda/Pandina da 71 CV. Per evitare un collegamento tecnicamente scorretto,
-- viene creato un profilo dedicato usando esclusivamente dati FIAT ufficiali.
-- La potenza del profilo è quella del motore termico (usata per il bollo);
-- nella versione commerciale restano esposti i 110 CV combinati.
DO $grande_panda_hybrid$
DECLARE
  v_profile_id integer;
  v_seed_model_id integer;
  v_brand_factor numeric;
BEGIN
  SELECT min(catalog.seed_model_id)
  INTO v_seed_model_id
  FROM mvp.site_vehicle_catalog_publishable_v1 AS catalog
  JOIN mvp.site_vehicle_model_curations_v1 AS curation
    ON curation.source_model_catalog_id = catalog.model_catalog_id
  WHERE curation.public_model_id = 'curated:fiat:grande-panda'
    AND catalog.seed_model_id IS NOT NULL;

  IF v_seed_model_id IS NULL THEN
    RAISE EXCEPTION
      'Impossibile creare il profilo Grande Panda Hybrid: seed model assente';
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

  SELECT profile.id
  INTO v_profile_id
  FROM mvp.vehicle_profiles AS profile
  WHERE profile.source_type = 'fiat_official_grande_panda_hybrid_2026'
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
      uncertainty_profile_kind
    )
    VALUES (
      'Fiat Grande Panda 2025-2026 · Ibrida benzina · 110 CV',
      'Fiat',
      'Grande Panda',
      2026,
      2025,
      2026,
      'petrol',
      'hybrid',
      74,
      100,
      'B',
      'crossover',
      'mainstream',
      5.05,
      'high',
      'FIAT: scheda tecnica MY26 e listino italiano del 1 maggio 2026. Potenza combinata 81 kW/110 CV; termico 74 kW/100 CV; consumo WLTP 5,0-5,1 l/100 km; Euro 6e-bis; prezzo rappresentativo ICON 21.400 euro.',
      v_seed_model_id,
      'curated_commercial_profile_v1',
      'fiat_official_grande_panda_hybrid_2026',
      2,
      0,
      'active',
      6,
      21400,
      'city_utilitaria',
      v_brand_factor,
      'Prezzo chiavi in mano della versione ICON dal listino FIAT del 1 maggio 2026; svalutazione calcolata dalla curva interna trasparente per utilitarie e dal fattore mediano FIAT.',
      'official_specs_internal_depreciation_curve'
    )
    RETURNING id INTO v_profile_id;
  ELSE
    UPDATE mvp.vehicle_profiles
    SET
      display_name =
        'Fiat Grande Panda 2025-2026 · Ibrida benzina · 110 CV',
      brand = 'Fiat',
      model = 'Grande Panda',
      representative_year = 2026,
      year_from = 2025,
      year_to = 2026,
      fuel_type = 'petrol',
      hybrid_type = 'hybrid',
      power_kw = 74,
      power_cv = 100,
      segment = 'B',
      body_type = 'crossover',
      brand_tier = 'mainstream',
      consumption_l_100km = 5.05,
      confidence = 'high',
      source_notes =
        'FIAT: scheda tecnica MY26 e listino italiano del 1 maggio 2026. Potenza combinata 81 kW/110 CV; termico 74 kW/100 CV; consumo WLTP 5,0-5,1 l/100 km; Euro 6e-bis; prezzo rappresentativo ICON 21.400 euro.',
      seed_model_id = v_seed_model_id,
      profile_kind = 'curated_commercial_profile_v1',
      source_records_count = 2,
      popularity_score = 0,
      profile_status = 'active',
      euro_class = 6,
      estimated_new_price_eur = 21400,
      depreciation_category = 'city_utilitaria',
      depreciation_brand_factor = v_brand_factor,
      depreciation_notes =
        'Prezzo chiavi in mano della versione ICON dal listino FIAT del 1 maggio 2026; svalutazione calcolata dalla curva interna trasparente per utilitarie e dal fattore mediano FIAT.',
      uncertainty_profile_kind =
        'official_specs_internal_depreciation_curve'
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
    5.05,
    NULL,
    'fiat_official_wltp_2026',
    NULL,
    2,
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
END;
$grande_panda_hybrid$;

-- Rende la migrazione ripetibile e rimuove eventuali versioni parziali create
-- da una precedente esecuzione.
DELETE FROM mvp.site_vehicle_version_curations_v1
WHERE curated_version_id IN (
  SELECT curated_version_id
  FROM panda22_specs
);

WITH resolved AS (
  SELECT
    spec.*,
    candidate.vehicle_cluster_id AS calculation_vehicle_cluster_id
  FROM panda22_specs AS spec
  JOIN mvp.site_vehicle_model_curations_v1 AS source_model
    ON source_model.public_model_id = spec.public_model_id
  LEFT JOIN LATERAL (
    SELECT catalog.*
    FROM mvp.site_vehicle_catalog_publishable_v1 AS catalog
    WHERE catalog.model_catalog_id = source_model.source_model_catalog_id
      AND catalog.fuel_type = spec.fuel_type
      AND COALESCE(catalog.hybrid_type, 'none') = spec.hybrid_type
      AND catalog.power_cv IS NOT NULL
      AND catalog.energy_data_status = 'ready'
      AND catalog.depreciation_data_status <> 'missing'
      AND abs(
        round(catalog.power_cv)::integer - spec.calculation_target_cv
      ) <= spec.max_power_delta_cv
      AND (
        spec.is_required
        OR abs(
          COALESCE(catalog.representative_year, spec.preferred_year)
            - spec.preferred_year
        ) <= 3
      )
    ORDER BY
      abs(round(catalog.power_cv)::integer - spec.calculation_target_cv),
      abs(
        COALESCE(catalog.representative_year, spec.preferred_year)
          - spec.preferred_year
      ),
      CASE WHEN catalog.energy_data_status = 'ready' THEN 0 ELSE 1 END,
      CASE
        WHEN catalog.depreciation_data_status <> 'missing' THEN 0
        ELSE 1
      END,
      catalog.registrations_count DESC,
      catalog.vehicle_cluster_id
    LIMIT 1
  ) AS candidate ON true
)
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
  curated_version_id,
  public_model_id,
  calculation_vehicle_cluster_id,
  year_from,
  year_to,
  fuel_type,
  hybrid_type,
  powertrain_type,
  display_power_kw,
  display_power_cv,
  transmission_label,
  gear_count,
  commercial_name,
  source_name,
  source_url,
  source_note,
  confidence,
  display_order,
  true,
  now()
FROM resolved
WHERE calculation_vehicle_cluster_id IS NOT NULL;

NOTIFY pgrst, 'reload schema';

-- Verifica unica: copertura commerciale, assenza delle vecchie righe spurie
-- e funzionamento del TCO per ogni nuova versione collegata.
WITH models AS (
  SELECT item
  FROM jsonb_array_elements(
    public.auto_tco_models('FIAT') -> 'items'
  ) AS item
), model_ids AS (
  SELECT
    item ->> 'model' AS model,
    item ->> 'model_catalog_id' AS model_id
  FROM models
  WHERE item ->> 'model' IN ('Panda', 'Grande Panda')
), versions AS (
  SELECT
    model_ids.model,
    item
  FROM model_ids
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(model_ids.model_id) -> 'items'
  ) AS item
), linked_specs AS (
  SELECT
    spec.*,
    version.calculation_vehicle_cluster_id
  FROM panda22_specs AS spec
  LEFT JOIN mvp.site_vehicle_version_curations_v1 AS version
    ON version.curated_version_id = spec.curated_version_id
), calculations AS (
  SELECT
    linked_specs.curated_version_id,
    public.auto_tco_estimate(
      linked_specs.calculation_vehicle_cluster_id,
      15000,
      5,
      'italia'
    ) AS result
  FROM linked_specs
  WHERE linked_specs.calculation_vehicle_cluster_id IS NOT NULL
), summary AS (
  SELECT
    (SELECT count(*) FROM versions WHERE model = 'Panda')::integer
      AS versioni_panda,
    (SELECT count(*) FROM versions WHERE model = 'Grande Panda')::integer
      AS versioni_grande_panda,
    (
      SELECT count(*)
      FROM versions
      WHERE model = 'Panda'
        AND item ->> 'year_source' = 'curated_commercial_catalog'
    )::integer AS panda_curate,
    (
      SELECT count(*)
      FROM versions
      WHERE model = 'Panda'
        AND item ->> 'year_source' <> 'curated_commercial_catalog'
        AND (item ->> 'year_from')::integer >= 2003
    )::integer AS righe_automatiche_panda_dal_2003,
    (
      SELECT count(*)
      FROM versions
      WHERE model = 'Panda'
        AND (
          item ->> 'fuel_type' = 'electric'
          OR item ->> 'version_label' ~
            '(68|71|86|101) CV$'
        )
        AND (item ->> 'year_from')::integer >= 2003
    )::integer AS anomalie_panda,
    (
      SELECT count(*)
      FROM linked_specs
      WHERE calculation_vehicle_cluster_id IS NOT NULL
    )::integer AS nuove_versioni_collegate,
    (
      SELECT count(*)
      FROM linked_specs
      WHERE is_required
        AND calculation_vehicle_cluster_id IS NULL
    )::integer AS versioni_obbligatorie_mancanti,
    (
      SELECT count(*)
      FROM linked_specs
      WHERE NOT is_required
        AND calculation_vehicle_cluster_id IS NULL
    )::integer AS versioni_metano_da_integrare,
    (
      SELECT count(*)
      FROM calculations
      WHERE result #>> '{quality,status}' = 'ready'
        AND COALESCE(
          (result #>> '{monthly_costs,total_monthly_eur}')::numeric,
          0
        ) > 0
    )::integer AS nuovi_calcoli_ready,
    (
      SELECT count(*)
      FROM versions
      WHERE model = 'Grande Panda'
        AND item ->> 'fuel_type' = 'electric'
    )::integer AS grande_panda_elettrica,
    (
      SELECT count(*)
      FROM versions
      WHERE model = 'Grande Panda'
        AND item ->> 'hybrid_type' = 'hybrid'
    )::integer AS grande_panda_ibrida,
    (
      SELECT count(*)
      FROM versions
      WHERE model = 'Grande Panda'
        AND item ->> 'fuel_type' = 'petrol'
        AND item ->> 'hybrid_type' = 'none'
    )::integer AS grande_panda_benzina,
    (
      SELECT count(*)
      FROM mvp.vehicle_profiles AS profile
      WHERE profile.source_type =
        'fiat_official_grande_panda_hybrid_2026'
        AND profile.profile_status = 'active'
        AND profile.power_kw = 74
        AND profile.power_cv = 100
        AND profile.consumption_l_100km = 5.05
        AND profile.estimated_new_price_eur = 21400
    )::integer AS profilo_ibrido_ufficiale,
    (
      SELECT count(*)
      FROM linked_specs
      WHERE curated_version_id =
        'grande-panda-hybrid-110-2025-2026'
        AND calculation_vehicle_cluster_id ~ '^profile:[0-9]+$'
    )::integer AS ibrida_collegata_al_profilo
)
SELECT
  versioni_panda,
  versioni_grande_panda,
  panda_curate,
  righe_automatiche_panda_dal_2003,
  anomalie_panda,
  nuove_versioni_collegate,
  versioni_obbligatorie_mancanti,
  versioni_metano_da_integrare,
  nuovi_calcoli_ready,
  grande_panda_elettrica,
  grande_panda_ibrida,
  grande_panda_benzina,
  profilo_ibrido_ufficiale,
  ibrida_collegata_al_profilo,
  CASE
    WHEN versioni_panda >= 19
      AND versioni_grande_panda = 3
      AND panda_curate = versioni_panda
      AND righe_automatiche_panda_dal_2003 = 0
      AND anomalie_panda = 0
      AND versioni_obbligatorie_mancanti = 0
      AND nuovi_calcoli_ready = nuove_versioni_collegate
      AND grande_panda_elettrica = 1
      AND grande_panda_ibrida = 1
      AND grande_panda_benzina = 1
      AND profilo_ibrido_ufficiale = 1
      AND ibrida_collegata_al_profilo = 1
      THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM summary;

DO $verify$
DECLARE
  v_required_missing integer;
  v_panda jsonb;
  v_grande_panda jsonb;
  v_panda_count integer;
  v_panda_uncurated integer;
  v_grande_count integer;
  v_official_profile_count integer;
  v_hybrid_cluster_id text;
  v_calculation record;
BEGIN
  SELECT count(*)::integer
  INTO v_required_missing
  FROM panda22_specs AS spec
  LEFT JOIN mvp.site_vehicle_version_curations_v1 AS version
    ON version.curated_version_id = spec.curated_version_id
  WHERE spec.is_required
    AND version.calculation_vehicle_cluster_id IS NULL;

  IF v_required_missing <> 0 THEN
    RAISE EXCEPTION
      'Catalogo Panda non applicato: mancano % profili obbligatori',
      v_required_missing;
  END IF;

  v_panda := public.auto_tco_versions('curated:fiat:panda-2012');
  v_grande_panda := public.auto_tco_versions('curated:fiat:grande-panda');

  SELECT
    count(*)::integer,
    count(*) FILTER (
      WHERE item ->> 'year_source' <> 'curated_commercial_catalog'
        AND (item ->> 'year_from')::integer >= 2003
    )::integer
  INTO v_panda_count, v_panda_uncurated
  FROM jsonb_array_elements(v_panda -> 'items') AS item;

  SELECT count(*)::integer
  INTO v_grande_count
  FROM jsonb_array_elements(v_grande_panda -> 'items') AS item;

  IF v_panda_count < 19
    OR v_panda_uncurated <> 0
    OR v_grande_count <> 3
  THEN
    RAISE EXCEPTION
      'Verifica catalogo fallita: Panda %, automatiche %, Grande Panda %',
      v_panda_count,
      v_panda_uncurated,
      v_grande_count;
  END IF;

  SELECT count(*)::integer
  INTO v_official_profile_count
  FROM mvp.vehicle_profiles AS profile
  WHERE profile.source_type =
      'fiat_official_grande_panda_hybrid_2026'
    AND profile.profile_status = 'active'
    AND profile.power_kw = 74
    AND profile.power_cv = 100
    AND profile.consumption_l_100km = 5.05
    AND profile.estimated_new_price_eur = 21400;

  SELECT version.calculation_vehicle_cluster_id
  INTO v_hybrid_cluster_id
  FROM mvp.site_vehicle_version_curations_v1 AS version
  WHERE version.curated_version_id =
    'grande-panda-hybrid-110-2025-2026';

  IF v_official_profile_count <> 1
    OR v_hybrid_cluster_id !~ '^profile:[0-9]+$'
  THEN
    RAISE EXCEPTION
      'Grande Panda Hybrid non collegata al profilo FIAT ufficiale: profili %, id %',
      v_official_profile_count,
      v_hybrid_cluster_id;
  END IF;

  FOR v_calculation IN
    SELECT
      version.curated_version_id,
      public.auto_tco_estimate(
        version.calculation_vehicle_cluster_id,
        15000,
        5,
        'italia'
      ) AS result
    FROM mvp.site_vehicle_version_curations_v1 AS version
    WHERE version.curated_version_id IN (
      SELECT curated_version_id
      FROM panda22_specs
      WHERE is_required
    )
  LOOP
    IF v_calculation.result #>> '{quality,status}' <> 'ready'
      OR COALESCE(
        (v_calculation.result
          #>> '{monthly_costs,total_monthly_eur}')::numeric,
        0
      ) <= 0
    THEN
      RAISE EXCEPTION
        'Calcolo Panda non valido per %',
        v_calculation.curated_version_id;
    END IF;
  END LOOP;
END;
$verify$;

COMMIT;
