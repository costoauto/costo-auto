\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - audit mirato della svalutazione.
--
-- Non modifica oggetti permanenti e termina con ROLLBACK. L'audit separa:
--   * valori attuale/futuro provenienti da valutazioni documentate;
--   * prezzo da nuovo e curva interna;
--   * prezzi ereditati da profili comparabili;
--   * correzioni relative delle varianti PHEV.
--
-- A differenza dell'audit TCO completo, non ricalcola tutte le componenti di
-- tutte le versioni. La formula viene verificata su un campione stratificato.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

\echo 'Audit svalutazione: estrazione del catalogo pubblico...'

CREATE TEMP TABLE depreciation_public_versions_v1
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
    AS declared_vehicle_profile_id,
  item ->> 'fuel_type' AS fuel_type,
  item ->> 'hybrid_type' AS hybrid_type,
  NULLIF(item ->> 'year_from', '')::integer AS year_from,
  NULLIF(item ->> 'year_to', '')::integer AS year_to,
  item ->> 'depreciation_data_status' AS depreciation_data_status,
  item
FROM version_item
WHERE NULLIF(item ->> 'display_variant_id', '') IS NOT NULL
  AND NULLIF(item ->> 'vehicle_cluster_id', '') IS NOT NULL
ORDER BY
  public_model_id,
  item ->> 'display_variant_id',
  item ->> 'vehicle_cluster_id',
  NULLIF(item ->> 'year_to', '')::integer DESC NULLS LAST;

CREATE UNIQUE INDEX ON depreciation_public_versions_v1 (
  public_model_id,
  display_variant_id,
  vehicle_cluster_id
);
ANALYZE depreciation_public_versions_v1;

CREATE TEMP TABLE depreciation_profile_inventory_v1
ON COMMIT DROP
AS
WITH resolved AS (
  SELECT
    version.*,
    COALESCE(
      version.declared_vehicle_profile_id,
      CASE
        WHEN version.vehicle_cluster_id ~ '^profile:[0-9]+$'
          THEN split_part(version.vehicle_cluster_id, ':', 2)::integer
      END,
      mapping.vehicle_profile_id
    ) AS resolved_vehicle_profile_id,
    mapping.estimation_method AS cluster_price_method,
    mapping.price_confidence AS cluster_price_confidence
  FROM depreciation_public_versions_v1 AS version
  LEFT JOIN mvp.vehicle_cluster_depreciation_profile_v1 AS mapping
    ON mapping.vehicle_cluster_id = version.vehicle_cluster_id
), enriched AS (
  SELECT
    resolved.*,
    profile.representative_year,
    profile.profile_kind,
    profile.source_type,
    profile.confidence AS profile_confidence,
    profile.estimated_new_price_eur,
    profile.depreciation_category,
    profile.depreciation_brand_factor,
    profile.depreciation_notes,
    profile.uncertainty_profile_kind,
    profile.popularity_score,
    substring(
      coalesce(profile.depreciation_notes, '')
      FROM 'profilo comparabile ([0-9]+)'
    )::integer AS comparable_profile_id
  FROM resolved
  LEFT JOIN mvp.vehicle_profiles AS profile
    ON profile.id = resolved.resolved_vehicle_profile_id
)
SELECT
  enriched.*,
  comparable.brand AS comparable_brand,
  comparable.model AS comparable_model,
  comparable.representative_year AS comparable_year,
  comparable.fuel_type AS comparable_fuel_type,
  comparable.estimated_new_price_eur AS comparable_new_price_eur,
  CASE
    WHEN enriched.comparable_profile_id IS NULL THEN NULL
    WHEN comparable.seed_model_id = profile.seed_model_id
      THEN 'stesso_modello'
    WHEN lower(comparable.brand) = lower(profile.brand)
      THEN 'stessa_marca'
    ELSE 'altro'
  END AS comparable_relation,
  forecast.forecast_rows,
  forecast.forecast_horizons,
  forecast.latest_valuation_date,
  factor.price_factor AS phev_price_factor,
  factor.confidence AS phev_price_confidence,
  factor.source_name AS phev_price_source
FROM enriched
LEFT JOIN mvp.vehicle_profiles AS profile
  ON profile.id = enriched.resolved_vehicle_profile_id
LEFT JOIN mvp.vehicle_profiles AS comparable
  ON comparable.id = enriched.comparable_profile_id
LEFT JOIN LATERAL (
  SELECT
    count(*)::integer AS forecast_rows,
    count(DISTINCT value.horizon_months)::integer AS forecast_horizons,
    max(value.valuation_date) AS latest_valuation_date
  FROM mvp.vehicle_value_forecasts AS value
  WHERE value.vehicle_profile_id = enriched.resolved_vehicle_profile_id
) AS forecast ON true
LEFT JOIN mvp.phev_variant_price_factors_v1 AS factor
  ON factor.display_variant_id = enriched.display_variant_id
 AND factor.vehicle_cluster_id = enriched.vehicle_cluster_id;

CREATE INDEX ON depreciation_profile_inventory_v1 (
  profile_kind,
  profile_confidence
);
CREATE INDEX ON depreciation_profile_inventory_v1 (brand, model);
ANALYZE depreciation_profile_inventory_v1;

\echo 'Copertura e provenienza della svalutazione'

WITH summary AS (
  SELECT
    count(*)::integer AS versioni_pubbliche,
    count(DISTINCT resolved_vehicle_profile_id)::integer AS profili_usati,
    count(*) FILTER (
      WHERE resolved_vehicle_profile_id IS NULL
    )::integer AS collegamenti_profilo_mancanti,
    count(*) FILTER (
      WHERE estimated_new_price_eur IS NULL
         OR estimated_new_price_eur <= 0
    )::integer AS prezzi_nuovo_mancanti,
    count(*) FILTER (
      WHERE coalesce(forecast_rows, 0) > 0
    )::integer AS versioni_con_valori_documentati,
    count(*) FILTER (
      WHERE coalesce(forecast_rows, 0) = 0
    )::integer AS versioni_con_curva_interna,
    count(*) FILTER (
      WHERE comparable_profile_id IS NOT NULL
    )::integer AS versioni_con_prezzo_comparabile,
    count(*) FILTER (
      WHERE comparable_relation = 'stesso_modello'
    )::integer AS comparabili_stesso_modello,
    count(*) FILTER (
      WHERE comparable_relation = 'stessa_marca'
    )::integer AS comparabili_solo_stessa_marca,
    count(*) FILTER (
      WHERE phev_price_factor IS NOT NULL
    )::integer AS plugin_con_correzione_relativa
  FROM depreciation_profile_inventory_v1
)
SELECT
  *,
  CASE
    WHEN collegamenti_profilo_mancanti = 0
      AND prezzi_nuovo_mancanti = 0
      THEN 'ok_tecnico'
    ELSE 'controllare'
  END AS verifica_tecnica,
  CASE
    WHEN versioni_con_valori_documentati = 0
      THEN 'nessuna_quotazione_attuale_futura_documentata'
    ELSE 'presenti_valutazioni_documentate'
  END AS qualita_di_mercato
FROM summary;

\echo 'Distribuzione per origine del profilo economico'

SELECT
  coalesce(profile_kind, 'profilo_non_risolto') AS tipo_profilo,
  coalesce(source_type, 'fonte_non_indicata') AS fonte_profilo,
  coalesce(profile_confidence, 'missing') AS affidabilita_profilo,
  count(*) AS versioni,
  count(DISTINCT resolved_vehicle_profile_id) AS profili,
  round(avg(estimated_new_price_eur), 2) AS prezzo_nuovo_medio,
  round(
    percentile_cont(0.5) WITHIN GROUP (
      ORDER BY estimated_new_price_eur
    )::numeric,
    2
  ) AS prezzo_nuovo_mediano
FROM depreciation_profile_inventory_v1
GROUP BY profile_kind, source_type, profile_confidence
ORDER BY versioni DESC, tipo_profilo;

\echo 'Metodi delle stime di prezzo collegate ai cluster recenti'

SELECT
  coalesce(cluster_price_method, 'profilo_diretto') AS metodo_prezzo,
  coalesce(cluster_price_confidence, 'profilo_diretto') AS affidabilita,
  count(*) AS versioni
FROM depreciation_profile_inventory_v1
GROUP BY cluster_price_method, cluster_price_confidence
ORDER BY versioni DESC, metodo_prezzo;

\echo 'Eredita del prezzo nei profili storici: distanza dal comparabile'

SELECT
  count(*) FILTER (
    WHERE comparable_profile_id IS NOT NULL
  ) AS profili_con_riferimento_esplicito,
  count(*) FILTER (
    WHERE comparable_relation = 'stesso_modello'
  ) AS stesso_modello,
  count(*) FILTER (
    WHERE comparable_relation = 'stessa_marca'
  ) AS solo_stessa_marca,
  round(avg(abs(representative_year - comparable_year)), 2)
    AS distanza_media_anni,
  round(
    percentile_cont(0.95) WITHIN GROUP (
      ORDER BY abs(representative_year - comparable_year)
    )::numeric,
    2
  ) AS distanza_p95_anni,
  max(abs(representative_year - comparable_year))
    AS distanza_massima_anni,
  count(*) FILTER (
    WHERE abs(representative_year - comparable_year) > 5
  ) AS riferimenti_oltre_5_anni
FROM depreciation_profile_inventory_v1
WHERE profile_kind = 'eea_historical_compact_v1';

\echo 'Comparabili storici piu distanti da esaminare'

SELECT
  brand,
  model,
  version_label,
  representative_year,
  comparable_brand,
  comparable_model,
  comparable_year,
  comparable_relation,
  abs(representative_year - comparable_year) AS distanza_anni,
  estimated_new_price_eur AS prezzo_ereditato_eur
FROM depreciation_profile_inventory_v1
WHERE comparable_profile_id IS NOT NULL
ORDER BY
  abs(representative_year - comparable_year) DESC,
  brand,
  model,
  version_label
LIMIT 25;

\echo 'Curva residua e parametri realmente usati dal motore'

SELECT
  age_years AS eta_anni,
  residual_value_rate AS quota_del_prezzo_da_nuovo
FROM mvp.depreciation_residual_curve_v1
WHERE age_years IN (0, 1, 2, 3, 5, 10, 15, 20, 25, 30, 40)
ORDER BY age_years;

SELECT
  parameter_key AS parametro,
  parameter_value AS valore,
  description AS descrizione
FROM mvp.depreciation_model_parameters_v1
ORDER BY parameter_key;

-- Verifica funzionale della curva su un campione stratificato. Si limita a
-- 15 profili per tipo, evitando il costo del ricalcolo completo del TCO.
CREATE TEMP TABLE depreciation_sample_profiles_v1
ON COMMIT DROP
AS
WITH ranked AS (
  SELECT DISTINCT ON (
    coalesce(profile_kind, 'profilo_non_risolto'),
    resolved_vehicle_profile_id
  )
    coalesce(profile_kind, 'profilo_non_risolto') AS profile_kind,
    resolved_vehicle_profile_id,
    brand,
    model,
    version_label,
    popularity_score
  FROM depreciation_profile_inventory_v1
  WHERE resolved_vehicle_profile_id IS NOT NULL
  ORDER BY
    coalesce(profile_kind, 'profilo_non_risolto'),
    resolved_vehicle_profile_id,
    popularity_score DESC NULLS LAST
), numbered AS (
  SELECT
    ranked.*,
    row_number() OVER (
      PARTITION BY profile_kind
      ORDER BY popularity_score DESC NULLS LAST,
        resolved_vehicle_profile_id
    ) AS sample_rank
  FROM ranked
)
SELECT *
FROM numbered
WHERE sample_rank <= 15;

CREATE TEMP TABLE depreciation_formula_check_v1
ON COMMIT DROP
AS
SELECT
  sample.profile_kind,
  sample.resolved_vehicle_profile_id AS vehicle_profile_id,
  sample.brand,
  sample.model,
  sample.version_label,
  one.current_value_eur,
  one.future_value_eur AS valore_futuro_1_anno,
  five.future_value_eur AS valore_futuro_5_anni,
  ten.future_value_eur AS valore_futuro_10_anni,
  one.monthly_depreciation_eur AS mese_1_anno,
  five.monthly_depreciation_eur AS mese_5_anni,
  ten.monthly_depreciation_eur AS mese_10_anni,
  five.calculation_status,
  five.confidence,
  array_remove(ARRAY[
    CASE
      WHEN one.current_value_eur IS NULL
        OR five.current_value_eur IS NULL
        OR ten.current_value_eur IS NULL
        THEN 'valore_mancante'
    END,
    CASE
      WHEN one.future_value_eur > one.current_value_eur
        OR five.future_value_eur > five.current_value_eur
        OR ten.future_value_eur > ten.current_value_eur
        THEN 'valore_futuro_superiore_al_corrente'
    END,
    CASE
      WHEN one.future_value_eur + 0.01 < five.future_value_eur
        OR five.future_value_eur + 0.01 < ten.future_value_eur
        THEN 'valore_futuro_non_decrescente'
    END,
    CASE
      WHEN one.monthly_depreciation_eur + 0.01
          < five.monthly_depreciation_eur
        OR five.monthly_depreciation_eur + 0.01
          < ten.monthly_depreciation_eur
        THEN 'media_mensile_cresce_con_orizzonte'
    END,
    CASE
      WHEN one.monthly_depreciation_eur < 0
        OR five.monthly_depreciation_eur < 0
        OR ten.monthly_depreciation_eur < 0
        THEN 'svalutazione_negativa'
    END
  ], NULL) AS anomalie
FROM depreciation_sample_profiles_v1 AS sample
CROSS JOIN LATERAL mvp.estimate_vehicle_depreciation_v1(
  sample.resolved_vehicle_profile_id,
  15000,
  1,
  CURRENT_DATE
) AS one
CROSS JOIN LATERAL mvp.estimate_vehicle_depreciation_v1(
  sample.resolved_vehicle_profile_id,
  15000,
  5,
  CURRENT_DATE
) AS five
CROSS JOIN LATERAL mvp.estimate_vehicle_depreciation_v1(
  sample.resolved_vehicle_profile_id,
  15000,
  10,
  CURRENT_DATE
) AS ten;

\echo 'Verifica funzionale sul campione stratificato'

SELECT
  count(*) AS profili_testati,
  count(*) FILTER (
    WHERE cardinality(anomalie) > 0
  ) AS profili_con_anomalie,
  count(*) FILTER (
    WHERE calculation_status = 'modelled_internal_curve'
  ) AS campioni_curva_interna,
  count(*) FILTER (
    WHERE calculation_status <> 'modelled_internal_curve'
  ) AS campioni_valutazioni_documentate,
  round(avg(mese_5_anni), 2) AS svalutazione_media_5_anni,
  round(
    percentile_cont(0.5) WITHIN GROUP (
      ORDER BY mese_5_anni
    )::numeric,
    2
  ) AS svalutazione_mediana_5_anni,
  CASE
    WHEN count(*) FILTER (WHERE cardinality(anomalie) > 0) = 0
      THEN 'ok'
    ELSE 'controllare'
  END AS verifica
FROM depreciation_formula_check_v1;

SELECT
  brand,
  model,
  version_label,
  profile_kind,
  anomalie
FROM depreciation_formula_check_v1
WHERE cardinality(anomalie) > 0
ORDER BY brand, model, version_label;

ROLLBACK;
