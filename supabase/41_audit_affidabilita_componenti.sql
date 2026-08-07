\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - audit diagnostico dell'affidabilita delle componenti.
--
-- Non modifica alcun oggetto permanente e termina con ROLLBACK. Calcola
-- tutte le versioni pubblicate con lo scenario standard e misura, per ogni
-- componente, metodo e livello di affidabilita. Lo scopo e scegliere i
-- prossimi interventi in base all'impatto sul catalogo, non a casi isolati.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

CREATE OR REPLACE FUNCTION pg_temp.safe_tco_quality_v1(
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
  RETURN jsonb_build_object(
    '_audit_error', SQLSTATE || ': ' || SQLERRM
  );
END;
$function$;

\echo 'Audit qualita: estrazione delle versioni pubbliche...'

CREATE TEMP TABLE quality_public_versions_v1
ON COMMIT DROP
AS
WITH brand_item AS (
  SELECT brand.item
  FROM jsonb_array_elements(
    public.auto_tco_brands() -> 'items'
  ) AS brand(item)
), model_item AS (
  SELECT DISTINCT ON (model.item ->> 'model_catalog_id')
    model.item
  FROM brand_item AS brand
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_models(brand.item ->> 'brand_key') -> 'items'
  ) AS model(item)
  WHERE NULLIF(model.item ->> 'model_catalog_id', '') IS NOT NULL
  ORDER BY model.item ->> 'model_catalog_id'
), version_item AS (
  SELECT
    model.item ->> 'model_catalog_id' AS public_model_id,
    version.item
  FROM model_item AS model
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(
      model.item ->> 'model_catalog_id'
    ) -> 'items'
  ) AS version(item)
)
SELECT DISTINCT ON (
  public_model_id,
  item ->> 'display_variant_id',
  item ->> 'vehicle_cluster_id'
)
  public_model_id,
  item ->> 'brand' AS brand,
  item ->> 'model' AS model,
  item ->> 'version_label' AS version_label,
  item ->> 'display_variant_id' AS display_variant_id,
  item ->> 'vehicle_cluster_id' AS vehicle_cluster_id,
  NULLIF(item ->> 'vehicle_profile_id', '')::integer
    AS vehicle_profile_id,
  item ->> 'fuel_type' AS fuel_type,
  item ->> 'hybrid_type' AS hybrid_type,
  item ->> 'depreciation_data_status' AS depreciation_data_status,
  item ->> 'observation_quality' AS observation_quality,
  item
FROM version_item
WHERE NULLIF(item ->> 'display_variant_id', '') IS NOT NULL
  AND NULLIF(item ->> 'vehicle_cluster_id', '') IS NOT NULL
ORDER BY
  public_model_id,
  item ->> 'display_variant_id',
  item ->> 'vehicle_cluster_id',
  NULLIF(item ->> 'year_to', '')::integer DESC NULLS LAST;

CREATE UNIQUE INDEX ON quality_public_versions_v1 (
  public_model_id,
  display_variant_id,
  vehicle_cluster_id
);
CREATE INDEX ON quality_public_versions_v1 (brand, model);
ANALYZE quality_public_versions_v1;

\echo 'Audit qualita: calcolo TCO di tutte le versioni...'

CREATE TEMP TABLE quality_tco_results_v1
ON COMMIT DROP
AS
SELECT
  version.*,
  pg_temp.safe_tco_quality_v1(
    version.vehicle_cluster_id,
    version.display_variant_id
  ) AS payload
FROM quality_public_versions_v1 AS version;

CREATE INDEX ON quality_tco_results_v1 (brand, model);
ANALYZE quality_tco_results_v1;

CREATE TEMP TABLE quality_components_v1
ON COMMIT DROP
AS
SELECT
  result.public_model_id,
  result.brand,
  result.model,
  result.version_label,
  result.display_variant_id,
  result.vehicle_cluster_id,
  result.fuel_type,
  result.hybrid_type,
  result.depreciation_data_status,
  NULLIF(result.payload ->> '_audit_error', '') AS request_error,
  result.payload #>> '{quality,status}' AS quality_status,
  NULLIF(
    result.payload #>> '{monthly_costs,total_monthly_eur}',
    ''
  )::numeric AS total_monthly_eur,
  NULLIF(
    result.payload #>> '{monthly_costs,depreciation_eur}',
    ''
  )::numeric AS depreciation_eur,
  NULLIF(
    result.payload #>> '{monthly_costs,fuel_or_energy_eur}',
    ''
  )::numeric AS energy_eur,
  NULLIF(
    result.payload #>> '{monthly_costs,tax_eur}',
    ''
  )::numeric AS tax_eur,
  NULLIF(
    result.payload #>> '{monthly_costs,insurance_eur}',
    ''
  )::numeric AS insurance_eur,
  NULLIF(
    result.payload #>> '{monthly_costs,maintenance_eur}',
    ''
  )::numeric AS maintenance_eur,

  COALESCE(
    NULLIF(
      result.payload #>> '{quality,depreciation_variant_price_confidence}',
      ''
    ),
    NULLIF(
      result.payload #>> '{quality,confidence,depreciation}',
      ''
    ),
    CASE
      WHEN result.depreciation_data_status = 'original_profile'
        THEN 'original'
    END,
    'missing'
  ) AS depreciation_confidence,
  COALESCE(
    NULLIF(
      result.payload #>> '{calculation_details,depreciation,method}',
      ''
    ),
    NULLIF(
      result.payload #>> '{quality,depreciation_variant_price_method}',
      ''
    ),
    result.depreciation_data_status,
    'unknown'
  ) AS depreciation_method,

  COALESCE(
    NULLIF(
      result.payload #>> '{quality,energy_variant_confidence}',
      ''
    ),
    NULLIF(
      result.payload #>> '{quality,energy_source_confidence}',
      ''
    ),
    NULLIF(
      result.payload #>> '{calculation_details,fuel_or_energy,variant_energy_confidence}',
      ''
    ),
    NULLIF(energy_input.confidence, ''),
    NULLIF(profile.energy_input_confidence, ''),
    NULLIF(profile.confidence, ''),
    result.observation_quality,
    'missing'
  ) AS energy_confidence,
  COALESCE(
    NULLIF(
      result.payload #>> '{calculation_details,fuel_or_energy,method}',
      ''
    ),
    NULLIF(
      result.payload #>> '{quality,energy_source_method}',
      ''
    ),
    NULLIF(energy_input.thermal_method, ''),
    NULLIF(energy_input.electric_method, ''),
    NULLIF(profile.energy_input_source, ''),
    NULLIF(profile.source_type, ''),
    'unknown'
  ) AS energy_method,

  COALESCE(
    NULLIF(
      result.payload #>> '{calculation_details,tax,confidence}',
      ''
    ),
    NULLIF(
      result.payload #>> '{quality,confidence,tax}',
      ''
    ),
    'missing'
  ) AS tax_confidence,
  COALESCE(
    NULLIF(
      result.payload #>> '{calculation_details,tax,taxable_power_basis}',
      ''
    ),
    NULLIF(
      result.payload #>> '{calculation_details,tax,calculation_mode}',
      ''
    ),
    'regional_rules'
  ) AS tax_method,

  COALESCE(
    NULLIF(
      result.payload #>> '{calculation_details,insurance,confidence}',
      ''
    ),
    'missing'
  ) AS insurance_confidence,
  COALESCE(
    NULLIF(
      result.payload #>> '{calculation_details,insurance,method}',
      ''
    ),
    NULLIF(result.payload #>> '{quality,insurance_method}', ''),
    'unknown'
  ) AS insurance_method,

  COALESCE(
    NULLIF(
      result.payload #>> '{quality,confidence,maintenance}',
      ''
    ),
    NULLIF(
      result.payload #>> '{calculation_details,maintenance,confidence}',
      ''
    ),
    'missing'
  ) AS maintenance_confidence,
  COALESCE(
    NULLIF(
      result.payload #>> '{calculation_details,maintenance,method}',
      ''
    ),
    NULLIF(
      result.payload #>> '{quality,maintenance_year_method}',
      ''
    ),
    'unknown'
  ) AS maintenance_method
FROM quality_tco_results_v1 AS result
LEFT JOIN mvp.vehicle_cluster_energy_inputs_v1 AS energy_input
  ON energy_input.vehicle_cluster_id = result.vehicle_cluster_id
LEFT JOIN mvp.vehicle_profiles AS profile
  ON profile.id = result.vehicle_profile_id;

CREATE INDEX ON quality_components_v1 (brand, model);
ANALYZE quality_components_v1;

-- Forma lunga delle cinque componenti, utile per confrontare distribuzioni.
CREATE TEMP TABLE quality_component_long_v1
ON COMMIT DROP
AS
SELECT
  quality.public_model_id,
  quality.brand,
  quality.model,
  quality.version_label,
  quality.display_variant_id,
  quality.vehicle_cluster_id,
  quality.total_monthly_eur,
  component.component,
  component.monthly_eur,
  component.confidence,
  component.method,
  CASE component.confidence
    WHEN 'original' THEN 1
    WHEN 'verified' THEN 1
    WHEN 'high' THEN 1
    WHEN 'medium_high' THEN 2
    WHEN 'medium' THEN 3
    WHEN 'medium_low' THEN 4
    WHEN 'semiauto_low' THEN 5
    WHEN 'low' THEN 5
    WHEN 'missing' THEN 6
    ELSE 4
  END AS weakness_rank
FROM quality_components_v1 AS quality
CROSS JOIN LATERAL (
  VALUES
    (
      'svalutazione'::text,
      quality.depreciation_eur,
      quality.depreciation_confidence,
      quality.depreciation_method
    ),
    (
      'carburante_energia',
      quality.energy_eur,
      quality.energy_confidence,
      quality.energy_method
    ),
    (
      'bollo',
      quality.tax_eur,
      quality.tax_confidence,
      quality.tax_method
    ),
    (
      'assicurazione',
      quality.insurance_eur,
      quality.insurance_confidence,
      quality.insurance_method
    ),
    (
      'manutenzione',
      quality.maintenance_eur,
      quality.maintenance_confidence,
      quality.maintenance_method
    )
) AS component(component, monthly_eur, confidence, method);

CREATE INDEX ON quality_component_long_v1 (
  component,
  weakness_rank
);
ANALYZE quality_component_long_v1;

DO $verification$
DECLARE
  v_versions integer;
  v_errors integer;
  v_not_ready integer;
  v_missing_costs integer;
  v_component_rows integer;
BEGIN
  SELECT
    count(*),
    count(*) FILTER (WHERE request_error IS NOT NULL),
    count(*) FILTER (WHERE quality_status IS DISTINCT FROM 'ready'),
    count(*) FILTER (
      WHERE total_monthly_eur IS NULL
        OR depreciation_eur IS NULL
        OR energy_eur IS NULL
        OR tax_eur IS NULL
        OR insurance_eur IS NULL
        OR maintenance_eur IS NULL
    )
  INTO
    v_versions,
    v_errors,
    v_not_ready,
    v_missing_costs
  FROM quality_components_v1;

  SELECT count(*) INTO v_component_rows
  FROM quality_component_long_v1;

  IF v_versions < 4500
    OR v_errors <> 0
    OR v_not_ready <> 0
    OR v_missing_costs <> 0
    OR v_component_rows <> v_versions * 5
  THEN
    RAISE EXCEPTION
      'Audit qualita non valido: versioni %, errori %, non ready %, costi mancanti %, righe componente %',
      v_versions,
      v_errors,
      v_not_ready,
      v_missing_costs,
      v_component_rows;
  END IF;
END;
$verification$;

\echo 'Quadro generale'

SELECT
  count(*) AS versioni_controllate,
  count(*) FILTER (WHERE quality_status = 'ready') AS risultati_ready,
  count(*) FILTER (
    WHERE depreciation_confidence IN (
      'medium_low', 'semiauto_low', 'low', 'missing'
    )
  ) AS svalutazioni_deboli,
  count(*) FILTER (
    WHERE energy_confidence IN (
      'medium_low', 'semiauto_low', 'low', 'missing'
    )
  ) AS consumi_deboli,
  count(*) FILTER (
    WHERE tax_confidence IN (
      'medium_low', 'semiauto_low', 'low', 'missing'
    )
  ) AS bolli_deboli,
  count(*) FILTER (
    WHERE insurance_confidence IN (
      'medium_low', 'semiauto_low', 'low', 'missing'
    )
  ) AS assicurazioni_deboli,
  count(*) FILTER (
    WHERE maintenance_confidence IN (
      'medium_low', 'semiauto_low', 'low', 'missing'
    )
  ) AS manutenzioni_deboli,
  round(avg(total_monthly_eur), 2) AS totale_medio,
  round(percentile_cont(0.5) WITHIN GROUP (
    ORDER BY total_monthly_eur
  )::numeric, 2) AS totale_mediano,
  'ok' AS verifica
FROM quality_components_v1;

\echo 'Distribuzione dell affidabilita per componente'

SELECT
  component,
  confidence AS affidabilita,
  count(*) AS versioni,
  round(
    100.0 * count(*) / sum(count(*)) OVER (PARTITION BY component),
    2
  ) AS percentuale,
  round(avg(monthly_eur), 2) AS costo_medio_mensile
FROM quality_component_long_v1
GROUP BY component, confidence
ORDER BY
  component,
  min(weakness_rank),
  versioni DESC;

\echo 'Metodi piu usati per componente e affidabilita'

WITH method_counts AS (
  SELECT
    component,
    confidence,
    method,
    count(*) AS versioni,
    row_number() OVER (
      PARTITION BY component
      ORDER BY count(*) DESC, method
    ) AS method_rank
  FROM quality_component_long_v1
  GROUP BY component, confidence, method
)
SELECT
  component,
  confidence AS affidabilita,
  method,
  versioni
FROM method_counts
WHERE method_rank <= 10
ORDER BY component, method_rank;

\echo 'Famiglie di modelli da prioritizzare'

WITH model_quality AS (
  SELECT
    brand,
    model,
    count(DISTINCT display_variant_id) AS versioni,
    count(*) FILTER (
      WHERE component = 'svalutazione' AND weakness_rank >= 4
    ) AS svalutazioni_deboli,
    count(*) FILTER (
      WHERE component = 'carburante_energia' AND weakness_rank >= 4
    ) AS consumi_deboli,
    count(*) FILTER (
      WHERE component = 'bollo' AND weakness_rank >= 4
    ) AS bolli_deboli,
    count(*) FILTER (
      WHERE component = 'manutenzione' AND weakness_rank >= 4
    ) AS manutenzioni_deboli,
    count(*) FILTER (WHERE weakness_rank >= 4) AS lacune_totali,
    round(avg(total_monthly_eur), 2) AS totale_medio
  FROM quality_component_long_v1
  GROUP BY brand, model
)
SELECT
  brand,
  model,
  versioni,
  svalutazioni_deboli,
  consumi_deboli,
  bolli_deboli,
  manutenzioni_deboli,
  lacune_totali,
  totale_medio
FROM model_quality
WHERE lacune_totali > 0
ORDER BY
  lacune_totali DESC,
  versioni DESC,
  brand,
  model
LIMIT 40;

\echo 'Esempi delle versioni con piu componenti deboli'

WITH version_quality AS (
  SELECT
    brand,
    model,
    version_label,
    max(total_monthly_eur) AS totale_mensile,
    count(*) FILTER (WHERE weakness_rank >= 4) AS componenti_deboli,
    string_agg(
      component || ':' || confidence,
      ', ' ORDER BY component
    ) FILTER (WHERE weakness_rank >= 4) AS dettaglio
  FROM quality_component_long_v1
  GROUP BY brand, model, version_label
)
SELECT
  brand,
  model,
  version_label,
  componenti_deboli,
  dettaglio,
  round(totale_mensile, 2) AS totale_mensile
FROM version_quality
WHERE componenti_deboli > 0
ORDER BY
  componenti_deboli DESC,
  totale_mensile DESC,
  brand,
  model,
  version_label
LIMIT 30;

ROLLBACK;
