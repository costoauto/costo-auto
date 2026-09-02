\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - normalizza temporalmente i prezzi da nuova ereditati dai
-- profili storici EEA.
--
-- Problema corretto:
-- un profilo storico puo ereditare il prezzo nominale di una versione molto
-- piu recente. Usare lo stesso importo per anni lontani sovrastima il prezzo
-- da nuova storico e, di conseguenza, la svalutazione mensile.
--
-- Metodo:
-- il prezzo del comparabile viene riportato all'anno del profilo tramite il
-- rapporto fra gli indici HICP italiani della categoria "Motor cars".
-- Questa e soltanto una normalizzazione temporale del prezzo da nuova:
-- non e una quotazione dell'usato e non modifica la curva residua interna.
--
-- Fonte ufficiale:
-- Eurostat, dataset PRC_HICP_AIND, Italia, COICOP CP0711 "Motor cars",
-- unita INX_A_AVG. Serie 2010-2025 aggiornata il 6 febbraio 2026.
-- https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/prc_hicp_aind?geo=IT&coicop=CP0711&unit=INX_A_AVG&lang=en

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

CREATE TABLE IF NOT EXISTS mvp.motor_car_price_index_eurostat_v1 (
  reference_year integer PRIMARY KEY,
  index_value numeric(10,4) NOT NULL,
  geography_code text NOT NULL DEFAULT 'IT',
  coicop_code text NOT NULL DEFAULT 'CP0711',
  unit_code text NOT NULL DEFAULT 'INX_A_AVG',
  source_name text NOT NULL,
  source_url text NOT NULL,
  source_updated_at timestamptz NOT NULL,
  imported_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT motor_car_price_index_year_check
    CHECK (reference_year BETWEEN 1996 AND 2100),
  CONSTRAINT motor_car_price_index_value_check
    CHECK (index_value > 0),
  CONSTRAINT motor_car_price_index_geo_check
    CHECK (geography_code = 'IT'),
  CONSTRAINT motor_car_price_index_coicop_check
    CHECK (coicop_code = 'CP0711'),
  CONSTRAINT motor_car_price_index_unit_check
    CHECK (unit_code = 'INX_A_AVG')
);

COMMENT ON TABLE mvp.motor_car_price_index_eurostat_v1 IS
'Indice ufficiale Eurostat dei prezzi al consumo delle automobili in Italia. Serve esclusivamente a confrontare importi nominali di anni diversi; non contiene quotazioni dell usato.';

REVOKE ALL ON TABLE mvp.motor_car_price_index_eurostat_v1
FROM PUBLIC, anon, authenticated;

INSERT INTO mvp.motor_car_price_index_eurostat_v1 (
  reference_year,
  index_value,
  geography_code,
  coicop_code,
  unit_code,
  source_name,
  source_url,
  source_updated_at,
  imported_at
)
VALUES
  (2010,  90.7, 'IT', 'CP0711', 'INX_A_AVG', 'Eurostat PRC_HICP_AIND', 'https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/prc_hicp_aind?geo=IT&coicop=CP0711&unit=INX_A_AVG&lang=en', '2026-02-06 23:00:00+01', now()),
  (2011,  92.9, 'IT', 'CP0711', 'INX_A_AVG', 'Eurostat PRC_HICP_AIND', 'https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/prc_hicp_aind?geo=IT&coicop=CP0711&unit=INX_A_AVG&lang=en', '2026-02-06 23:00:00+01', now()),
  (2012,  94.2, 'IT', 'CP0711', 'INX_A_AVG', 'Eurostat PRC_HICP_AIND', 'https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/prc_hicp_aind?geo=IT&coicop=CP0711&unit=INX_A_AVG&lang=en', '2026-02-06 23:00:00+01', now()),
  (2013,  95.0, 'IT', 'CP0711', 'INX_A_AVG', 'Eurostat PRC_HICP_AIND', 'https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/prc_hicp_aind?geo=IT&coicop=CP0711&unit=INX_A_AVG&lang=en', '2026-02-06 23:00:00+01', now()),
  (2014,  98.1, 'IT', 'CP0711', 'INX_A_AVG', 'Eurostat PRC_HICP_AIND', 'https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/prc_hicp_aind?geo=IT&coicop=CP0711&unit=INX_A_AVG&lang=en', '2026-02-06 23:00:00+01', now()),
  (2015, 100.0, 'IT', 'CP0711', 'INX_A_AVG', 'Eurostat PRC_HICP_AIND', 'https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/prc_hicp_aind?geo=IT&coicop=CP0711&unit=INX_A_AVG&lang=en', '2026-02-06 23:00:00+01', now()),
  (2016, 101.0, 'IT', 'CP0711', 'INX_A_AVG', 'Eurostat PRC_HICP_AIND', 'https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/prc_hicp_aind?geo=IT&coicop=CP0711&unit=INX_A_AVG&lang=en', '2026-02-06 23:00:00+01', now()),
  (2017, 100.9, 'IT', 'CP0711', 'INX_A_AVG', 'Eurostat PRC_HICP_AIND', 'https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/prc_hicp_aind?geo=IT&coicop=CP0711&unit=INX_A_AVG&lang=en', '2026-02-06 23:00:00+01', now()),
  (2018, 101.2, 'IT', 'CP0711', 'INX_A_AVG', 'Eurostat PRC_HICP_AIND', 'https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/prc_hicp_aind?geo=IT&coicop=CP0711&unit=INX_A_AVG&lang=en', '2026-02-06 23:00:00+01', now()),
  (2019, 102.4, 'IT', 'CP0711', 'INX_A_AVG', 'Eurostat PRC_HICP_AIND', 'https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/prc_hicp_aind?geo=IT&coicop=CP0711&unit=INX_A_AVG&lang=en', '2026-02-06 23:00:00+01', now()),
  (2020, 103.9, 'IT', 'CP0711', 'INX_A_AVG', 'Eurostat PRC_HICP_AIND', 'https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/prc_hicp_aind?geo=IT&coicop=CP0711&unit=INX_A_AVG&lang=en', '2026-02-06 23:00:00+01', now()),
  (2021, 106.1, 'IT', 'CP0711', 'INX_A_AVG', 'Eurostat PRC_HICP_AIND', 'https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/prc_hicp_aind?geo=IT&coicop=CP0711&unit=INX_A_AVG&lang=en', '2026-02-06 23:00:00+01', now()),
  (2022, 111.9, 'IT', 'CP0711', 'INX_A_AVG', 'Eurostat PRC_HICP_AIND', 'https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/prc_hicp_aind?geo=IT&coicop=CP0711&unit=INX_A_AVG&lang=en', '2026-02-06 23:00:00+01', now()),
  (2023, 119.3, 'IT', 'CP0711', 'INX_A_AVG', 'Eurostat PRC_HICP_AIND', 'https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/prc_hicp_aind?geo=IT&coicop=CP0711&unit=INX_A_AVG&lang=en', '2026-02-06 23:00:00+01', now()),
  (2024, 121.3, 'IT', 'CP0711', 'INX_A_AVG', 'Eurostat PRC_HICP_AIND', 'https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/prc_hicp_aind?geo=IT&coicop=CP0711&unit=INX_A_AVG&lang=en', '2026-02-06 23:00:00+01', now()),
  (2025, 121.2, 'IT', 'CP0711', 'INX_A_AVG', 'Eurostat PRC_HICP_AIND', 'https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/prc_hicp_aind?geo=IT&coicop=CP0711&unit=INX_A_AVG&lang=en', '2026-02-06 23:00:00+01', now())
ON CONFLICT (reference_year) DO UPDATE
SET
  index_value = EXCLUDED.index_value,
  geography_code = EXCLUDED.geography_code,
  coicop_code = EXCLUDED.coicop_code,
  unit_code = EXCLUDED.unit_code,
  source_name = EXCLUDED.source_name,
  source_url = EXCLUDED.source_url,
  source_updated_at = EXCLUDED.source_updated_at,
  imported_at = EXCLUDED.imported_at;

CREATE TABLE IF NOT EXISTS mvp.depreciation_price_anchor_adjustments_v1 (
  vehicle_profile_id integer PRIMARY KEY
    REFERENCES mvp.vehicle_profiles(id),
  comparable_profile_id integer NOT NULL
    REFERENCES mvp.vehicle_profiles(id),
  comparable_relation text NOT NULL,
  profile_year integer NOT NULL,
  comparable_year integer NOT NULL,
  year_gap integer NOT NULL,
  original_new_price_eur numeric(14,2) NOT NULL,
  adjusted_new_price_eur numeric(14,2) NOT NULL,
  profile_year_index numeric(10,4) NOT NULL,
  comparable_year_index numeric(10,4) NOT NULL,
  adjustment_factor numeric(12,6) NOT NULL,
  adjustment_reason text NOT NULL,
  method text NOT NULL,
  confidence text NOT NULL,
  source_name text NOT NULL,
  source_url text NOT NULL,
  built_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT depreciation_anchor_relation_check
    CHECK (comparable_relation IN ('same_model', 'same_brand')),
  CONSTRAINT depreciation_anchor_year_gap_check
    CHECK (year_gap >= 0),
  CONSTRAINT depreciation_anchor_prices_check
    CHECK (original_new_price_eur > 0 AND adjusted_new_price_eur > 0),
  CONSTRAINT depreciation_anchor_factor_check
    CHECK (adjustment_factor BETWEEN 0.50 AND 1.50),
  CONSTRAINT depreciation_anchor_confidence_check
    CHECK (confidence IN ('medium_low', 'low'))
);

COMMENT ON TABLE mvp.depreciation_price_anchor_adjustments_v1 IS
'Traccia reversibile della normalizzazione temporale dei prezzi da nuova ereditati dai profili storici. I riferimenti allo stesso modello oltre cinque anni sono medium_low; quelli basati solo sulla marca restano low.';

REVOKE ALL ON TABLE mvp.depreciation_price_anchor_adjustments_v1
FROM PUBLIC, anon, authenticated;

-- Fotografia del calcolo precedente: permette di mostrare nello stesso output
-- l'impatto reale della correzione, senza dover eseguire un secondo script.
CREATE TEMP TABLE depreciation_before_price_normalization_v1
ON COMMIT DROP
AS
WITH candidates AS (
  SELECT
    profile.id AS vehicle_profile_id
  FROM mvp.vehicle_profiles AS profile
  JOIN mvp.vehicle_profiles AS comparable
    ON comparable.id = substring(
      coalesce(profile.depreciation_notes, '')
      FROM 'profilo comparabile ([0-9]+)'
    )::integer
  WHERE profile.profile_status = 'active'
    AND profile.profile_kind = 'eea_historical_compact_v1'
    AND profile.estimated_new_price_eur > 0
    AND profile.representative_year IS NOT NULL
    AND comparable.representative_year IS NOT NULL
    AND (
      profile.seed_model_id <> comparable.seed_model_id
      OR abs(
        profile.representative_year - comparable.representative_year
      ) > 5
    )
)
SELECT
  candidate.vehicle_profile_id,
  estimate.monthly_depreciation_eur AS monthly_depreciation_before_eur
FROM candidates AS candidate
CROSS JOIN LATERAL mvp.estimate_vehicle_depreciation_v1(
  candidate.vehicle_profile_id,
  15000,
  5,
  current_date
) AS estimate;

WITH source_candidates AS (
  SELECT
    profile.id AS vehicle_profile_id,
    comparable.id AS comparable_profile_id,
    CASE
      WHEN profile.seed_model_id = comparable.seed_model_id
        THEN 'same_model'
      ELSE 'same_brand'
    END AS comparable_relation,
    profile.representative_year AS profile_year,
    comparable.representative_year AS comparable_year,
    abs(
      profile.representative_year - comparable.representative_year
    ) AS year_gap,
    profile.estimated_new_price_eur AS original_new_price_eur,
    profile_index.index_value AS profile_year_index,
    comparable_index.index_value AS comparable_year_index,
    round(
      profile_index.index_value / comparable_index.index_value,
      6
    ) AS adjustment_factor,
    index_source.source_name,
    index_source.source_url
  FROM mvp.vehicle_profiles AS profile
  JOIN mvp.vehicle_profiles AS comparable
    ON comparable.id = substring(
      coalesce(profile.depreciation_notes, '')
      FROM 'profilo comparabile ([0-9]+)'
    )::integer
  JOIN mvp.motor_car_price_index_eurostat_v1 AS profile_index
    ON profile_index.reference_year = profile.representative_year
  JOIN mvp.motor_car_price_index_eurostat_v1 AS comparable_index
    ON comparable_index.reference_year = comparable.representative_year
  CROSS JOIN LATERAL (
    SELECT source.source_name, source.source_url
    FROM mvp.motor_car_price_index_eurostat_v1 AS source
    WHERE source.reference_year = profile.representative_year
  ) AS index_source
  WHERE profile.profile_status = 'active'
    AND profile.profile_kind = 'eea_historical_compact_v1'
    AND profile.estimated_new_price_eur > 0
    AND (
      (
        profile.seed_model_id = comparable.seed_model_id
        AND abs(
          profile.representative_year - comparable.representative_year
        ) > 5
      )
      OR profile.seed_model_id <> comparable.seed_model_id
    )
), prepared AS (
  SELECT
    source.*,
    round(
      source.original_new_price_eur * source.adjustment_factor,
      2
    ) AS adjusted_new_price_eur,
    CASE
      WHEN source.comparable_relation = 'same_model'
        THEN 'Comparabile dello stesso modello distante oltre cinque anni: corretto il solo effetto dei prezzi automobilistici nel tempo.'
      ELSE 'Comparabile disponibile soltanto nella stessa marca: corretto il solo effetto temporale; la corrispondenza del modello resta debole.'
    END AS adjustment_reason,
    CASE
      WHEN source.comparable_relation = 'same_model'
        THEN 'medium_low'
      ELSE 'low'
    END AS confidence
  FROM source_candidates AS source
)
INSERT INTO mvp.depreciation_price_anchor_adjustments_v1 AS target (
  vehicle_profile_id,
  comparable_profile_id,
  comparable_relation,
  profile_year,
  comparable_year,
  year_gap,
  original_new_price_eur,
  adjusted_new_price_eur,
  profile_year_index,
  comparable_year_index,
  adjustment_factor,
  adjustment_reason,
  method,
  confidence,
  source_name,
  source_url,
  built_at
)
SELECT
  prepared.vehicle_profile_id,
  prepared.comparable_profile_id,
  prepared.comparable_relation,
  prepared.profile_year,
  prepared.comparable_year,
  prepared.year_gap,
  prepared.original_new_price_eur,
  prepared.adjusted_new_price_eur,
  prepared.profile_year_index,
  prepared.comparable_year_index,
  prepared.adjustment_factor,
  prepared.adjustment_reason,
  'eurostat_motor_car_hicp_temporal_normalization_v1',
  prepared.confidence,
  prepared.source_name,
  prepared.source_url,
  now()
FROM prepared
WHERE prepared.adjustment_factor BETWEEN 0.50 AND 1.50
ON CONFLICT (vehicle_profile_id) DO UPDATE
SET
  comparable_profile_id = EXCLUDED.comparable_profile_id,
  comparable_relation = EXCLUDED.comparable_relation,
  profile_year = EXCLUDED.profile_year,
  comparable_year = EXCLUDED.comparable_year,
  year_gap = EXCLUDED.year_gap,
  adjusted_new_price_eur = round(
    target.original_new_price_eur
      * EXCLUDED.profile_year_index
      / EXCLUDED.comparable_year_index,
    2
  ),
  profile_year_index = EXCLUDED.profile_year_index,
  comparable_year_index = EXCLUDED.comparable_year_index,
  adjustment_factor = round(
    EXCLUDED.profile_year_index / EXCLUDED.comparable_year_index,
    6
  ),
  adjustment_reason = EXCLUDED.adjustment_reason,
  method = EXCLUDED.method,
  confidence = EXCLUDED.confidence,
  source_name = EXCLUDED.source_name,
  source_url = EXCLUDED.source_url,
  built_at = EXCLUDED.built_at;

-- Aggiorna soltanto il prezzo ancora uguale all'originale o gia uguale al
-- valore normalizzato. Un'eventuale correzione manuale successiva prevale.
UPDATE mvp.vehicle_profiles AS profile
SET
  estimated_new_price_eur = adjustment.adjusted_new_price_eur,
  depreciation_notes = CASE
    WHEN coalesce(profile.depreciation_notes, '') LIKE
      '%Eurostat CP0711 temporal normalization v1%'
      THEN profile.depreciation_notes
    ELSE concat_ws(
      ' ',
      profile.depreciation_notes,
      format(
        'Eurostat CP0711 temporal normalization v1: prezzo nominale %s EUR dell anno %s riportato all anno %s con fattore %s; non e una quotazione dell usato.',
        adjustment.original_new_price_eur,
        adjustment.comparable_year,
        adjustment.profile_year,
        adjustment.adjustment_factor
      )
    )
  END
FROM mvp.depreciation_price_anchor_adjustments_v1 AS adjustment
WHERE profile.id = adjustment.vehicle_profile_id
  AND profile.profile_status = 'active'
  AND profile.profile_kind = 'eea_historical_compact_v1'
  AND profile.estimated_new_price_eur IN (
    adjustment.original_new_price_eur,
    adjustment.adjusted_new_price_eur
  );

-- Il motore usa gia estimated_new_price_eur. Questo involucro non ritocca
-- gli importi: aggiunge al payload la provenienza della correzione affinche
-- backend e futuri strumenti di audit possano distinguerla.
DO $block$
BEGIN
  IF to_regprocedure(
    'mvp.auto_tco_estimate_variant_before_historical_price_index_v1(text,text,integer,integer,text)'
  ) IS NULL THEN
    IF to_regprocedure(
      'public.auto_tco_estimate_variant(text,text,integer,integer,text)'
    ) IS NULL THEN
      RAISE EXCEPTION
        'Funzione public.auto_tco_estimate_variant non disponibile';
    END IF;

    EXECUTE
      'ALTER FUNCTION public.auto_tco_estimate_variant(text,text,integer,integer,text) '
      'RENAME TO auto_tco_estimate_variant_before_historical_price_index_v1';
    EXECUTE
      'ALTER FUNCTION public.auto_tco_estimate_variant_before_historical_price_index_v1(text,text,integer,integer,text) '
      'SET SCHEMA mvp';
  END IF;
END;
$block$;

REVOKE ALL ON FUNCTION
  mvp.auto_tco_estimate_variant_before_historical_price_index_v1(
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
  v_profile_id integer;
  v_adjustment mvp.depreciation_price_anchor_adjustments_v1%ROWTYPE;
  v_details jsonb;
  v_assumptions jsonb;
BEGIN
  v_result :=
    mvp.auto_tco_estimate_variant_before_historical_price_index_v1(
      p_vehicle_cluster_id,
      p_display_variant_id,
      p_annual_km,
      p_ownership_years,
      p_region_code
    );

  v_profile_id := nullif(
    v_result #>> '{vehicle,vehicle_profile_id}',
    ''
  )::integer;

  IF v_profile_id IS NULL THEN
    RETURN v_result;
  END IF;

  SELECT adjustment.*
  INTO v_adjustment
  FROM mvp.depreciation_price_anchor_adjustments_v1 AS adjustment
  WHERE adjustment.vehicle_profile_id = v_profile_id;

  IF NOT FOUND THEN
    RETURN v_result;
  END IF;

  v_details := coalesce(
    v_result #> '{calculation_details,depreciation}',
    '{}'::jsonb
  ) || jsonb_build_object(
    'price_anchor_method', v_adjustment.method,
    'price_anchor_confidence', v_adjustment.confidence,
    'original_new_price_eur', v_adjustment.original_new_price_eur,
    'normalized_new_price_eur', v_adjustment.adjusted_new_price_eur,
    'profile_year', v_adjustment.profile_year,
    'comparable_year', v_adjustment.comparable_year,
    'comparable_relation', v_adjustment.comparable_relation,
    'year_gap', v_adjustment.year_gap,
    'temporal_adjustment_factor', v_adjustment.adjustment_factor,
    'price_index_source', v_adjustment.source_name,
    'price_index_source_url', v_adjustment.source_url,
    'market_valuation', false
  );

  v_result := jsonb_set(
    v_result,
    '{calculation_details,depreciation}',
    v_details,
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,depreciation_price_anchor_method}',
    to_jsonb(v_adjustment.method),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,depreciation_price_anchor_confidence}',
    to_jsonb(v_adjustment.confidence),
    true
  );

  v_assumptions := coalesce(v_result -> 'assumptions', '[]'::jsonb)
    || jsonb_build_array(
      'Il prezzo da nuova ereditato e stato riportato all anno della versione con l indice ufficiale Eurostat dei prezzi delle automobili; resta una stima modellata e non una quotazione dell usato.'
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
'Calcola il TCO e dichiara quando il prezzo da nuova storico e stato normalizzato con l indice Eurostat CP0711.';

REVOKE ALL ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) FROM PUBLIC, authenticated;
GRANT EXECUTE ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) TO anon;

NOTIFY pgrst, 'reload schema';

CREATE TEMP TABLE depreciation_after_price_normalization_v1
ON COMMIT DROP
AS
SELECT
  adjustment.vehicle_profile_id,
  estimate.monthly_depreciation_eur AS monthly_depreciation_after_eur
FROM mvp.depreciation_price_anchor_adjustments_v1 AS adjustment
CROSS JOIN LATERAL mvp.estimate_vehicle_depreciation_v1(
  adjustment.vehicle_profile_id,
  15000,
  5,
  current_date
) AS estimate;

DO $block$
DECLARE
  v_index_rows integer;
  v_adjustments integer;
  v_same_model integer;
  v_same_brand integer;
  v_price_mismatches integer;
  v_invalid_factors integer;
  v_missing_before integer;
  v_sample record;
  v_payload jsonb;
BEGIN
  SELECT count(*) INTO v_index_rows
  FROM mvp.motor_car_price_index_eurostat_v1
  WHERE reference_year BETWEEN 2010 AND 2025;

  SELECT
    count(*),
    count(*) FILTER (WHERE comparable_relation = 'same_model'),
    count(*) FILTER (WHERE comparable_relation = 'same_brand'),
    count(*) FILTER (
      WHERE adjustment_factor NOT BETWEEN 0.50 AND 1.50
    )
  INTO
    v_adjustments,
    v_same_model,
    v_same_brand,
    v_invalid_factors
  FROM mvp.depreciation_price_anchor_adjustments_v1;

  SELECT count(*) INTO v_price_mismatches
  FROM mvp.depreciation_price_anchor_adjustments_v1 AS adjustment
  JOIN mvp.vehicle_profiles AS profile
    ON profile.id = adjustment.vehicle_profile_id
  WHERE profile.estimated_new_price_eur
    <> adjustment.adjusted_new_price_eur;

  SELECT count(*) INTO v_missing_before
  FROM mvp.depreciation_price_anchor_adjustments_v1 AS adjustment
  LEFT JOIN depreciation_before_price_normalization_v1 AS before_value
    ON before_value.vehicle_profile_id = adjustment.vehicle_profile_id
  WHERE before_value.vehicle_profile_id IS NULL;

  SELECT
    version.item ->> 'vehicle_cluster_id' AS vehicle_cluster_id,
    version.item ->> 'display_variant_id' AS display_variant_id
  INTO v_sample
  FROM jsonb_array_elements(public.auto_tco_brands() -> 'items') AS brand(item)
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_models(brand.item ->> 'brand_key') -> 'items'
  ) AS model(item)
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(
      model.item ->> 'model_catalog_id'
    ) -> 'items'
  ) AS version(item)
  JOIN mvp.depreciation_price_anchor_adjustments_v1 AS adjustment
    ON adjustment.vehicle_profile_id = nullif(
      version.item ->> 'vehicle_profile_id',
      ''
    )::integer
  LIMIT 1;

  IF v_sample.vehicle_cluster_id IS NOT NULL THEN
    v_payload := public.auto_tco_estimate_variant(
      v_sample.vehicle_cluster_id,
      v_sample.display_variant_id,
      15000,
      5,
      'italia'
    );
  END IF;

  IF v_index_rows <> 16
    OR v_adjustments = 0
    OR v_same_model = 0
    OR v_same_brand = 0
    OR v_invalid_factors <> 0
    OR v_price_mismatches <> 0
    OR v_missing_before <> 0
    OR v_payload IS NULL
    OR v_payload #>> '{quality,status}' <> 'ready'
    OR v_payload #>>
      '{quality,depreciation_price_anchor_method}'
      <> 'eurostat_motor_car_hicp_temporal_normalization_v1'
  THEN
    RAISE EXCEPTION
      'Verifica fallita: indici %, rettifiche %, stesso modello %, stessa marca %, fattori non validi %, prezzi discordanti %, confronti mancanti %, stato %, metodo %',
      v_index_rows,
      v_adjustments,
      v_same_model,
      v_same_brand,
      v_invalid_factors,
      v_price_mismatches,
      v_missing_before,
      coalesce(v_payload #>> '{quality,status}', 'missing'),
      coalesce(
        v_payload #>>
          '{quality,depreciation_price_anchor_method}',
        'missing'
      );
  END IF;
END;
$block$;

WITH comparison AS (
  SELECT
    adjustment.*,
    before_value.monthly_depreciation_before_eur,
    after_value.monthly_depreciation_after_eur
  FROM mvp.depreciation_price_anchor_adjustments_v1 AS adjustment
  JOIN depreciation_before_price_normalization_v1 AS before_value
    USING (vehicle_profile_id)
  JOIN depreciation_after_price_normalization_v1 AS after_value
    USING (vehicle_profile_id)
), summary AS (
  SELECT
    count(*)::integer AS prezzi_storici_normalizzati,
    count(*) FILTER (
      WHERE comparable_relation = 'same_model'
    )::integer AS riferimenti_stesso_modello_oltre_5_anni,
    count(*) FILTER (
      WHERE comparable_relation = 'same_brand'
    )::integer AS riferimenti_solo_stessa_marca,
    round(min(adjustment_factor), 4) AS fattore_minimo,
    round(avg(adjustment_factor), 4) AS fattore_medio,
    round(max(adjustment_factor), 4) AS fattore_massimo,
    round(avg(monthly_depreciation_before_eur), 2)
      AS svalutazione_media_prima,
    round(avg(monthly_depreciation_after_eur), 2)
      AS svalutazione_media_dopo,
    count(*) FILTER (
      WHERE monthly_depreciation_after_eur IS NULL
        OR monthly_depreciation_after_eur < 0
    )::integer AS risultati_non_validi
  FROM comparison
)
SELECT
  *,
  CASE
    WHEN prezzi_storici_normalizzati > 0
      AND riferimenti_stesso_modello_oltre_5_anni > 0
      AND riferimenti_solo_stessa_marca > 0
      AND risultati_non_validi = 0
      THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM summary;

COMMIT;
