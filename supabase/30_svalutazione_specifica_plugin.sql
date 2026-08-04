\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - svalutazione specifica della variante PHEV.
--
-- I listini pubblici ADAC sono espressi in euro ma appartengono al mercato
-- tedesco. Non vengono quindi usati come prezzi italiani assoluti. Per ogni
-- variante si calcola soltanto il rapporto rispetto alle altre PHEV dello
-- stesso modello, periodo e gruppo tecnico; tale rapporto corregge la
-- svalutazione gia prodotta dal motore italiano/interno esistente.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

CREATE TABLE IF NOT EXISTS mvp.phev_variant_price_factors_v1 (
  display_variant_id text PRIMARY KEY,
  vehicle_cluster_id text NOT NULL,
  model_catalog_id text NOT NULL,
  brand text NOT NULL,
  model text NOT NULL,
  year_from integer NOT NULL,
  year_to integer NOT NULL,
  system_power_kw numeric NOT NULL,
  system_power_cv numeric NOT NULL,
  thermal_power_kw numeric NOT NULL,
  thermal_power_cv numeric NOT NULL,
  variant_list_price_eur numeric NOT NULL,
  reference_list_price_eur numeric NOT NULL,
  price_factor numeric(12, 6) NOT NULL,
  variant_price_records integer NOT NULL,
  reference_price_records integer NOT NULL,
  source_name text NOT NULL,
  source_urls text[] NOT NULL,
  confidence text NOT NULL,
  built_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT phev_variant_price_factor_years_check CHECK (
    year_from BETWEEN 1990 AND 2100
    AND year_to BETWEEN year_from AND 2100
  ),
  CONSTRAINT phev_variant_price_factor_prices_check CHECK (
    variant_list_price_eur > 0
    AND reference_list_price_eur > 0
    AND price_factor BETWEEN 0.65 AND 1.50
    AND variant_price_records > 0
    AND reference_price_records > 0
  ),
  CONSTRAINT phev_variant_price_factor_confidence_check CHECK (
    confidence IN ('high', 'medium', 'low')
  )
);

COMMENT ON TABLE mvp.phev_variant_price_factors_v1 IS
'Fattori relativi di prezzo PHEV costruiti da listini pubblici dello stesso modello e periodo; non sono prezzi italiani assoluti.';

REVOKE ALL ON TABLE mvp.phev_variant_price_factors_v1
  FROM PUBLIC, anon, authenticated;

TRUNCATE TABLE mvp.phev_variant_price_factors_v1;

WITH model_ids AS (
  SELECT DISTINCT catalog.model_catalog_id
  FROM mvp.phev_system_power_catalog_v1 AS catalog
), public_variants AS (
  SELECT DISTINCT ON (version.item ->> 'display_variant_id')
    version.item
  FROM model_ids AS model
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(model.model_catalog_id) -> 'items'
  ) AS version(item)
  WHERE version.item ->> 'hybrid_type' = 'plug_in_hybrid'
    AND version.item ->> 'power_data_status' = 'verified'
    AND NULLIF(version.item ->> 'display_variant_id', '') IS NOT NULL
    AND NULLIF(version.item ->> 'vehicle_cluster_id', '') IS NOT NULL
    AND NULLIF(version.item ->> 'model_catalog_id', '') IS NOT NULL
    AND NULLIF(version.item ->> 'year_from', '')::integer
      BETWEEN 1990 AND 2100
    AND NULLIF(version.item ->> 'year_to', '')::integer
      BETWEEN 1990 AND 2100
  ORDER BY
    version.item ->> 'display_variant_id',
    NULLIF(version.item ->> 'year_to', '')::integer DESC
), priced_variants AS (
  SELECT
    variant.item,
    variant_price.median_price AS variant_list_price_eur,
    variant_price.price_records AS variant_price_records,
    variant_price.source_name,
    variant_price.source_urls,
    variant_price.confidence,
    reference_price.median_price AS reference_list_price_eur,
    reference_price.price_records AS reference_price_records
  FROM public_variants AS variant
  CROSS JOIN LATERAL (
    SELECT
      percentile_cont(0.5) WITHIN GROUP (
        ORDER BY catalog.representative_list_price_eur
      )::numeric AS median_price,
      count(*)::integer AS price_records,
      min(catalog.source_name) AS source_name,
      array_agg(DISTINCT catalog.source_url ORDER BY catalog.source_url)
        AS source_urls,
      CASE min(
        CASE catalog.confidence
          WHEN 'high' THEN 3
          WHEN 'medium' THEN 2
          ELSE 1
        END
      )
        WHEN 3 THEN 'high'
        WHEN 2 THEN 'medium'
        ELSE 'low'
      END AS confidence
    FROM mvp.phev_system_power_catalog_v1 AS catalog
    WHERE catalog.model_catalog_id = variant.item ->> 'model_catalog_id'
      AND abs(
        catalog.system_power_kw
          - (variant.item ->> 'system_power_kw')::numeric
      ) <= 1
      AND abs(
        catalog.thermal_power_kw
          - (variant.item ->> 'thermal_power_kw')::numeric
      ) <= 1
      AND catalog.year_from
        <= (variant.item ->> 'year_to')::integer
      AND coalesce(catalog.year_to, 2099)
        >= (variant.item ->> 'year_from')::integer
      AND catalog.representative_list_price_eur > 0
  ) AS variant_price
  CROSS JOIN LATERAL (
    SELECT
      percentile_cont(0.5) WITHIN GROUP (
        ORDER BY catalog.representative_list_price_eur
      )::numeric AS median_price,
      count(*)::integer AS price_records
    FROM mvp.phev_system_power_catalog_v1 AS catalog
    WHERE catalog.model_catalog_id = variant.item ->> 'model_catalog_id'
      AND catalog.year_from
        <= (variant.item ->> 'year_to')::integer
      AND coalesce(catalog.year_to, 2099)
        >= (variant.item ->> 'year_from')::integer
      AND catalog.representative_list_price_eur > 0
      AND (
        (
          NULLIF(variant.item ->> 'power_kw', '') IS NOT NULL
          AND (
            abs(
              catalog.thermal_power_kw
                - (variant.item ->> 'power_kw')::numeric
            ) <= 2
            OR abs(
              catalog.system_power_kw
                - (variant.item ->> 'power_kw')::numeric
            ) <= 2
          )
        )
        OR (
          NULLIF(variant.item ->> 'power_cv', '') IS NOT NULL
          AND (
            abs(
              catalog.thermal_power_cv
                - (variant.item ->> 'power_cv')::numeric
            ) <= 3
            OR abs(
              catalog.system_power_cv
                - (variant.item ->> 'power_cv')::numeric
            ) <= 3
          )
        )
      )
  ) AS reference_price
  WHERE variant_price.median_price > 0
    AND reference_price.median_price > 0
), valid_factors AS (
  SELECT
    priced.*,
    priced.variant_list_price_eur
      / priced.reference_list_price_eur AS raw_price_factor
  FROM priced_variants AS priced
  WHERE priced.variant_price_records > 0
    AND priced.reference_price_records > 0
)
INSERT INTO mvp.phev_variant_price_factors_v1 (
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
  variant_list_price_eur,
  reference_list_price_eur,
  price_factor,
  variant_price_records,
  reference_price_records,
  source_name,
  source_urls,
  confidence
)
SELECT
  item ->> 'display_variant_id',
  item ->> 'vehicle_cluster_id',
  item ->> 'model_catalog_id',
  item ->> 'brand',
  item ->> 'model',
  (item ->> 'year_from')::integer,
  (item ->> 'year_to')::integer,
  (item ->> 'system_power_kw')::numeric,
  (item ->> 'system_power_cv')::numeric,
  (item ->> 'thermal_power_kw')::numeric,
  (item ->> 'thermal_power_cv')::numeric,
  round(variant_list_price_eur, 2),
  round(reference_list_price_eur, 2),
  round(raw_price_factor, 6),
  variant_price_records,
  reference_price_records,
  source_name,
  source_urls,
  confidence
FROM valid_factors
WHERE raw_price_factor BETWEEN 0.65 AND 1.50;

CREATE INDEX IF NOT EXISTS idx_phev_variant_price_factor_cluster
ON mvp.phev_variant_price_factors_v1 (
  vehicle_cluster_id,
  display_variant_id
);

CREATE INDEX IF NOT EXISTS idx_phev_variant_price_factor_model
ON mvp.phev_variant_price_factors_v1 (
  model_catalog_id,
  year_from,
  year_to
);

ANALYZE mvp.phev_variant_price_factors_v1;

-- Conserva il motore precedente (inclusa la correzione del bollo) e avvolge
-- soltanto il risultato della svalutazione.
DO $block$
BEGIN
  IF to_regprocedure(
    'mvp.auto_tco_estimate_variant_before_depreciation_v1(text,text,integer,integer,text)'
  ) IS NULL THEN
    IF to_regprocedure(
      'public.auto_tco_estimate_variant(text,text,integer,integer,text)'
    ) IS NULL THEN
      RAISE EXCEPTION
        'Funzione public.auto_tco_estimate_variant non disponibile';
    END IF;

    EXECUTE
      'ALTER FUNCTION public.auto_tco_estimate_variant(text, text, integer, integer, text) '
      'RENAME TO auto_tco_estimate_variant_before_depreciation_v1';
    EXECUTE
      'ALTER FUNCTION public.auto_tco_estimate_variant_before_depreciation_v1(text, text, integer, integer, text) '
      'SET SCHEMA mvp';
  END IF;
END;
$block$;

REVOKE ALL ON FUNCTION
  mvp.auto_tco_estimate_variant_before_depreciation_v1(
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
  v_factor mvp.phev_variant_price_factors_v1%ROWTYPE;
  v_old_depreciation numeric;
  v_new_depreciation numeric;
  v_delta numeric;
  v_subtotal numeric;
  v_total numeric;
  v_depreciation_details jsonb;
  v_assumptions jsonb;
BEGIN
  v_result := mvp.auto_tco_estimate_variant_before_depreciation_v1(
    p_vehicle_cluster_id,
    p_display_variant_id,
    p_annual_km,
    p_ownership_years,
    p_region_code
  );

  SELECT factor.*
  INTO v_factor
  FROM mvp.phev_variant_price_factors_v1 AS factor
  WHERE factor.display_variant_id = trim(p_display_variant_id)
    AND factor.vehicle_cluster_id = trim(p_vehicle_cluster_id);

  IF NOT FOUND THEN
    RETURN v_result;
  END IF;

  v_old_depreciation := NULLIF(
    v_result #>> '{monthly_costs,depreciation_eur}',
    ''
  )::numeric;

  -- Se il motore base non dispone di una svalutazione, il listino tedesco
  -- non viene trasformato arbitrariamente in una valutazione italiana.
  IF v_old_depreciation IS NULL OR v_old_depreciation < 0 THEN
    RETURN v_result;
  END IF;

  v_new_depreciation := round(
    v_old_depreciation * v_factor.price_factor,
    2
  );
  v_delta := v_new_depreciation - v_old_depreciation;

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
    '{monthly_costs,depreciation_eur}',
    to_jsonb(v_new_depreciation),
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

  v_depreciation_details := coalesce(
    v_result #> '{calculation_details,depreciation}',
    '{}'::jsonb
  ) || jsonb_build_object(
    'method', 'variant_relative_public_list_price_v1',
    'base_monthly_depreciation_eur', v_old_depreciation,
    'variant_monthly_depreciation_eur', v_new_depreciation,
    'variant_list_price_reference_eur',
      v_factor.variant_list_price_eur,
    'comparison_list_price_reference_eur',
      v_factor.reference_list_price_eur,
    'relative_price_factor', v_factor.price_factor,
    'system_power_cv', v_factor.system_power_cv,
    'thermal_power_cv', v_factor.thermal_power_cv,
    'source_name', v_factor.source_name,
    'source_urls', to_jsonb(v_factor.source_urls),
    'source_market', 'Germania',
    'source_usage',
      'Il listino pubblico estero e usato soltanto come rapporto relativo fra varianti dello stesso modello e periodo.',
    'variant_price_records', v_factor.variant_price_records,
    'reference_price_records', v_factor.reference_price_records,
    'variant_price_confidence', v_factor.confidence
  );

  v_result := jsonb_set(
    v_result,
    '{calculation_details,depreciation}',
    v_depreciation_details,
    true
  );
  v_result := jsonb_set(
    v_result,
    '{descriptions,depreciation}',
    to_jsonb(
      'Perdita di valore stimata confrontando valore attuale e futuro; il prezzo della PHEV selezionata e distinto tramite listini pubblici dello stesso modello e periodo.'::text
    ),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,depreciation_variant_price_method}',
    to_jsonb('relative_public_list_price_same_model_period'::text),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,depreciation_variant_price_confidence}',
    to_jsonb(v_factor.confidence),
    true
  );

  v_assumptions := coalesce(v_result -> 'assumptions', '[]'::jsonb)
    || jsonb_build_array(
      'Per distinguere le varianti PHEV e stato applicato soltanto il rapporto fra listini pubblici dello stesso modello e periodo; il prezzo estero non e trattato come quotazione italiana.'
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
'Calcola il TCO correggendo bollo e svalutazione della variante PHEV con dati verificati lato server.';

REVOKE ALL ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) FROM PUBLIC, authenticated;
GRANT EXECUTE ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) TO anon;

NOTIFY pgrst, 'reload schema';

-- Verifica integrata su campioni di piu modelli e regressione non PHEV.
DO $block$
DECLARE
  v_mapping record;
  v_base jsonb;
  v_variant jsonb;
  v_expected numeric;
  v_checked integer := 0;
  v_non_phev_id text;
  v_non_phev_base jsonb;
  v_non_phev_variant jsonb;
  v_invalid integer;
  v_private_read boolean;
BEGIN
  SELECT count(*)
  INTO v_invalid
  FROM mvp.phev_variant_price_factors_v1 AS factor
  WHERE factor.price_factor NOT BETWEEN 0.65 AND 1.50
    OR factor.variant_list_price_eur <= 0
    OR factor.reference_list_price_eur <= 0
    OR cardinality(factor.source_urls) = 0;

  SELECT has_table_privilege(
    'anon',
    'mvp.phev_variant_price_factors_v1',
    'SELECT'
  ) INTO v_private_read;

  FOR v_mapping IN
    SELECT DISTINCT ON (factor.model_catalog_id)
      factor.*
    FROM mvp.phev_variant_price_factors_v1 AS factor
    WHERE factor.price_factor <> 1
    ORDER BY
      factor.model_catalog_id,
      abs(factor.price_factor - 1) DESC,
      factor.display_variant_id
    LIMIT 12
  LOOP
    v_base := mvp.auto_tco_estimate_variant_before_depreciation_v1(
      v_mapping.vehicle_cluster_id,
      v_mapping.display_variant_id,
      15000, 5, 'italia'
    );
    v_variant := public.auto_tco_estimate_variant(
      v_mapping.vehicle_cluster_id,
      v_mapping.display_variant_id,
      15000, 5, 'italia'
    );

    IF v_base #>> '{monthly_costs,depreciation_eur}' IS NOT NULL THEN
      v_expected := round(
        (v_base #>> '{monthly_costs,depreciation_eur}')::numeric
          * v_mapping.price_factor,
        2
      );

      IF (v_variant #>> '{monthly_costs,depreciation_eur}')::numeric
          <> v_expected
        OR v_variant #>> '{calculation_details,depreciation,method}'
          <> 'variant_relative_public_list_price_v1'
      THEN
        RAISE EXCEPTION
          'Svalutazione variante errata per %',
          v_mapping.display_variant_id;
      END IF;

      v_checked := v_checked + 1;
    END IF;
  END LOOP;

  SELECT catalog.vehicle_cluster_id
  INTO v_non_phev_id
  FROM mvp.site_vehicle_catalog_unified_v1 AS catalog
  WHERE coalesce(catalog.hybrid_type, 'none') <> 'plug_in_hybrid'
  ORDER BY catalog.registrations_count DESC, catalog.vehicle_cluster_id
  LIMIT 1;

  v_non_phev_base :=
    mvp.auto_tco_estimate_variant_before_depreciation_v1(
      v_non_phev_id,
      v_non_phev_id,
      15000, 5, 'italia'
    );
  v_non_phev_variant := public.auto_tco_estimate_variant(
    v_non_phev_id,
    v_non_phev_id,
    15000, 5, 'italia'
  );

  IF v_invalid <> 0
    OR v_private_read
    OR v_checked < 5
    OR v_non_phev_base <> v_non_phev_variant
  THEN
    RAISE EXCEPTION
      'Verifica svalutazione PHEV fallita: anomalie %, lettura privata %, campioni %, regressione %',
      v_invalid,
      v_private_read,
      v_checked,
      v_non_phev_base <> v_non_phev_variant;
  END IF;
END;
$block$;

COMMIT;

WITH counts AS (
  SELECT
    count(*)::integer AS varianti_con_fattore,
    count(DISTINCT model_catalog_id)::integer AS modelli_coperti,
    count(DISTINCT brand)::integer AS marche_coperte,
    count(*) FILTER (WHERE price_factor <> 1)::integer
      AS varianti_distinte_dal_riferimento,
    count(*) FILTER (WHERE confidence = 'high')::integer
      AS fattori_alta_affidabilita,
    count(*) FILTER (
      WHERE price_factor NOT BETWEEN 0.65 AND 1.50
    )::integer AS fattori_non_validi
  FROM mvp.phev_variant_price_factors_v1
), formentor AS (
  SELECT
    min(price_factor) FILTER (
      WHERE round(system_power_cv) = 204
    ) AS fattore_204,
    max(price_factor) FILTER (
      WHERE round(system_power_cv) = 245
    ) AS fattore_245,
    max(price_factor) FILTER (
      WHERE round(system_power_cv) = 272
    ) AS fattore_272
  FROM mvp.phev_variant_price_factors_v1
  WHERE lower(brand) = 'cupra'
    AND lower(model) = 'formentor'
)
SELECT
  counts.varianti_con_fattore,
  counts.modelli_coperti,
  counts.marche_coperte,
  counts.varianti_distinte_dal_riferimento,
  counts.fattori_alta_affidabilita,
  round(formentor.fattore_204, 4) AS formentor_204_fattore,
  round(formentor.fattore_245, 4) AS formentor_245_fattore,
  round(formentor.fattore_272, 4) AS formentor_272_fattore,
  NOT has_table_privilege(
    'anon',
    'mvp.phev_variant_price_factors_v1',
    'SELECT'
  ) AS dati_privati_protetti,
  CASE
    WHEN counts.varianti_con_fattore > 100
      AND counts.modelli_coperti >= 80
      AND counts.marche_coperte >= 20
      AND counts.varianti_distinte_dal_riferimento > 0
      AND counts.fattori_non_validi = 0
      AND NOT has_table_privilege(
        'anon',
        'mvp.phev_variant_price_factors_v1',
        'SELECT'
      )
    THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM counts
CROSS JOIN formentor;
