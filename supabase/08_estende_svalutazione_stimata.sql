-- Auto TCO - estende la svalutazione alle candidate ancora non collegate.
--
-- Priorita:
--   1. le svalutazioni e i prezzi originali restano invariati;
--   2. le 195 stime medium/medium_low gia pubblicate restano prioritarie;
--   3. vengono aggiunte soltanto candidate low costruite da veicoli della
--      stessa marca o dello stesso modello presenti nel database originale;
--   4. non vengono creati confronti tra marche diverse per i casi senza un
--      riferimento sufficientemente vicino.
--
-- L'anno 2025 dei profili sintetici e un riferimento tecnico interno coerente
-- con il catalogo EEA 2025. La funzione pubblica delle versioni continua a
-- mostrare gli anni del profilo originale del socio, non questi profili.

BEGIN;

ALTER TABLE mvp.vehicle_cluster_depreciation_profile_v1
  DROP CONSTRAINT IF EXISTS
    vehicle_cluster_depreciation_profile_v1_confidence_check;

ALTER TABLE mvp.vehicle_cluster_depreciation_profile_v1
  ADD CONSTRAINT vehicle_cluster_depreciation_profile_v1_confidence_check
  CHECK (price_confidence IN ('medium', 'medium_low', 'low'));

COMMENT ON TABLE mvp.vehicle_cluster_depreciation_profile_v1 IS
  'Collegamento separato fra cluster EEA e profili economici sintetici. I profili originali restano prioritari; low indica una stima orientativa da stessa marca o modello.';

DO $block$
DECLARE
  candidate_row record;
  synthetic_profile_id integer;
BEGIN
  FOR candidate_row IN
    SELECT
      catalog.vehicle_cluster_id,
      catalog.seed_model_id,
      catalog.brand,
      catalog.model,
      catalog.version_label,
      catalog.fuel_type,
      catalog.hybrid_type,
      catalog.power_kw,
      catalog.power_cv,
      catalog.consumption_l_100km,
      catalog.electric_consumption_kwh_100km,
      catalog.electric_range_km,
      catalog.registrations_count,
      candidate.estimated_new_price_eur,
      candidate.estimation_method,
      candidate.confidence,
      candidate.reference_profiles_count,
      candidate.reference_price_min_eur,
      candidate.reference_price_max_eur,
      candidate.depreciation_category,
      candidate.depreciation_brand_factor
    FROM mvp.vehicle_cluster_price_candidates_v1 AS candidate
    JOIN mvp.site_vehicle_catalog_eea_v2 AS catalog
      ON catalog.vehicle_cluster_id = candidate.vehicle_cluster_id
    WHERE candidate.confidence = 'low'
      AND catalog.depreciation_data_status = 'missing'
      AND catalog.model_key NOT IN (
        'UNKNOWN', 'UNK', 'NA', 'NULL', 'NOTAVAILABLE',
        'GV80GENESISGV80'
      )
      AND NOT EXISTS (
        SELECT 1
        FROM mvp.vehicle_cluster_depreciation_profile_v1 AS existing
        WHERE existing.vehicle_cluster_id = candidate.vehicle_cluster_id
      )
    ORDER BY catalog.vehicle_cluster_id
  LOOP
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
      consumption_l_100km,
      electric_consumption_kwh_100km,
      electric_range_km,
      confidence,
      source_notes,
      seed_model_id,
      profile_kind,
      source_type,
      source_records_count,
      popularity_score,
      profile_status,
      estimated_new_price_eur,
      depreciation_category,
      depreciation_brand_factor,
      depreciation_notes,
      uncertainty_profile_kind
    )
    VALUES (
      candidate_row.brand || ' ' || candidate_row.model
        || ' - ' || candidate_row.version_label
        || ' [profilo economico stimato]',
      candidate_row.brand,
      candidate_row.model,
      2025,
      2025,
      2025,
      candidate_row.fuel_type,
      candidate_row.hybrid_type,
      candidate_row.power_kw,
      candidate_row.power_cv,
      candidate_row.consumption_l_100km,
      candidate_row.electric_consumption_kwh_100km,
      candidate_row.electric_range_km,
      'low',
      format(
        'Profilo sintetico per cluster EEA %s; prezzo stimato con metodo %s da %s profili della stessa marca o modello.',
        candidate_row.vehicle_cluster_id,
        candidate_row.estimation_method,
        candidate_row.reference_profiles_count
      ),
      candidate_row.seed_model_id,
      'eea_cluster_price_estimate_v1',
      'modelled_from_existing_vehicle_profiles',
      candidate_row.reference_profiles_count,
      candidate_row.registrations_count,
      'active',
      candidate_row.estimated_new_price_eur,
      candidate_row.depreciation_category,
      candidate_row.depreciation_brand_factor,
      format(
        'Prezzo candidato %s euro; intervallo riferimenti %s-%s euro; metodo %s; affidabilita low.',
        candidate_row.estimated_new_price_eur,
        candidate_row.reference_price_min_eur,
        candidate_row.reference_price_max_eur,
        candidate_row.estimation_method
      ),
      'estimated_price_same_model_or_brand'
    )
    RETURNING id INTO synthetic_profile_id;

    INSERT INTO mvp.vehicle_cluster_depreciation_profile_v1 (
      vehicle_cluster_id,
      vehicle_profile_id,
      estimation_method,
      price_confidence
    )
    VALUES (
      candidate_row.vehicle_cluster_id,
      synthetic_profile_id,
      candidate_row.estimation_method,
      'low'
    );
  END LOOP;
END;
$block$;

GRANT SELECT ON mvp.vehicle_cluster_depreciation_profile_v1
  TO auto_tco_web;

COMMIT;

-- Verifica inclusa: deve terminare con verifica = ok.
WITH valid_catalog AS (
  SELECT *
  FROM mvp.site_vehicle_catalog_eea_v2
  WHERE model_key NOT IN (
    'UNKNOWN', 'UNK', 'NA', 'NULL', 'NOTAVAILABLE',
    'GV80GENESISGV80'
  )
), counts AS (
  SELECT
    count(*)::integer AS versioni_totali,
    count(*) FILTER (
      WHERE depreciation_data_status <> 'missing'
    )::integer AS con_svalutazione_originale,
    count(*) FILTER (
      WHERE depreciation_data_status = 'missing'
        AND mapping.vehicle_cluster_id IS NOT NULL
    )::integer AS con_svalutazione_stimata,
    count(*) FILTER (
      WHERE depreciation_data_status = 'missing'
        AND mapping.vehicle_cluster_id IS NULL
    )::integer AS ancora_mancanti,
    count(*) FILTER (
      WHERE mapping.price_confidence = 'medium'
    )::integer AS stime_medium,
    count(*) FILTER (
      WHERE mapping.price_confidence = 'medium_low'
    )::integer AS stime_medium_low,
    count(*) FILTER (
      WHERE mapping.price_confidence = 'low'
    )::integer AS stime_low,
    count(*) FILTER (
      WHERE mapping.vehicle_cluster_id IS NOT NULL
        AND depreciation_data_status <> 'missing'
    )::integer AS originali_sovrascritti,
    sum(registrations_count)::numeric AS immatricolazioni_totali,
    sum(registrations_count) FILTER (
      WHERE depreciation_data_status <> 'missing'
         OR mapping.vehicle_cluster_id IS NOT NULL
    )::numeric AS immatricolazioni_coperte
  FROM valid_catalog AS catalog
  LEFT JOIN mvp.vehicle_cluster_depreciation_profile_v1 AS mapping
    ON mapping.vehicle_cluster_id = catalog.vehicle_cluster_id
), low_sample AS (
  SELECT mapping.vehicle_cluster_id
  FROM mvp.vehicle_cluster_depreciation_profile_v1 AS mapping
  JOIN valid_catalog AS catalog
    ON catalog.vehicle_cluster_id = mapping.vehicle_cluster_id
  WHERE mapping.price_confidence = 'low'
  ORDER BY catalog.registrations_count DESC, mapping.vehicle_cluster_id
  LIMIT 1
), sample_result AS (
  SELECT mvp.estimate_vehicle_cluster_tco_ui_v2(
    low_sample.vehicle_cluster_id,
    15000,
    5,
    'italia',
    CURRENT_DATE
  ) AS payload
  FROM low_sample
)
SELECT
  versioni_totali,
  con_svalutazione_originale,
  con_svalutazione_stimata,
  ancora_mancanti,
  stime_medium,
  stime_medium_low,
  stime_low,
  originali_sovrascritti,
  round(
    100 * immatricolazioni_coperte
      / nullif(immatricolazioni_totali, 0),
    2
  ) AS copertura_mercato_percentuale,
  sample_result.payload #>> '{quality,status}' AS esempio_stato,
  sample_result.payload #>> '{quality,confidence,depreciation}'
    AS esempio_affidabilita,
  sample_result.payload #>> '{monthly_costs,depreciation_eur}'
    AS esempio_svalutazione_mensile,
  CASE
    WHEN versioni_totali = 1733
      AND con_svalutazione_originale = 795
      AND con_svalutazione_stimata = 662
      AND ancora_mancanti = 276
      AND stime_medium = 23
      AND stime_medium_low = 172
      AND stime_low = 467
      AND originali_sovrascritti = 0
      AND immatricolazioni_coperte
          / nullif(immatricolazioni_totali, 0) >= 0.95
      AND sample_result.payload #>> '{quality,status}' = 'ready'
      AND sample_result.payload #>> '{quality,confidence,depreciation}' = 'low'
      AND (
        sample_result.payload #>> '{monthly_costs,depreciation_eur}'
      )::numeric > 0
      THEN 'ok'
    ELSE 'controllare'
  END AS verifica
FROM counts
CROSS JOIN sample_result;
