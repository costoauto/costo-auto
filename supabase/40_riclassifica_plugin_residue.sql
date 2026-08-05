\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - riclassificazione delle PHEV residue emerse dall'audit 38.
--
-- Alcune omologazioni EEA riportavano consumi ponderati da PHEV, ma il
-- catalogo pubblico le esponeva come ibride non ricaricabili e mostrava la
-- sola potenza termica. Le regole sotto sono limitate a coppie esatte di
-- marca, modello, intervallo e potenza e derivano da schede tecniche
-- pubbliche. Nessuna regola euristica viene applicata ad altri veicoli.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

CREATE TABLE IF NOT EXISTS mvp.phev_residual_reclassification_rules_v1 (
  rule_key text PRIMARY KEY,
  action text NOT NULL,
  source_brand text NOT NULL,
  source_model text NOT NULL,
  source_year_from integer NOT NULL,
  source_year_to integer NOT NULL,
  source_power_cv integer NOT NULL,
  display_model text,
  fuel_type text,
  year_from integer,
  year_to integer,
  system_power_kw numeric,
  system_power_cv numeric,
  thermal_power_kw numeric,
  thermal_power_cv numeric,
  weighted_thermal_l_100km numeric,
  weighted_electric_kwh_100km numeric,
  thermal_empty_battery_l_100km numeric,
  electric_range_wltp_km numeric,
  source_name text NOT NULL,
  source_urls text[] NOT NULL,
  source_note text NOT NULL,
  confidence text NOT NULL,
  built_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT phev_residual_rule_action_check
    CHECK (action IN ('reclassify', 'hide')),
  CONSTRAINT phev_residual_rule_source_year_check
    CHECK (
      source_year_from BETWEEN 1990 AND 2100
      AND source_year_to BETWEEN source_year_from AND 2100
    ),
  CONSTRAINT phev_residual_rule_output_check
    CHECK (
      action = 'hide'
      OR (
        fuel_type IN ('petrol/electric', 'diesel/electric')
        AND year_from BETWEEN 1990 AND 2100
        AND year_to BETWEEN year_from AND 2100
        AND system_power_kw > 0
        AND system_power_cv > 0
        AND thermal_power_kw > 0
        AND thermal_power_cv > 0
        AND weighted_thermal_l_100km BETWEEN 0.01 AND 20
        AND weighted_electric_kwh_100km BETWEEN 1 AND 50
      )
    ),
  CONSTRAINT phev_residual_rule_confidence_check
    CHECK (confidence IN ('high', 'medium'))
);

COMMENT ON TABLE mvp.phev_residual_reclassification_rules_v1 IS
'Regole private, puntuali e documentate per PHEV rimaste classificate come ibride non ricaricabili.';

REVOKE ALL ON mvp.phev_residual_reclassification_rules_v1
FROM PUBLIC, anon, authenticated;

TRUNCATE TABLE mvp.phev_residual_reclassification_rules_v1;

INSERT INTO mvp.phev_residual_reclassification_rules_v1 (
  rule_key,
  action,
  source_brand,
  source_model,
  source_year_from,
  source_year_to,
  source_power_cv,
  display_model,
  fuel_type,
  year_from,
  year_to,
  system_power_kw,
  system_power_cv,
  thermal_power_kw,
  thermal_power_cv,
  weighted_thermal_l_100km,
  weighted_electric_kwh_100km,
  thermal_empty_battery_l_100km,
  electric_range_wltp_km,
  source_name,
  source_urls,
  source_note,
  confidence
)
VALUES
  (
    'hyundai_santa_fe_2024_2025_160',
    'reclassify',
    'Hyundai', 'Santa Fe', 2024, 2025, 160,
    'Santa Fe', 'petrol/electric', 2024, 2025,
    186, 253, 118, 160, 1.7, 19.2, 7.5, 54,
    'ADAC Autokatalog, scheda tecnica pubblica',
    ARRAY[
      'https://www.adac.de/rund-ums-fahrzeug/autokatalog/marken-modelle/hyundai/santa-fe/5generation/336321/'
    ],
    'Santa Fe PHEV: 253 CV di sistema e 160 CV termici.',
    'high'
  ),
  (
    'hyundai_tucson_2020_179',
    'reclassify',
    'Hyundai', 'Tucson', 2020, 2020, 179,
    'Tucson', 'petrol/electric', 2020, 2020,
    195, 265, 132, 180, 1.4, 17.7, NULL, 62,
    'Hyundai Motor Europe, dati tecnici ufficiali',
    ARRAY[
      'https://www.hyundai.news/newsroom/dam/eu/press-kits/20200915_all-new_tucson/20201125_all-new_tucson/technical_data_all-new_tucson_1220.pdf',
      'https://www.hyundai.news/newsroom/dam/de/Pressemappen/Tucson_Plug-in_Hybrid_0721/Hyundai_TUCSON_PHEV_2021_3_Technische_Daten.pdf'
    ],
    'Tucson PHEV di prima serie: 265 CV di sistema e circa 180 CV termici.',
    'high'
  ),
  (
    'hyundai_tucson_2024_2025_160',
    'reclassify',
    'Hyundai', 'Tucson', 2024, 2025, 160,
    'Tucson', 'petrol/electric', 2024, 2025,
    185, 252, 118, 160, 1.3, 18.7, NULL, 64,
    'Hyundai Motor Europe e ADAC, schede tecniche pubbliche',
    ARRAY[
      'https://www.hyundai.news/eu/models/suv/tucson/press-kit/the-new-tucson-europes-best-selling-compact-suv-just-got-better.html',
      'https://www.adac.de/rund-ums-fahrzeug/autokatalog/marken-modelle/hyundai/tucson/3generation-facelift/336335/'
    ],
    'Tucson PHEV restyling: 252 CV di sistema e 160 CV termici.',
    'high'
  ),
  (
    'hyundai_tucson_2025_179_stale',
    'hide',
    'Hyundai', 'Tucson', 2025, 2025, 179,
    NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    'Hyundai Motor Europe, gamma tecnica ufficiale',
    ARRAY[
      'https://www.hyundai.news/eu/models/suv/tucson/press-kit/the-new-tucson-europes-best-selling-compact-suv-just-got-better.html'
    ],
    'Duplicato modellato della motorizzazione pre-restyling, non appartenente alla gamma 2025.',
    'high'
  ),
  (
    'mercedes_cla_2023_160',
    'reclassify',
    'Mercedes-Benz', 'CLA', 2023, 2023, 160,
    'CLA', 'petrol/electric', 2023, 2023,
    160, 218, 120, 163, 0.9, 16.8, NULL, 76,
    'ADAC Autokatalog, scheda tecnica pubblica',
    ARRAY[
      'https://www.adac.de/rund-ums-fahrzeug/autokatalog/marken-modelle/mercedes-benz/cla/118-facelift/328268/'
    ],
    'CLA 250 e PHEV: 218 CV di sistema e 163 CV termici.',
    'high'
  ),
  (
    'mercedes_cla_2025_160',
    'reclassify',
    'Mercedes-Benz', 'CLA', 2025, 2025, 160,
    'CLA', 'petrol/electric', 2025, 2025,
    160, 218, 120, 163, 2.3, 12.3, 5.9, 86,
    'ADAC Autokatalog, scheda tecnica pubblica',
    ARRAY[
      'https://www.adac.de/rund-ums-fahrzeug/autokatalog/marken-modelle/mercedes-benz/cla/118-facelift/339051/'
    ],
    'CLA 250 e PHEV: 218 CV di sistema e 163 CV termici.',
    'high'
  ),
  (
    'mercedes_e_class_2021_194',
    'reclassify',
    'Mercedes-Benz', 'E-Class', 2021, 2021, 194,
    'E-Class', 'diesel/electric', 2021, 2021,
    225, 306, 143, 194, 1.2, 16.1, NULL, 55,
    'ADAC Autokatalog, scheda tecnica pubblica',
    ARRAY[
      'https://www.adac.de/rund-ums-fahrzeug/autokatalog/marken-modelle/mercedes-benz/e-klasse/213-238-facelift/312707/'
    ],
    'E 300 de PHEV diesel: 306 CV di sistema e 194 CV termici.',
    'high'
  ),
  (
    'mercedes_e_class_2025_194',
    'reclassify',
    'Mercedes-Benz', 'E-Class', 2025, 2025, 194,
    'E-Class', 'diesel/electric', 2025, 2025,
    230, 313, 145, 197, 0.4, 19.3, 4.9, 111,
    'ADAC Autokatalog, scheda tecnica pubblica',
    ARRAY[
      'https://www.adac.de/rund-ums-fahrzeug/autokatalog/marken-modelle/mercedes-benz/e-klasse/214/331336/'
    ],
    'E 300 de PHEV diesel: 313 CV di sistema e 197 CV termici.',
    'high'
  ),
  (
    'mitsubishi_asx_2024_2025_92',
    'reclassify',
    'Mitsubishi', 'ASX', 2024, 2025, 92,
    'ASX', 'petrol/electric', 2024, 2025,
    117, 159, 68, 92, 1.3, 13.3, 5.3, 48,
    'ADAC Autokatalog, scheda tecnica pubblica',
    ARRAY[
      'https://www.adac.de/rund-ums-fahrzeug/autokatalog/marken-modelle/mitsubishi/asx/2generation/334785/'
    ],
    'ASX PHEV: 159 CV di sistema e 92 CV termici.',
    'high'
  ),
  (
    'mitsubishi_outlander_2021_135',
    'reclassify',
    'Mitsubishi', 'Outlander', 2021, 2021, 135,
    'Outlander', 'petrol/electric', 2021, 2021,
    165, 224, 99, 135, 1.8, 16.9, 7.4, 45,
    'Mitsubishi Motors Italia, documentazione tecnica ufficiale MY19',
    ARRAY[
      'https://www.mitsubishi-motors.it/content/dam/mitsubishi-motors-it/images/brochure/Catalogo-Outlander-PHEV-MY19lr-compressed.pdf',
      'https://www.mitsubishi-motors.it/content/dam/mitsubishi-motors-it/comunicati-stampa/2018-11-26-Mitsubishi_Outlander_PHEV_MY19.pdf'
    ],
    'Outlander PHEV MY19: 224 CV di sistema e 135 CV termici.',
    'high'
  ),
  (
    'suzuki_across_2025_185',
    'reclassify',
    'Suzuki', 'SUZUKI ACROSS', 2025, 2025, 185,
    'Across', 'petrol/electric', 2025, 2025,
    225, 306, 136, 185, 1.0, 17.1, 6.6, 75,
    'Suzuki Italia e ADAC, schede tecniche pubbliche',
    ARRAY[
      'https://auto.suzuki.it/modello/ACROSS/index.aspx',
      'https://auto.suzuki.it/tecnologia/4918/tecnologia-suzuki-hybrid.aspx',
      'https://www.adac.de/rund-ums-fahrzeug/autokatalog/marken-modelle/suzuki/across/1generation/334303/'
    ],
    'Across PHEV: 306 CV di sistema e 185 CV termici.',
    'high'
  );

CREATE UNIQUE INDEX IF NOT EXISTS
  uq_phev_residual_reclassification_source_v1
ON mvp.phev_residual_reclassification_rules_v1 (
  source_brand,
  source_model,
  source_year_from,
  source_year_to,
  source_power_cv
);

ANALYZE mvp.phev_residual_reclassification_rules_v1;

-- Conserva la versione precedente dell'endpoint e applica solo le regole
-- esatte. Il Tucson 2025 da 179 CV viene escluso in quanto duplicato stale.
DO $block$
BEGIN
  IF to_regprocedure(
    'mvp.auto_tco_versions_before_residual_phev_fix_v1(text)'
  ) IS NULL THEN
    IF to_regprocedure('public.auto_tco_versions(text)') IS NULL THEN
      RAISE EXCEPTION 'Funzione public.auto_tco_versions non disponibile';
    END IF;

    EXECUTE
      'ALTER FUNCTION public.auto_tco_versions(text) '
      'RENAME TO auto_tco_versions_before_residual_phev_fix_v1';
    EXECUTE
      'ALTER FUNCTION public.auto_tco_versions_before_residual_phev_fix_v1(text) '
      'SET SCHEMA mvp';
  END IF;
END;
$block$;

REVOKE ALL ON FUNCTION
  mvp.auto_tco_versions_before_residual_phev_fix_v1(text)
FROM PUBLIC, anon, authenticated;

CREATE OR REPLACE FUNCTION public.auto_tco_versions(p_model_id text)
RETURNS jsonb
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public
AS $function$
  WITH source_item AS (
    SELECT
      source.item,
      source.ordinality
    FROM jsonb_array_elements(
      mvp.auto_tco_versions_before_residual_phev_fix_v1(
        left(trim(p_model_id), 64)
      ) -> 'items'
    ) WITH ORDINALITY AS source(item, ordinality)
  ), matched AS (
    SELECT
      source.item,
      source.ordinality,
      rule.*
    FROM source_item AS source
    LEFT JOIN mvp.phev_residual_reclassification_rules_v1 AS rule
      ON rule.source_brand = source.item ->> 'brand'
     AND rule.source_model = source.item ->> 'model'
     AND rule.source_year_from
       = NULLIF(source.item ->> 'year_from', '')::integer
     AND rule.source_year_to
       = NULLIF(source.item ->> 'year_to', '')::integer
     AND rule.source_power_cv
       = round(NULLIF(source.item ->> 'power_cv', '')::numeric)::integer
  ), corrected AS (
    SELECT
      CASE
        WHEN action = 'reclassify' THEN
          item || jsonb_build_object(
            'model', display_model,
            'fuel_type', fuel_type,
            'hybrid_type', 'plug_in_hybrid',
            'powertrain_type', 'plug_in_hybrid',
            'power_kw', thermal_power_kw,
            'power_cv', thermal_power_cv,
            'system_power_kw', system_power_kw,
            'system_power_cv', system_power_cv,
            'thermal_power_kw', thermal_power_kw,
            'thermal_power_cv', thermal_power_cv,
            'power_data_status', 'verified',
            'power_data_confidence', confidence,
            'power_data_source', source_name,
            'power_data_source_url', source_urls[1],
            'year_from', year_from,
            'year_to', year_to,
            'display_year', round((year_from + year_to) / 2.0)::integer,
            'years_in_range', year_to - year_from + 1,
            'version_label',
              (
                CASE
                  WHEN year_from = year_to THEN year_from::text
                  ELSE year_from::text || '-' || year_to::text
                END
                || ' ' || chr(183) || ' Ibrida plug-in '
                || CASE
                  WHEN fuel_type = 'diesel/electric' THEN 'diesel'
                  ELSE 'benzina'
                END
                || ' ' || chr(183) || ' '
                || round(system_power_cv)::integer::text
                || ' CV ('
                || round(thermal_power_cv)::integer::text
                || ' CV termici)'
              ),
            'energy_data_status', 'complete',
            'energy_input_source',
              'curated_public_phev_reclassification_v1',
            'energy_input_confidence', confidence,
            'technical_correction_code', rule_key,
            'technical_correction_note', source_note
          )
        ELSE item
      END AS item,
      ordinality,
      CASE WHEN action = 'reclassify' THEN 0 ELSE 1 END AS preference
    FROM matched
    WHERE action IS DISTINCT FROM 'hide'
  ), ranked AS (
    SELECT
      corrected.*,
      row_number() OVER (
        PARTITION BY item ->> 'version_label'
        ORDER BY preference, ordinality
      ) AS visible_label_rank
    FROM corrected
  )
  SELECT jsonb_build_object(
    'items',
    COALESCE(
      jsonb_agg(item ORDER BY ordinality),
      '[]'::jsonb
    )
  )
  FROM ranked
  WHERE visible_label_rank = 1;
$function$;

COMMENT ON FUNCTION public.auto_tco_versions(text) IS
'Versioni pubbliche con le PHEV residue riclassificate mediante regole puntuali e fonti tecniche pubbliche.';

REVOKE ALL ON FUNCTION public.auto_tco_versions(text)
FROM PUBLIC, authenticated;
GRANT EXECUTE ON FUNCTION public.auto_tco_versions(text) TO anon;

-- Ripulisce il nome commerciale Across nel menu dei modelli senza cambiare
-- l'identificativo stabile usato dal sito.
DO $block$
BEGIN
  IF to_regprocedure(
    'mvp.auto_tco_models_before_name_cleanup_v1(text)'
  ) IS NULL THEN
    IF to_regprocedure('public.auto_tco_models(text)') IS NULL THEN
      RAISE EXCEPTION 'Funzione public.auto_tco_models non disponibile';
    END IF;

    EXECUTE
      'ALTER FUNCTION public.auto_tco_models(text) '
      'RENAME TO auto_tco_models_before_name_cleanup_v1';
    EXECUTE
      'ALTER FUNCTION public.auto_tco_models_before_name_cleanup_v1(text) '
      'SET SCHEMA mvp';
  END IF;
END;
$block$;

REVOKE ALL ON FUNCTION
  mvp.auto_tco_models_before_name_cleanup_v1(text)
FROM PUBLIC, anon, authenticated;

CREATE OR REPLACE FUNCTION public.auto_tco_models(p_brand_key text)
RETURNS jsonb
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public
AS $function$
  WITH source_item AS (
    SELECT source.item, source.ordinality
    FROM jsonb_array_elements(
      mvp.auto_tco_models_before_name_cleanup_v1(
        left(trim(p_brand_key), 60)
      ) -> 'items'
    ) WITH ORDINALITY AS source(item, ordinality)
  ), normalized AS (
    SELECT
      CASE
        WHEN item ->> 'brand' = 'Suzuki'
          AND upper(trim(item ->> 'model')) = 'SUZUKI ACROSS'
        THEN item || jsonb_build_object('model', 'Across')
        ELSE item
      END AS item,
      ordinality
    FROM source_item
  )
  SELECT jsonb_build_object(
    'items',
    COALESCE(jsonb_agg(item ORDER BY item ->> 'model'), '[]'::jsonb)
  )
  FROM normalized;
$function$;

COMMENT ON FUNCTION public.auto_tco_models(text) IS
'Modelli pubblici con normalizzazione finale dei nomi commerciali ridondanti.';

REVOKE ALL ON FUNCTION public.auto_tco_models(text)
FROM PUBLIC, authenticated;
GRANT EXECUTE ON FUNCTION public.auto_tco_models(text) TO anon;

-- Collega le dieci varianti corrette ai consumi PHEV specifici. L'ultimo
-- livello del motore energia usera questi valori al posto del consumo ibrido.
WITH corrected_variant AS (
  SELECT
    version.item,
    rule.*
  FROM (
    SELECT DISTINCT
      model.item ->> 'model_catalog_id' AS model_catalog_id
    FROM jsonb_array_elements(public.auto_tco_brands() -> 'items') AS brand(item)
    CROSS JOIN LATERAL jsonb_array_elements(
      public.auto_tco_models(brand.item ->> 'brand_key') -> 'items'
    ) AS model(item)
  ) AS model
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(model.model_catalog_id) -> 'items'
  ) AS version(item)
  JOIN mvp.phev_residual_reclassification_rules_v1 AS rule
    ON rule.rule_key = version.item ->> 'technical_correction_code'
  WHERE rule.action = 'reclassify'
)
INSERT INTO mvp.phev_display_variant_energy_v1 (
  display_variant_id,
  vehicle_cluster_id,
  model_catalog_id,
  brand,
  model,
  year_from,
  year_to,
  system_power_kw,
  system_power_cv,
  thermal_power_kw,
  thermal_power_cv,
  weighted_thermal_l_100km,
  weighted_electric_kwh_100km,
  thermal_empty_battery_l_100km,
  electric_range_wltp_km,
  source_name,
  source_urls,
  source_records,
  confidence,
  built_at
)
SELECT
  item ->> 'display_variant_id',
  item ->> 'vehicle_cluster_id',
  item ->> 'model_catalog_id',
  item ->> 'brand',
  item ->> 'model',
  rule.year_from,
  rule.year_to,
  rule.system_power_kw,
  rule.system_power_cv,
  rule.thermal_power_kw,
  rule.thermal_power_cv,
  rule.weighted_thermal_l_100km,
  rule.weighted_electric_kwh_100km,
  rule.thermal_empty_battery_l_100km,
  rule.electric_range_wltp_km,
  rule.source_name,
  rule.source_urls,
  cardinality(rule.source_urls),
  rule.confidence,
  now()
FROM corrected_variant AS rule
ON CONFLICT (display_variant_id) DO UPDATE
SET
  vehicle_cluster_id = EXCLUDED.vehicle_cluster_id,
  model_catalog_id = EXCLUDED.model_catalog_id,
  brand = EXCLUDED.brand,
  model = EXCLUDED.model,
  year_from = EXCLUDED.year_from,
  year_to = EXCLUDED.year_to,
  system_power_kw = EXCLUDED.system_power_kw,
  system_power_cv = EXCLUDED.system_power_cv,
  thermal_power_kw = EXCLUDED.thermal_power_kw,
  thermal_power_cv = EXCLUDED.thermal_power_cv,
  weighted_thermal_l_100km = EXCLUDED.weighted_thermal_l_100km,
  weighted_electric_kwh_100km = EXCLUDED.weighted_electric_kwh_100km,
  thermal_empty_battery_l_100km = EXCLUDED.thermal_empty_battery_l_100km,
  electric_range_wltp_km = EXCLUDED.electric_range_wltp_km,
  source_name = EXCLUDED.source_name,
  source_urls = EXCLUDED.source_urls,
  source_records = EXCLUDED.source_records,
  confidence = EXCLUDED.confidence,
  built_at = EXCLUDED.built_at;

ANALYZE mvp.phev_display_variant_energy_v1;

-- Riallinea la cache di manutenzione alle nuove etichette e alla potenza
-- termica, senza ricostruire le migliaia di righe non interessate.
WITH corrected_variant AS (
  SELECT version.item
  FROM (
    SELECT DISTINCT
      model.item ->> 'model_catalog_id' AS model_catalog_id
    FROM jsonb_array_elements(public.auto_tco_brands() -> 'items') AS brand(item)
    CROSS JOIN LATERAL jsonb_array_elements(
      public.auto_tco_models(brand.item ->> 'brand_key') -> 'items'
    ) AS model(item)
  ) AS model
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(model.model_catalog_id) -> 'items'
  ) AS version(item)
  WHERE NULLIF(version.item ->> 'technical_correction_code', '') IS NOT NULL
)
UPDATE mvp.maintenance_display_variant_inputs_v1 AS cache
SET
  brand = item ->> 'brand',
  model = item ->> 'model',
  version_label = item ->> 'version_label',
  year_from = (item ->> 'year_from')::integer,
  year_to = (item ->> 'year_to')::integer,
  display_year = (item ->> 'display_year')::integer,
  year_source = 'verified_public_phev_specification',
  year_confidence = 'high',
  fuel_type = item ->> 'fuel_type',
  hybrid_type = item ->> 'hybrid_type',
  displayed_power_kw = (item ->> 'power_kw')::numeric,
  thermal_power_kw = (item ->> 'thermal_power_kw')::numeric,
  maintenance_power_kw = (item ->> 'thermal_power_kw')::numeric,
  power_basis = 'thermal_engine_power',
  built_at = now()
FROM corrected_variant
WHERE cache.display_variant_id = item ->> 'display_variant_id'
  AND cache.vehicle_cluster_id = item ->> 'vehicle_cluster_id';

ANALYZE mvp.maintenance_display_variant_inputs_v1;

-- Le nove varianti nate come semplici ibride non ricevono dal motore base
-- il prezzo elettrico, perche il loro powertrain originale non prevedeva
-- ricarica. Questo ultimo livello calcola l'energia PHEV dopo che la variante
-- e stata risolta lato server e recupera il prezzo elettrico dalla stessa
-- tabella ARERA gia usata dal resto dell'applicazione.
DO $block$
BEGIN
  IF to_regprocedure(
    'mvp.auto_tco_estimate_variant_before_residual_phev_fix_v1(text,text,integer,integer,text)'
  ) IS NULL THEN
    IF to_regprocedure(
      'public.auto_tco_estimate_variant(text,text,integer,integer,text)'
    ) IS NULL THEN
      RAISE EXCEPTION
        'Funzione public.auto_tco_estimate_variant non disponibile';
    END IF;

    EXECUTE
      'ALTER FUNCTION public.auto_tco_estimate_variant(text,text,integer,integer,text) '
      'RENAME TO auto_tco_estimate_variant_before_residual_phev_fix_v1';
    EXECUTE
      'ALTER FUNCTION public.auto_tco_estimate_variant_before_residual_phev_fix_v1(text,text,integer,integer,text) '
      'SET SCHEMA mvp';
  END IF;
END;
$block$;

REVOKE ALL ON FUNCTION
  mvp.auto_tco_estimate_variant_before_residual_phev_fix_v1(
    text, text, integer, integer, text
  )
FROM PUBLIC, anon, authenticated;

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
  v_rule mvp.phev_residual_reclassification_rules_v1%ROWTYPE;
  v_old_cost numeric;
  v_new_cost numeric;
  v_delta numeric;
  v_subtotal numeric;
  v_total numeric;
  v_thermal_price numeric;
  v_electricity_price numeric;
  v_mix_weight numeric;
  v_details jsonb;
  v_assumptions jsonb;
BEGIN
  v_result := mvp.auto_tco_estimate_variant_before_residual_phev_fix_v1(
    p_vehicle_cluster_id,
    p_display_variant_id,
    p_annual_km,
    p_ownership_years,
    p_region_code
  );

  SELECT catalog.model_catalog_id
  INTO v_model_id
  FROM mvp.site_vehicle_catalog_unified_v1 AS catalog
  WHERE catalog.vehicle_cluster_id = trim(p_vehicle_cluster_id)
  ORDER BY catalog.registrations_count DESC
  LIMIT 1;

  IF v_model_id IS NULL THEN
    RETURN v_result;
  END IF;

  SELECT version.item
  INTO v_variant
  FROM jsonb_array_elements(
    public.auto_tco_versions(v_model_id) -> 'items'
  ) AS version(item)
  WHERE version.item ->> 'display_variant_id'
      = trim(p_display_variant_id)
    AND version.item ->> 'vehicle_cluster_id'
      = trim(p_vehicle_cluster_id)
    AND NULLIF(
      version.item ->> 'technical_correction_code',
      ''
    ) IS NOT NULL
  LIMIT 1;

  IF v_variant IS NULL THEN
    RETURN v_result;
  END IF;

  SELECT rule.*
  INTO v_rule
  FROM mvp.phev_residual_reclassification_rules_v1 AS rule
  WHERE rule.rule_key = v_variant ->> 'technical_correction_code'
    AND rule.action = 'reclassify';

  IF NOT FOUND THEN
    RETURN v_result;
  END IF;

  v_old_cost := NULLIF(
    v_result #>> '{monthly_costs,fuel_or_energy_eur}',
    ''
  )::numeric;
  v_thermal_price := NULLIF(
    v_result #>> '{calculation_details,fuel_or_energy,thermal_price_eur}',
    ''
  )::numeric;

  SELECT
    round(
      sum(price.price_eur_kwh * price.mix_weight)
        / nullif(sum(price.mix_weight), 0),
      4
    ),
    sum(price.mix_weight)
  INTO v_electricity_price, v_mix_weight
  FROM mvp.charging_price_assumptions AS price
  WHERE CURRENT_DATE BETWEEN price.period_start
                         AND coalesce(
                           price.period_end,
                           DATE '9999-12-31'
                         );

  IF v_old_cost IS NULL
    OR v_thermal_price IS NULL
    OR v_electricity_price IS NULL
    OR v_mix_weight IS NULL
    OR abs(v_mix_weight - 1) > 0.0001
  THEN
    RAISE EXCEPTION
      'Prezzi energia non disponibili per la variante PHEV corretta';
  END IF;

  v_new_cost := round(
    p_annual_km::numeric / 100
      * (
        v_rule.weighted_thermal_l_100km * v_thermal_price
        + v_rule.weighted_electric_kwh_100km
          * v_electricity_price
      )
      / 12,
    2
  );

  v_delta := v_new_cost - v_old_cost;
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
    '{monthly_costs,fuel_or_energy_eur}',
    to_jsonb(v_new_cost),
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

  v_details := (
    coalesce(
      v_result #> '{calculation_details,fuel_or_energy}',
      '{}'::jsonb
    ) - 'thermal_km' - 'electric_km'
  ) || jsonb_strip_nulls(jsonb_build_object(
    'method', 'variant_wltp_weighted_combined_v1',
    'thermal_consumption_per_100km',
      v_rule.weighted_thermal_l_100km,
    'electric_consumption_kwh_100km',
      v_rule.weighted_electric_kwh_100km,
    'thermal_consumption_empty_battery_l_100km',
      v_rule.thermal_empty_battery_l_100km,
    'electric_range_wltp_km', v_rule.electric_range_wltp_km,
    'thermal_price_eur', v_thermal_price,
    'electricity_price_eur_kwh', v_electricity_price,
    'electricity_price_area', 'italia',
    'electricity_price_source',
      'ARERA, prezzo finale medio domestico 2025 classe DC',
    'base_monthly_energy_cost_eur', v_old_cost,
    'variant_monthly_energy_cost_eur', v_new_cost,
    'source_name', v_rule.source_name,
    'source_urls', to_jsonb(v_rule.source_urls),
    'source_records', cardinality(v_rule.source_urls),
    'variant_energy_confidence', v_rule.confidence,
    'wltp_usage_assumption',
      'I consumi PHEV combinati ponderati presuppongono ricariche regolari secondo il ciclo WLTP.'
  ));

  v_result := jsonb_set(
    v_result,
    '{calculation_details,fuel_or_energy}',
    v_details,
    true
  );
  v_result := jsonb_set(
    v_result,
    '{descriptions,fuel_or_energy}',
    to_jsonb(
      'Costo basato sui consumi WLTP combinati ponderati della versione plug-in e sui prezzi di carburante ed energia utilizzati; presuppone ricariche regolari.'::text
    ),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,energy_variant_method}',
    to_jsonb('variant_wltp_weighted_combined'::text),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,energy_variant_confidence}',
    to_jsonb(v_rule.confidence),
    true
  );

  v_assumptions := coalesce(v_result -> 'assumptions', '[]'::jsonb)
    || jsonb_build_array(
      'Per la PHEV selezionata sono usati consumi WLTP combinati ponderati specifici e il prezzo elettrico ARERA gia adottato dall applicazione.'
    );
  v_result := jsonb_set(
    v_result,
    '{assumptions}',
    v_assumptions,
    true
  );

  RETURN v_result;
END;
$function$;

COMMENT ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) IS
'Calcola il TCO e completa l energia delle PHEV riclassificate usando consumi specifici verificati e il prezzo elettrico ARERA.';

REVOKE ALL ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) FROM PUBLIC, authenticated;
GRANT EXECUTE ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) TO anon;

NOTIFY pgrst, 'reload schema';

-- Verifica integrata: tutti i dieci profili devono essere riclassificati,
-- la riga Tucson obsoleta deve sparire e i calcoli devono essere ready.
CREATE OR REPLACE FUNCTION pg_temp.safe_tco_residual_phev_v1(
  p_vehicle_cluster_id text,
  p_display_variant_id text
)
RETURNS jsonb
LANGUAGE plpgsql
VOLATILE
AS $function$
BEGIN
  RETURN public.auto_tco_estimate_variant(
    p_vehicle_cluster_id,
    p_display_variant_id,
    15000,
    5,
    'italia'
  );
EXCEPTION WHEN OTHERS THEN
  RETURN jsonb_build_object('_audit_error', SQLSTATE || ': ' || SQLERRM);
END;
$function$;

CREATE TEMP TABLE residual_phev_versions_v1
ON COMMIT DROP
AS
WITH model_item AS (
  SELECT DISTINCT
    model.item ->> 'model_catalog_id' AS model_catalog_id
  FROM jsonb_array_elements(public.auto_tco_brands() -> 'items') AS brand(item)
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_models(brand.item ->> 'brand_key') -> 'items'
  ) AS model(item)
), version_item AS (
  SELECT version.item
  FROM model_item AS model
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(model.model_catalog_id) -> 'items'
  ) AS version(item)
)
SELECT
  item,
  item ->> 'brand' AS brand,
  item ->> 'model' AS model,
  item ->> 'version_label' AS version_label,
  item ->> 'vehicle_cluster_id' AS vehicle_cluster_id,
  item ->> 'display_variant_id' AS display_variant_id,
  item ->> 'technical_correction_code' AS correction_code
FROM version_item;

CREATE INDEX ON residual_phev_versions_v1 (correction_code);
ANALYZE residual_phev_versions_v1;

CREATE TEMP TABLE residual_phev_results_v1
ON COMMIT DROP
AS
SELECT
  version.*,
  pg_temp.safe_tco_residual_phev_v1(
    vehicle_cluster_id,
    display_variant_id
  ) AS result
FROM residual_phev_versions_v1 AS version
WHERE correction_code IS NOT NULL;

DO $verification$
DECLARE
  v_rules integer;
  v_corrected integer;
  v_hidden integer;
  v_failed integer;
  v_not_ready integer;
  v_missing_energy integer;
  v_duplicate_labels integer;
  v_bad_suzuki_name integer;
  v_private_read boolean;
BEGIN
  SELECT count(*) INTO v_rules
  FROM mvp.phev_residual_reclassification_rules_v1;

  SELECT count(*) INTO v_corrected
  FROM residual_phev_versions_v1
  WHERE correction_code IS NOT NULL;

  SELECT count(*) INTO v_hidden
  FROM residual_phev_versions_v1
  WHERE brand = 'Hyundai'
    AND model = 'Tucson'
    AND version_label =
      '2025 ' || chr(183) || ' Ibrida benzina ' || chr(183) || ' 179 CV';

  SELECT count(*) FILTER (
      WHERE NULLIF(result ->> '_audit_error', '') IS NOT NULL
    ),
    count(*) FILTER (
      WHERE NULLIF(result ->> '_audit_error', '') IS NULL
        AND result #>> '{quality,status}' <> 'ready'
    )
  INTO v_failed, v_not_ready
  FROM residual_phev_results_v1;

  SELECT count(*) INTO v_missing_energy
  FROM residual_phev_results_v1
  WHERE result #>> '{calculation_details,fuel_or_energy,method}'
      <> 'variant_wltp_weighted_combined_v1'
    OR NULLIF(
      result #>> '{calculation_details,fuel_or_energy,electric_consumption_kwh_100km}',
      ''
    ) IS NULL;

  SELECT count(*) INTO v_duplicate_labels
  FROM (
    SELECT brand, model, version_label
    FROM residual_phev_versions_v1
    GROUP BY brand, model, version_label
    HAVING count(*) > 1
  ) AS duplicate;

  SELECT count(*) INTO v_bad_suzuki_name
  FROM residual_phev_versions_v1
  WHERE brand = 'Suzuki'
    AND model = 'SUZUKI ACROSS';

  v_private_read := has_table_privilege(
    'anon',
    'mvp.phev_residual_reclassification_rules_v1',
    'SELECT'
  );

  IF v_rules <> 11
    OR v_corrected <> 10
    OR v_hidden <> 0
    OR v_failed <> 0
    OR v_not_ready <> 0
    OR v_missing_energy <> 0
    OR v_duplicate_labels <> 0
    OR v_bad_suzuki_name <> 0
    OR v_private_read
  THEN
    RAISE EXCEPTION
      'Verifica fallita: regole %, corrette %, Tucson stale %, errori %, non ready %, energia mancante %, duplicati %, Suzuki sporche %, regole leggibili %',
      v_rules,
      v_corrected,
      v_hidden,
      v_failed,
      v_not_ready,
      v_missing_energy,
      v_duplicate_labels,
      v_bad_suzuki_name,
      v_private_read;
  END IF;
END;
$verification$;

SELECT
  (SELECT count(*)
   FROM mvp.phev_residual_reclassification_rules_v1
   WHERE action = 'reclassify') AS plugin_riclassificate,
  (SELECT count(*)
   FROM mvp.phev_residual_reclassification_rules_v1
   WHERE action = 'hide') AS duplicati_obsoleti_nascosti,
  count(*) FILTER (
    WHERE result #>> '{quality,status}' = 'ready'
  ) AS calcoli_ready,
  count(*) FILTER (
    WHERE result #>> '{calculation_details,fuel_or_energy,method}'
      = 'variant_wltp_weighted_combined_v1'
  ) AS consumi_plugin_specifici,
  min(version_label) FILTER (
    WHERE brand = 'Suzuki'
  ) AS esempio_across,
  NOT has_table_privilege(
    'anon',
    'mvp.phev_residual_reclassification_rules_v1',
    'SELECT'
  ) AS dati_privati_protetti,
  'ok' AS verifica
FROM residual_phev_results_v1;

COMMIT;
