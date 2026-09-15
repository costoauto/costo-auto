\pset pager off

-- Auto TCO - Passo 1: identita commerciale e regressioni bloccanti.
--
-- Questa migrazione:
--   1. assegna profili autonomi e documentati a Panda 100 HP e
--      Grande Panda benzina;
--   2. blocca dalla pubblicazione quattro versioni temporalmente impossibili;
--   3. rende univoco ogni display_variant_id nel catalogo pubblicato;
--   4. aggiunge una RPC che valida l'intera selezione modello/versione/profilo;
--   5. corregge la decorrenza delle riduzioni del superbollo.
--
-- I profili e le osservazioni sorgente non vengono cancellati.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

-- -------------------------------------------------------------------------
-- 1. Panda 100 HP e Grande Panda benzina: profili autonomi e documentati.
-- -------------------------------------------------------------------------

DO $panda_100_hp$
DECLARE
  v_profile_id integer;
  v_seed_model_id integer;
  v_brand_factor numeric;
  v_updated integer;
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
      'Impossibile creare il profilo Panda 100 HP: seed model assente';
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
  WHERE profile.source_type = 'fiat_official_panda_100_hp_2006'
     OR (
       profile.seed_model_id = v_seed_model_id
       AND profile.representative_year = 2008
       AND profile.fuel_type = 'petrol'
       AND COALESCE(profile.hybrid_type, 'none') = 'none'
       AND profile.power_kw = 74
       AND profile.power_cv = 100
       AND profile.profile_kind = 'curated_commercial_profile_v1'
       AND profile.profile_status = 'active'
     )
  ORDER BY
    CASE
      WHEN profile.source_type = 'fiat_official_panda_100_hp_2006'
        THEN 0
      ELSE 1
    END,
    profile.id
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
      'Fiat Panda 2006-2010 · Benzina · 100 CV',
      'Fiat',
      'Panda',
      2008,
      2006,
      2010,
      'petrol',
      'none',
      74,
      100,
      'A',
      'hatchback',
      'mainstream',
      6.5,
      'medium_high',
      'FIAT documenta il debutto nel model year 2007, il 1.4 16V da 100 CV, il cambio manuale a 6 marce e 6,5 l/100 km combinati. MotorBox documenta il prezzo italiano di 13.400 euro chiavi in mano. I 74 kW sono la conversione normalizzata della potenza commerciale di 100 CV.',
      v_seed_model_id,
      'curated_commercial_profile_v1',
      'fiat_official_panda_100_hp_2006',
      2,
      0,
      'active',
      4,
      13400,
      'city_utilitaria',
      v_brand_factor,
      'Prezzo italiano contemporaneo documentato; svalutazione calcolata con la curva interna per utilitarie e il fattore mediano FIAT.',
      'official_specs_internal_depreciation_curve',
      'fiat_official_nedc_2006',
      'high'
    )
    RETURNING id INTO v_profile_id;
  ELSE
    UPDATE mvp.vehicle_profiles
    SET
      display_name = 'Fiat Panda 2006-2010 · Benzina · 100 CV',
      brand = 'Fiat',
      model = 'Panda',
      representative_year = 2008,
      year_from = 2006,
      year_to = 2010,
      fuel_type = 'petrol',
      hybrid_type = 'none',
      power_kw = 74,
      power_cv = 100,
      segment = 'A',
      body_type = 'hatchback',
      brand_tier = 'mainstream',
      consumption_l_100km = 6.5,
      confidence = 'medium_high',
      source_notes =
        'FIAT documenta il debutto nel model year 2007, il 1.4 16V da 100 CV, il cambio manuale a 6 marce e 6,5 l/100 km combinati. MotorBox documenta il prezzo italiano di 13.400 euro chiavi in mano. I 74 kW sono la conversione normalizzata della potenza commerciale di 100 CV.',
      seed_model_id = v_seed_model_id,
      profile_kind = 'curated_commercial_profile_v1',
      source_type = 'fiat_official_panda_100_hp_2006',
      source_records_count = 2,
      profile_status = 'active',
      euro_class = 4,
      estimated_new_price_eur = 13400,
      depreciation_category = 'city_utilitaria',
      depreciation_brand_factor = v_brand_factor,
      depreciation_notes =
        'Prezzo italiano contemporaneo documentato; svalutazione calcolata con la curva interna per utilitarie e il fattore mediano FIAT.',
      uncertainty_profile_kind =
        'official_specs_internal_depreciation_curve',
      energy_input_source = 'fiat_official_nedc_2006',
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
    6.5,
    NULL,
    'fiat_official_nedc_2006',
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
    electric_consumption_kwh_100km = NULL,
    thermal_method = EXCLUDED.thermal_method,
    electric_method = NULL,
    thermal_reference_count = EXCLUDED.thermal_reference_count,
    electric_reference_count = 0,
    input_status = 'ready',
    confidence = 'high',
    built_at = now();

  UPDATE mvp.site_vehicle_version_curations_v1
  SET
    calculation_vehicle_cluster_id = 'profile:' || v_profile_id::text,
    source_name = 'FIAT/Stellantis + MotorBox',
    source_url =
      'https://www.media.stellantis.com/de-de/fiat/press/fiat-auf-dem-pariser-automobilsalon-2006-aktuelle-neuheiten-stehen-im-mittelpunkt-des-auftritts-an-der-seine-panda-familie-erhalt-sportlichen-und-umweltfreundlichen-zuwachs',
    source_note =
      'Profilo autonomo: 1.4 16V 100 CV, cambio manuale a 6 marce, consumo combinato omologato 6,5 l/100 km e prezzo italiano contemporaneo 13.400 euro.',
    confidence = 'high',
    updated_at = now()
  WHERE curated_version_id = 'panda-2003-petrol-100-2006-2010';

  GET DIAGNOSTICS v_updated = ROW_COUNT;
  IF v_updated <> 1 THEN
    RAISE EXCEPTION
      'Curatela Panda 100 HP assente o duplicata: % righe',
      v_updated;
  END IF;
END;
$panda_100_hp$;

DO $grande_panda_petrol$
DECLARE
  v_profile_id integer;
  v_seed_model_id integer;
  v_brand_factor numeric;
  v_updated integer;
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
      'Impossibile creare il profilo Grande Panda benzina: seed model assente';
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
  WHERE profile.source_type = 'fiat_official_grande_panda_petrol_2026'
     OR (
       profile.seed_model_id = v_seed_model_id
       AND profile.representative_year = 2026
       AND profile.fuel_type = 'petrol'
       AND COALESCE(profile.hybrid_type, 'none') = 'none'
       AND profile.power_kw = 74
       AND profile.power_cv = 100
       AND profile.profile_kind = 'curated_commercial_profile_v1'
       AND profile.profile_status = 'active'
     )
  ORDER BY
    CASE
      WHEN profile.source_type = 'fiat_official_grande_panda_petrol_2026'
        THEN 0
      ELSE 1
    END,
    profile.id
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
      'Fiat Grande Panda 2026 · Benzina · 100 CV',
      'Fiat',
      'Grande Panda',
      2026,
      2026,
      2026,
      'petrol',
      'none',
      74,
      100,
      'B',
      'crossover',
      'mainstream',
      5.65,
      'medium_high',
      'FIAT: 1.2 turbo tre cilindri, 74 kW/100 CV, 205 Nm, cambio manuale a 6 marce, consumo WLTP 5,6-5,7 l/100 km e listino POP 17.900 euro a maggio 2026. Classe Euro 6 derivata dalla data di commercializzazione.',
      v_seed_model_id,
      'curated_commercial_profile_v1',
      'fiat_official_grande_panda_petrol_2026',
      1,
      0,
      'active',
      6,
      17900,
      'city_utilitaria',
      v_brand_factor,
      'Prezzo di listino FIAT POP di maggio 2026, senza promozioni; svalutazione calcolata con la curva interna per utilitarie e il fattore mediano FIAT.',
      'official_specs_internal_depreciation_curve',
      'fiat_official_wltp_2026',
      'high'
    )
    RETURNING id INTO v_profile_id;
  ELSE
    UPDATE mvp.vehicle_profiles
    SET
      display_name = 'Fiat Grande Panda 2026 · Benzina · 100 CV',
      brand = 'Fiat',
      model = 'Grande Panda',
      representative_year = 2026,
      year_from = 2026,
      year_to = 2026,
      fuel_type = 'petrol',
      hybrid_type = 'none',
      power_kw = 74,
      power_cv = 100,
      segment = 'B',
      body_type = 'crossover',
      brand_tier = 'mainstream',
      consumption_l_100km = 5.65,
      confidence = 'medium_high',
      source_notes =
        'FIAT: 1.2 turbo tre cilindri, 74 kW/100 CV, 205 Nm, cambio manuale a 6 marce, consumo WLTP 5,6-5,7 l/100 km e listino POP 17.900 euro a maggio 2026. Classe Euro 6 derivata dalla data di commercializzazione.',
      seed_model_id = v_seed_model_id,
      profile_kind = 'curated_commercial_profile_v1',
      source_type = 'fiat_official_grande_panda_petrol_2026',
      source_records_count = 1,
      profile_status = 'active',
      euro_class = 6,
      estimated_new_price_eur = 17900,
      depreciation_category = 'city_utilitaria',
      depreciation_brand_factor = v_brand_factor,
      depreciation_notes =
        'Prezzo di listino FIAT POP di maggio 2026, senza promozioni; svalutazione calcolata con la curva interna per utilitarie e il fattore mediano FIAT.',
      uncertainty_profile_kind =
        'official_specs_internal_depreciation_curve',
      energy_input_source = 'fiat_official_wltp_2026',
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
    5.65,
    NULL,
    'fiat_official_wltp_2026',
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
    electric_consumption_kwh_100km = NULL,
    thermal_method = EXCLUDED.thermal_method,
    electric_method = NULL,
    thermal_reference_count = EXCLUDED.thermal_reference_count,
    electric_reference_count = 0,
    input_status = 'ready',
    confidence = 'high',
    built_at = now();

  UPDATE mvp.site_vehicle_version_curations_v1
  SET
    calculation_vehicle_cluster_id = 'profile:' || v_profile_id::text,
    source_name = 'FIAT - gamma Grande Panda benzina',
    source_url =
      'https://www.media.stellantis.com/it-it/fiat/press/fiat-grande-panda-turbo-100-la-liberta-di-scegliere',
    source_note =
      'Profilo autonomo: 1.2 turbo 100 CV, cambio manuale a 6 marce, consumo WLTP 5,6-5,7 l/100 km e listino POP 17.900 euro a maggio 2026.',
    confidence = 'high',
    updated_at = now()
  WHERE curated_version_id = 'grande-panda-petrol-100-2026';

  GET DIAGNOSTICS v_updated = ROW_COUNT;
  IF v_updated <> 1 THEN
    RAISE EXCEPTION
      'Curatela Grande Panda benzina assente o duplicata: % righe',
      v_updated;
  END IF;
END;
$grande_panda_petrol$;

-- -------------------------------------------------------------------------
-- 2. Quarantena di versioni temporalmente impossibili documentate.
-- -------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS mvp.catalog_publication_blocks_v1 (
  block_id text PRIMARY KEY,
  model_catalog_id text NOT NULL,
  display_variant_id text NOT NULL,
  vehicle_cluster_id text NOT NULL,
  reason_code text NOT NULL,
  reason_note text NOT NULL,
  source_name text NOT NULL,
  source_url text NOT NULL,
  is_active boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT catalog_publication_blocks_identity_unique
    UNIQUE (model_catalog_id, display_variant_id, vehicle_cluster_id)
);

COMMENT ON TABLE mvp.catalog_publication_blocks_v1 IS
'Versioni sorgente conservate nel database ma escluse dal catalogo pubblico per incongruenze documentate.';

REVOKE ALL ON mvp.catalog_publication_blocks_v1
FROM PUBLIC, anon, authenticated;

INSERT INTO mvp.catalog_publication_blocks_v1 (
  block_id,
  model_catalog_id,
  display_variant_id,
  vehicle_cluster_id,
  reason_code,
  reason_note,
  source_name,
  source_url,
  is_active,
  updated_at
)
VALUES
  (
    'cupra-formentor-2015-petrol-173',
    'ae6f9f81888eb2f015cde7ce469a22b0',
    'profile:1225',
    'profile:1225',
    'before_model_launch',
    'La Formentor non era in produzione nel 2015; CUPRA ne ha avviato la produzione nel settembre 2020.',
    'CUPRA - avvio produzione Formentor',
    'https://www.cupraofficial.it/newsroom/inizio-produzione',
    true,
    now()
  ),
  (
    'cupra-formentor-2019-hybrid-204',
    'ae6f9f81888eb2f015cde7ce469a22b0',
    'profile:1299',
    'profile:1299',
    'before_model_launch',
    'La Formentor non era in produzione nel 2019; le PHEV sono state introdotte dal 2021.',
    'CUPRA - avvio produzione Formentor',
    'https://www.cupraofficial.it/newsroom/inizio-produzione',
    true,
    now()
  ),
  (
    'alfa-giulia-2014-diesel-240',
    'cd27a474ac9848fc2f11fc8d121dae0e',
    'profile:1170',
    'profile:1170',
    'before_model_launch',
    'La generazione moderna della Giulia e stata presentata nel giugno 2015.',
    'Alfa Romeo / Stellantis Heritage',
    'https://www.media.stellantis.com/it-it/heritage-hub-italy/press/storie-alfa-romeo-decima-puntata-giulia-e-stelvio-racchiudono-110-anni-di-eccellenza-italiana',
    true,
    now()
  ),
  (
    'alfa-stelvio-2014-diesel-240',
    '4b1af44f0883134e6b57dc468b52d79b',
    'profile:1248',
    'profile:1248',
    'before_model_launch',
    'La Stelvio e stata presentata in anteprima mondiale nel novembre 2016.',
    'Alfa Romeo / Stellantis Media',
    'https://www.media.stellantis.com/it-it/alfa-romeo/press/anteprima-mondiale-alfa-romeo-stelvio',
    true,
    now()
  )
ON CONFLICT (block_id) DO UPDATE
SET
  model_catalog_id = EXCLUDED.model_catalog_id,
  display_variant_id = EXCLUDED.display_variant_id,
  vehicle_cluster_id = EXCLUDED.vehicle_cluster_id,
  reason_code = EXCLUDED.reason_code,
  reason_note = EXCLUDED.reason_note,
  source_name = EXCLUDED.source_name,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

DO $save_versions$
BEGIN
  IF to_regprocedure(
    'mvp.auto_tco_versions_before_identity_integrity_v1(text)'
  ) IS NULL THEN
    IF to_regprocedure('public.auto_tco_versions(text)') IS NULL THEN
      RAISE EXCEPTION 'Funzione public.auto_tco_versions non disponibile';
    END IF;

    EXECUTE
      'ALTER FUNCTION public.auto_tco_versions(text) '
      'RENAME TO auto_tco_versions_before_identity_integrity_v1';
    EXECUTE
      'ALTER FUNCTION public.auto_tco_versions_before_identity_integrity_v1(text) '
      'SET SCHEMA mvp';
  END IF;
END;
$save_versions$;

REVOKE ALL ON FUNCTION
  mvp.auto_tco_versions_before_identity_integrity_v1(text)
FROM PUBLIC, anon, authenticated;

CREATE OR REPLACE FUNCTION public.auto_tco_versions(p_model_id text)
RETURNS jsonb
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public
AS $function$
  WITH source_item AS (
    SELECT source.item, source.ordinality
    FROM jsonb_array_elements(
      mvp.auto_tco_versions_before_identity_integrity_v1(
        left(trim(p_model_id), 64)
      ) -> 'items'
    ) WITH ORDINALITY AS source(item, ordinality)
  ), publishable AS (
    SELECT source.*
    FROM source_item AS source
    WHERE NOT EXISTS (
      SELECT 1
      FROM mvp.catalog_publication_blocks_v1 AS block
      WHERE block.is_active
        AND block.model_catalog_id = left(trim(p_model_id), 64)
        AND block.display_variant_id =
          COALESCE(
            NULLIF(source.item ->> 'display_variant_id', ''),
            source.item ->> 'vehicle_cluster_id'
          )
        AND block.vehicle_cluster_id =
          source.item ->> 'vehicle_cluster_id'
    )
  )
  SELECT jsonb_build_object(
    'items',
    COALESCE(
      jsonb_agg(publishable.item ORDER BY publishable.ordinality),
      '[]'::jsonb
    )
  )
  FROM publishable;
$function$;

COMMENT ON FUNCTION public.auto_tco_versions(text) IS
'Versioni pubbliche dopo i controlli di identita e la quarantena delle incongruenze commerciali documentate.';

REVOKE ALL ON FUNCTION public.auto_tco_versions(text)
FROM PUBLIC, authenticated;
GRANT EXECUTE ON FUNCTION public.auto_tco_versions(text) TO anon;

-- -------------------------------------------------------------------------
-- 3. Cache manutenzione coerente con i nuovi identificativi Panda.
-- -------------------------------------------------------------------------

DELETE FROM mvp.maintenance_display_variant_inputs_v1
WHERE model_catalog_id IN (
  'curated:fiat:panda-2012',
  'curated:fiat:grande-panda'
);

WITH requested_model(model_catalog_id) AS (
  VALUES
    ('curated:fiat:panda-2012'::text),
    ('curated:fiat:grande-panda'::text)
), version_item AS (
  SELECT
    requested.model_catalog_id AS requested_model_id,
    version.item
  FROM requested_model AS requested
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(requested.model_catalog_id) -> 'items'
  ) AS version(item)
), normalized AS (
  SELECT
    COALESCE(
      NULLIF(item ->> 'display_variant_id', ''),
      item ->> 'vehicle_cluster_id'
    ) AS display_variant_id,
    item ->> 'vehicle_cluster_id' AS vehicle_cluster_id,
    COALESCE(
      NULLIF(item ->> 'model_catalog_id', ''),
      requested_model_id
    ) AS model_catalog_id,
    item ->> 'brand' AS brand,
    item ->> 'model' AS model,
    item ->> 'version_label' AS version_label,
    COALESCE(
      NULLIF(item ->> 'year_from', '')::integer,
      NULLIF(item ->> 'display_year', '')::integer
    ) AS year_from,
    COALESCE(
      NULLIF(item ->> 'year_to', '')::integer,
      NULLIF(item ->> 'display_year', '')::integer
    ) AS year_to,
    COALESCE(
      NULLIF(item ->> 'display_year', '')::integer,
      round(
        (
          NULLIF(item ->> 'year_from', '')::numeric
          + NULLIF(item ->> 'year_to', '')::numeric
        ) / 2.0
      )::integer
    ) AS display_year,
    COALESCE(NULLIF(item ->> 'year_source', ''), 'catalog_display_year')
      AS year_source,
    COALESCE(NULLIF(item ->> 'year_confidence', ''), 'low')
      AS year_confidence,
    COALESCE(NULLIF(item ->> 'fuel_type', ''), 'unknown')
      AS fuel_type,
    COALESCE(NULLIF(item ->> 'hybrid_type', ''), 'none')
      AS hybrid_type,
    NULLIF(item ->> 'power_kw', '')::numeric AS displayed_power_kw,
    NULLIF(item ->> 'thermal_power_kw', '')::numeric AS thermal_power_kw
  FROM version_item
), valid AS (
  SELECT
    normalized.*,
    CASE
      WHEN hybrid_type = 'plug_in_hybrid' AND thermal_power_kw > 0
        THEN thermal_power_kw
      ELSE displayed_power_kw
    END AS maintenance_power_kw,
    CASE
      WHEN hybrid_type = 'plug_in_hybrid' AND thermal_power_kw > 0
        THEN 'thermal_engine_power'
      ELSE 'declared_vehicle_power'
    END AS power_basis
  FROM normalized
  WHERE display_variant_id IS NOT NULL
    AND vehicle_cluster_id IS NOT NULL
    AND model_catalog_id IS NOT NULL
    AND brand IS NOT NULL
    AND model IS NOT NULL
    AND version_label IS NOT NULL
    AND year_from BETWEEN 1900 AND 2100
    AND year_to BETWEEN year_from AND 2100
    AND display_year BETWEEN year_from AND year_to
)
INSERT INTO mvp.maintenance_display_variant_inputs_v1 (
  display_variant_id,
  vehicle_cluster_id,
  model_catalog_id,
  brand,
  model,
  version_label,
  year_from,
  year_to,
  display_year,
  year_source,
  year_confidence,
  fuel_type,
  hybrid_type,
  displayed_power_kw,
  thermal_power_kw,
  maintenance_power_kw,
  power_basis,
  built_at
)
SELECT
  display_variant_id,
  vehicle_cluster_id,
  model_catalog_id,
  brand,
  model,
  version_label,
  year_from,
  year_to,
  display_year,
  year_source,
  year_confidence,
  fuel_type,
  hybrid_type,
  displayed_power_kw,
  thermal_power_kw,
  maintenance_power_kw,
  power_basis,
  now()
FROM valid
ON CONFLICT (display_variant_id, vehicle_cluster_id) DO UPDATE
SET
  model_catalog_id = EXCLUDED.model_catalog_id,
  brand = EXCLUDED.brand,
  model = EXCLUDED.model,
  version_label = EXCLUDED.version_label,
  year_from = EXCLUDED.year_from,
  year_to = EXCLUDED.year_to,
  display_year = EXCLUDED.display_year,
  year_source = EXCLUDED.year_source,
  year_confidence = EXCLUDED.year_confidence,
  fuel_type = EXCLUDED.fuel_type,
  hybrid_type = EXCLUDED.hybrid_type,
  displayed_power_kw = EXCLUDED.displayed_power_kw,
  thermal_power_kw = EXCLUDED.thermal_power_kw,
  maintenance_power_kw = EXCLUDED.maintenance_power_kw,
  power_basis = EXCLUDED.power_basis,
  built_at = now();

ANALYZE mvp.maintenance_display_variant_inputs_v1;

-- -------------------------------------------------------------------------
-- 4. Registro univoco delle identita pubblicate e nuova RPC di selezione.
-- -------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS mvp.published_variant_identity_guard_v1 (
  display_variant_id text PRIMARY KEY,
  vehicle_cluster_id text NOT NULL,
  model_catalog_id text NOT NULL,
  brand text NOT NULL,
  model text NOT NULL,
  version_label text NOT NULL,
  built_at timestamptz NOT NULL DEFAULT now()
);

COMMENT ON TABLE mvp.published_variant_identity_guard_v1 IS
'Registro privato e univoco delle identita commerciali effettivamente pubblicate dal catalogo.';

REVOKE ALL ON mvp.published_variant_identity_guard_v1
FROM PUBLIC, anon, authenticated;

CREATE OR REPLACE FUNCTION mvp.refresh_published_variant_identity_guard_v1()
RETURNS integer
LANGUAGE plpgsql
VOLATILE
SECURITY DEFINER
SET search_path = pg_catalog, public
AS $function$
DECLARE
  v_rows integer;
BEGIN
  TRUNCATE TABLE mvp.published_variant_identity_guard_v1;

  WITH brand_item AS (
    SELECT brand.item
    FROM jsonb_array_elements(
      public.auto_tco_brands() -> 'items'
    ) AS brand(item)
  ), model_item AS (
    SELECT DISTINCT
      model.item ->> 'model_catalog_id' AS model_catalog_id
    FROM brand_item AS brand
    CROSS JOIN LATERAL jsonb_array_elements(
      public.auto_tco_models(brand.item ->> 'brand_key') -> 'items'
    ) AS model(item)
  ), version_item AS (
    SELECT
      model.model_catalog_id AS requested_model_id,
      version.item
    FROM model_item AS model
    CROSS JOIN LATERAL jsonb_array_elements(
      public.auto_tco_versions(model.model_catalog_id) -> 'items'
    ) AS version(item)
  )
  INSERT INTO mvp.published_variant_identity_guard_v1 (
    display_variant_id,
    vehicle_cluster_id,
    model_catalog_id,
    brand,
    model,
    version_label,
    built_at
  )
  SELECT
    COALESCE(
      NULLIF(item ->> 'display_variant_id', ''),
      item ->> 'vehicle_cluster_id'
    ),
    item ->> 'vehicle_cluster_id',
    COALESCE(
      NULLIF(item ->> 'model_catalog_id', ''),
      requested_model_id
    ),
    item ->> 'brand',
    item ->> 'model',
    item ->> 'version_label',
    now()
  FROM version_item
  WHERE NULLIF(item ->> 'vehicle_cluster_id', '') IS NOT NULL
    AND COALESCE(
      NULLIF(item ->> 'display_variant_id', ''),
      NULLIF(item ->> 'vehicle_cluster_id', '')
    ) IS NOT NULL;

  GET DIAGNOSTICS v_rows = ROW_COUNT;
  RETURN v_rows;
END;
$function$;

REVOKE ALL ON FUNCTION
  mvp.refresh_published_variant_identity_guard_v1()
FROM PUBLIC, anon, authenticated;

SELECT mvp.refresh_published_variant_identity_guard_v1();

CREATE OR REPLACE FUNCTION public.auto_tco_estimate_selection(
  p_model_catalog_id text,
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
  v_identity mvp.published_variant_identity_guard_v1%ROWTYPE;
  v_result jsonb;
BEGIN
  IF p_model_catalog_id IS NULL
    OR length(trim(p_model_catalog_id)) NOT BETWEEN 1 AND 64
    OR p_vehicle_cluster_id IS NULL
    OR length(trim(p_vehicle_cluster_id)) NOT BETWEEN 1 AND 180
    OR p_display_variant_id IS NULL
    OR length(trim(p_display_variant_id)) NOT BETWEEN 1 AND 180
  THEN
    RAISE EXCEPTION 'Identita della versione non valida'
      USING ERRCODE = '22023';
  END IF;

  SELECT guard.*
  INTO v_identity
  FROM mvp.published_variant_identity_guard_v1 AS guard
  WHERE guard.model_catalog_id = trim(p_model_catalog_id)
    AND guard.vehicle_cluster_id = trim(p_vehicle_cluster_id)
    AND guard.display_variant_id = trim(p_display_variant_id);

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Versione non disponibile per il modello selezionato'
      USING ERRCODE = '22023';
  END IF;

  v_result := public.auto_tco_estimate_variant(
    v_identity.vehicle_cluster_id,
    v_identity.display_variant_id,
    p_annual_km,
    p_ownership_years,
    p_region_code
  );

  -- Il motore storico ricava brand e modello dal seed tecnico, che puo essere
  -- condiviso da modelli commerciali diversi. Dopo la validazione, l'identita
  -- pubblica deve invece coincidere con la scelta effettuata dall'utente.
  v_result := jsonb_set(
    v_result,
    '{vehicle}',
    COALESCE(v_result -> 'vehicle', '{}'::jsonb)
      || jsonb_build_object(
        'model_catalog_id', v_identity.model_catalog_id,
        'display_variant_id', v_identity.display_variant_id,
        'vehicle_cluster_id', v_identity.vehicle_cluster_id,
        'brand', v_identity.brand,
        'model', v_identity.model,
        'version_label', v_identity.version_label
      ),
    true
  );

  RETURN jsonb_set(
    v_result,
    '{selection}',
    jsonb_build_object(
      'model_catalog_id', v_identity.model_catalog_id,
      'display_variant_id', v_identity.display_variant_id,
      'vehicle_cluster_id', v_identity.vehicle_cluster_id,
      'brand', v_identity.brand,
      'model', v_identity.model,
      'version_label', v_identity.version_label
    ),
    true
  );
END;
$function$;

COMMENT ON FUNCTION public.auto_tco_estimate_selection(
  text, text, text, integer, integer, text
) IS
'Calcola il TCO soltanto dopo aver validato la coppia modello/versione/profilo contro il catalogo pubblico univoco.';

REVOKE ALL ON FUNCTION public.auto_tco_estimate_selection(
  text, text, text, integer, integer, text
) FROM PUBLIC, authenticated;
GRANT EXECUTE ON FUNCTION public.auto_tco_estimate_selection(
  text, text, text, integer, integer, text
) TO anon;

-- Dopo l'introduzione della selezione validata, i percorsi pubblici precedenti
-- non devono permettere di saltare il legame modello/versione/profilo.
REVOKE ALL ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.auto_tco_estimate(
  text, integer, integer, text
) FROM PUBLIC, anon, authenticated;

-- -------------------------------------------------------------------------
-- 5. Superbollo: la riduzione decorre dal 1 gennaio dell'anno successivo.
-- -------------------------------------------------------------------------

DO $superbollo$
DECLARE
  v_rules integer;
BEGIN
  SELECT count(*)
  INTO v_rules
  FROM mvp.super_tax_rules
  WHERE kw_threshold = 185
    AND DATE '2026-09-15' BETWEEN valid_from
      AND COALESCE(valid_to, DATE '9999-12-31')
    AND reduction_pct IN (0, 40, 70, 85, 100);

  IF v_rules <> 5 THEN
    RAISE EXCEPTION
      'Regole superbollo 2026 inattese: trovate %, attese 5',
      v_rules;
  END IF;

  -- Spostamento temporaneo per non urtare la chiave univoca durante
  -- l'aggiornamento contemporaneo delle soglie.
  UPDATE mvp.super_tax_rules
  SET
    vehicle_age_from = vehicle_age_from + 100,
    vehicle_age_to = CASE
      WHEN vehicle_age_to IS NULL THEN NULL
      ELSE vehicle_age_to + 100
    END
  WHERE kw_threshold = 185
    AND DATE '2026-09-15' BETWEEN valid_from
      AND COALESCE(valid_to, DATE '9999-12-31')
    AND reduction_pct IN (0, 40, 70, 85, 100)
    AND vehicle_age_from < 100;

  UPDATE mvp.super_tax_rules
  SET
    vehicle_age_from = CASE reduction_pct
      WHEN 0 THEN 0
      WHEN 40 THEN 6
      WHEN 70 THEN 11
      WHEN 85 THEN 16
      WHEN 100 THEN 21
    END,
    vehicle_age_to = CASE reduction_pct
      WHEN 0 THEN 5
      WHEN 40 THEN 10
      WHEN 70 THEN 15
      WHEN 85 THEN 20
      WHEN 100 THEN NULL
    END,
    notes = CASE reduction_pct
      WHEN 0 THEN
        'Importo pieno fino al quinto anno; i periodi decorrono dal 1 gennaio dell anno successivo alla costruzione.'
      WHEN 40 THEN
        'Si paga il 60% dal sesto al decimo anno solare di differenza.'
      WHEN 70 THEN
        'Si paga il 30% dall undicesimo al quindicesimo anno solare di differenza.'
      WHEN 85 THEN
        'Si paga il 15% dal sedicesimo al ventesimo anno solare di differenza.'
      WHEN 100 THEN
        'Non piu dovuto dal ventunesimo anno solare di differenza.'
    END
  WHERE kw_threshold = 185
    AND DATE '2026-09-15' BETWEEN valid_from
      AND COALESCE(valid_to, DATE '9999-12-31')
    AND reduction_pct IN (0, 40, 70, 85, 100);
END;
$superbollo$;

NOTIFY pgrst, 'reload schema';

-- -------------------------------------------------------------------------
-- Verifica atomica: se un controllo fallisce, l'intera migrazione fa rollback.
-- -------------------------------------------------------------------------

DO $verify$
DECLARE
  v_panda jsonb;
  v_grande jsonb;
  v_panda_result jsonb;
  v_result jsonb;
  v_public_count integer;
  v_guard_count integer;
  v_blocked_visible integer;
  v_invalid_selection_accepted boolean := false;
  v_case record;
  v_tax jsonb;
  v_actual_share numeric;
BEGIN
  SELECT item
  INTO v_panda
  FROM jsonb_array_elements(
    public.auto_tco_versions('curated:fiat:panda-2012') -> 'items'
  ) AS version(item)
  WHERE item ->> 'commercial_name' = '1.4 FIRE 16V 100 HP';

  SELECT item
  INTO v_grande
  FROM jsonb_array_elements(
    public.auto_tco_versions('curated:fiat:grande-panda') -> 'items'
  ) AS version(item)
  WHERE item ->> 'commercial_name' = '1.2 T-Gen3 Turbo';

  IF v_panda IS NULL OR v_grande IS NULL THEN
    RAISE EXCEPTION 'Versioni Panda di controllo non trovate';
  END IF;

  IF NOT EXISTS (
      SELECT 1
      FROM mvp.vehicle_profiles AS profile
      WHERE 'profile:' || profile.id::text =
        v_panda ->> 'vehicle_cluster_id'
        AND profile.model = 'Panda'
        AND profile.representative_year = 2008
        AND profile.consumption_l_100km = 6.5
    )
    OR NOT EXISTS (
      SELECT 1
      FROM mvp.vehicle_profiles AS profile
      WHERE 'profile:' || profile.id::text =
        v_grande ->> 'vehicle_cluster_id'
        AND profile.model = 'Grande Panda'
        AND profile.representative_year = 2026
        AND profile.consumption_l_100km = 5.65
    )
  THEN
    RAISE EXCEPTION 'Profili autonomi Panda non coerenti con le fonti';
  END IF;

  IF v_panda ->> 'display_variant_id' = v_grande ->> 'display_variant_id'
    OR v_panda ->> 'vehicle_cluster_id' = v_grande ->> 'vehicle_cluster_id'
  THEN
    RAISE EXCEPTION 'Collisione Panda/Grande Panda ancora presente';
  END IF;

  SELECT count(*)
  INTO v_public_count
  FROM jsonb_array_elements(public.auto_tco_brands() -> 'items') AS brand(item)
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_models(brand.item ->> 'brand_key') -> 'items'
  ) AS model(item)
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(model.item ->> 'model_catalog_id') -> 'items'
  ) AS version(item);

  SELECT count(*) INTO v_guard_count
  FROM mvp.published_variant_identity_guard_v1;

  IF v_public_count <> v_guard_count THEN
    RAISE EXCEPTION
      'Registro identita incompleto: catalogo %, registro %',
      v_public_count,
      v_guard_count;
  END IF;

  SELECT count(*)
  INTO v_blocked_visible
  FROM mvp.catalog_publication_blocks_v1 AS block
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(block.model_catalog_id) -> 'items'
  ) AS version(item)
  WHERE block.is_active
    AND version.item ->> 'display_variant_id' = block.display_variant_id
    AND version.item ->> 'vehicle_cluster_id' = block.vehicle_cluster_id;

  IF v_blocked_visible <> 0 THEN
    RAISE EXCEPTION
      'Versioni in quarantena ancora visibili: %',
      v_blocked_visible;
  END IF;

  v_result := public.auto_tco_estimate_selection(
    'curated:fiat:grande-panda',
    v_grande ->> 'vehicle_cluster_id',
    v_grande ->> 'display_variant_id',
    15000,
    5,
    'italia'
  );

  IF v_result #>> '{quality,status}' <> 'ready'
    OR v_result #>> '{selection,model}' <> 'Grande Panda'
    OR v_result #>> '{vehicle,model}' <> 'Grande Panda'
    OR NULLIF(v_result #>> '{monthly_costs,total_monthly_eur}', '')::numeric
      <= 0
  THEN
    RAISE EXCEPTION
      'Calcolo Grande Panda non coerente: %',
      v_result;
  END IF;

  v_panda_result := public.auto_tco_estimate_selection(
    'curated:fiat:panda-2012',
    v_panda ->> 'vehicle_cluster_id',
    v_panda ->> 'display_variant_id',
    15000,
    5,
    'italia'
  );

  IF v_panda_result #>> '{quality,status}' <> 'ready'
    OR v_panda_result #>> '{selection,model}' <> 'Panda'
    OR v_panda_result #>> '{vehicle,model}' <> 'Panda'
    OR v_panda_result #>>
      '{calculation_details,tax,registration_year}' <> '2008'
    OR v_panda_result #>>
      '{calculation_details,maintenance,representative_year_used}' <> '2008'
    OR NULLIF(
      v_panda_result #>> '{monthly_costs,total_monthly_eur}',
      ''
    )::numeric <= 0
  THEN
    RAISE EXCEPTION
      'Calcolo Panda 100 HP non coerente: %',
      v_panda_result;
  END IF;

  BEGIN
    PERFORM public.auto_tco_estimate_selection(
      'curated:fiat:panda-2012',
      v_grande ->> 'vehicle_cluster_id',
      v_grande ->> 'display_variant_id',
      15000,
      5,
      'italia'
    );
    v_invalid_selection_accepted := true;
  EXCEPTION WHEN SQLSTATE '22023' THEN
    v_invalid_selection_accepted := false;
  END;

  IF v_invalid_selection_accepted THEN
    RAISE EXCEPTION 'La RPC ha accettato una versione per il modello sbagliato';
  END IF;

  IF has_function_privilege(
      'anon',
      'public.auto_tco_estimate_variant(text,text,integer,integer,text)',
      'EXECUTE'
    )
    OR has_function_privilege(
      'anon',
      'public.auto_tco_estimate(text,integer,integer,text)',
      'EXECUTE'
    )
    OR NOT has_function_privilege(
      'anon',
      'public.auto_tco_estimate_selection(text,text,text,integer,integer,text)',
      'EXECUTE'
    )
  THEN
    RAISE EXCEPTION 'Privilegi degli endpoint di calcolo non coerenti';
  END IF;

  FOR v_case IN
    SELECT *
    FROM (VALUES
      (2021, 1.00::numeric),
      (2020, 0.60::numeric),
      (2016, 0.60::numeric),
      (2015, 0.30::numeric),
      (2010, 0.15::numeric),
      (2005, 0.00::numeric)
    ) AS boundary(construction_year, expected_share)
  LOOP
    v_tax := mvp.estimate_tax_with_power_v1(
      'italia',
      'petrol',
      'none',
      v_case.construction_year,
      6,
      225,
      1,
      false,
      DATE '2026-09-15'
    );

    v_actual_share := round(
      (
        (v_tax ->> 'average_annual_tax_eur')::numeric
        - (v_tax ->> 'ordinary_tax_before_reduction_eur')::numeric
      ) / 800.0,
      2
    );

    IF v_actual_share <> v_case.expected_share THEN
      RAISE EXCEPTION
        'Soglia superbollo errata per anno %: ottenuto %, atteso %',
        v_case.construction_year,
        v_actual_share,
        v_case.expected_share;
    END IF;
  END LOOP;
END;
$verify$;

COMMIT;

WITH panda AS (
  SELECT item
  FROM jsonb_array_elements(
    public.auto_tco_versions('curated:fiat:panda-2012') -> 'items'
  ) AS version(item)
  WHERE item ->> 'commercial_name' = '1.4 FIRE 16V 100 HP'
), grande AS (
  SELECT item
  FROM jsonb_array_elements(
    public.auto_tco_versions('curated:fiat:grande-panda') -> 'items'
  ) AS version(item)
  WHERE item ->> 'commercial_name' = '1.2 T-Gen3 Turbo'
), total AS (
  SELECT count(*)::integer AS versioni_pubblicate
  FROM mvp.published_variant_identity_guard_v1
), result AS (
  SELECT public.auto_tco_estimate_selection(
    'curated:fiat:grande-panda',
    grande.item ->> 'vehicle_cluster_id',
    grande.item ->> 'display_variant_id',
    15000,
    5,
    'italia'
  ) AS payload
  FROM grande
), panda_result AS (
  SELECT public.auto_tco_estimate_selection(
    'curated:fiat:panda-2012',
    panda.item ->> 'vehicle_cluster_id',
    panda.item ->> 'display_variant_id',
    15000,
    5,
    'italia'
  ) AS payload
  FROM panda
)
SELECT
  total.versioni_pubblicate,
  (SELECT count(*) FROM mvp.catalog_publication_blocks_v1 WHERE is_active)
    AS versioni_in_quarantena,
  panda.item ->> 'display_variant_id' AS id_panda_100_hp,
  grande.item ->> 'display_variant_id' AS id_grande_panda_benzina,
  result.payload #>> '{monthly_costs,total_monthly_eur}'
    AS grande_panda_totale_mensile,
  panda_result.payload #>> '{monthly_costs,total_monthly_eur}'
    AS panda_100_hp_totale_mensile,
  result.payload #>> '{quality,status}' AS grande_panda_stato,
  (
    SELECT count(*)
    FROM (
      SELECT display_variant_id
      FROM mvp.published_variant_identity_guard_v1
      GROUP BY display_variant_id
      HAVING count(*) > 1
    ) AS duplicates
  ) AS collisioni_identita,
  NOT has_function_privilege(
    'anon',
    'public.auto_tco_estimate_variant(text,text,integer,integer,text)',
    'EXECUTE'
  ) AS vecchio_endpoint_chiuso,
  'ok' AS verifica
FROM total
CROSS JOIN panda
CROSS JOIN grande
CROSS JOIN result
CROSS JOIN panda_result;
