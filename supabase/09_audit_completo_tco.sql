-- Auto TCO - audit completo del catalogo pubblicato.
--
-- Controlla tutte le versioni valide usando gli stessi parametri predefiniti
-- del sito: 15.000 km/anno, 5 anni, Italia. Verifica inoltre che il costo
-- energetico cresca correttamente fra 5.000 e 50.000 km e che la svalutazione
-- mensile non aumenti allungando il possesso da 1 a 5 e 10 anni.

BEGIN;

-- L'audit richiama il motore di calcolo migliaia di volte. Il limite viene
-- esteso soltanto all'interno di questa transazione e torna automaticamente
-- al valore normale quando lo script termina.
SET LOCAL statement_timeout = '15min';

CREATE TABLE IF NOT EXISTS mvp.tco_audit_results_v1 (
  vehicle_cluster_id text PRIMARY KEY,
  brand text NOT NULL,
  model text NOT NULL,
  version_label text,
  powertrain_type text,
  calculation_status text,
  depreciation_confidence text,
  depreciation_eur numeric,
  fuel_or_energy_eur numeric,
  tax_eur numeric,
  insurance_eur numeric,
  available_subtotal_eur numeric,
  total_monthly_eur numeric,
  missing_components jsonb NOT NULL,
  anomaly_codes text[] NOT NULL,
  audited_at timestamptz NOT NULL DEFAULT now()
);

COMMENT ON TABLE mvp.tco_audit_results_v1 IS
  'Ultimo audit interno di tutti i risultati TCO pubblicati; non esposto alla Data API.';

REVOKE ALL ON TABLE mvp.tco_audit_results_v1
  FROM PUBLIC, anon, authenticated;

TRUNCATE TABLE mvp.tco_audit_results_v1;

WITH valid_catalog AS (
  SELECT *
  FROM mvp.site_vehicle_catalog_eea_v2
  WHERE model_key NOT IN (
    'UNKNOWN', 'UNK', 'NA', 'NULL', 'NOTAVAILABLE',
    'GV80GENESISGV80'
  )
), payloads AS (
  SELECT
    catalog.vehicle_cluster_id,
    catalog.brand,
    catalog.model,
    catalog.version_label,
    catalog.powertrain_type,
    mvp.estimate_vehicle_cluster_tco_ui_v2(
      catalog.vehicle_cluster_id,
      15000,
      5,
      'italia',
      CURRENT_DATE
    ) AS payload
  FROM valid_catalog AS catalog
), parsed AS (
  SELECT
    vehicle_cluster_id,
    brand,
    model,
    version_label,
    powertrain_type,
    payload #>> '{quality,status}' AS calculation_status,
    payload #>> '{quality,confidence,depreciation}'
      AS depreciation_confidence,
    NULLIF(payload #>> '{monthly_costs,depreciation_eur}', '')::numeric
      AS depreciation_eur,
    NULLIF(payload #>> '{monthly_costs,fuel_or_energy_eur}', '')::numeric
      AS fuel_or_energy_eur,
    NULLIF(payload #>> '{monthly_costs,tax_eur}', '')::numeric
      AS tax_eur,
    NULLIF(payload #>> '{monthly_costs,insurance_eur}', '')::numeric
      AS insurance_eur,
    NULLIF(
      payload #>> '{monthly_costs,available_subtotal_eur}',
      ''
    )::numeric AS available_subtotal_eur,
    NULLIF(payload #>> '{monthly_costs,total_monthly_eur}', '')::numeric
      AS total_monthly_eur,
    coalesce(
      payload #> '{quality,missing_required_components}',
      '[]'::jsonb
    ) AS missing_components
  FROM payloads
), flagged AS (
  SELECT
    parsed.*,
    array_remove(
      ARRAY[
        CASE
          WHEN calculation_status NOT IN ('ready', 'incomplete')
            THEN 'invalid_status'
        END,
        CASE
          WHEN coalesce(depreciation_eur, 0) < 0
            OR coalesce(fuel_or_energy_eur, 0) < 0
            OR coalesce(tax_eur, 0) < 0
            OR coalesce(insurance_eur, 0) < 0
            THEN 'negative_component'
        END,
        CASE
          WHEN fuel_or_energy_eur IS NULL OR fuel_or_energy_eur <= 0
            THEN 'energy_missing_or_zero'
        END,
        CASE
          WHEN tax_eur IS NULL
            THEN 'tax_missing'
        END,
        CASE
          WHEN tax_eur = 0 AND powertrain_type <> 'electric'
            THEN 'unexpected_zero_tax'
        END,
        CASE
          WHEN insurance_eur IS NULL OR insurance_eur <= 0
            THEN 'insurance_missing_or_zero'
        END,
        CASE
          WHEN depreciation_eur IS NOT NULL AND depreciation_eur <= 0
            THEN 'depreciation_not_positive'
        END,
        CASE
          WHEN depreciation_eur IS NULL
            AND NOT (missing_components ? 'depreciation')
            THEN 'depreciation_missing_not_declared'
        END,
        CASE
          WHEN calculation_status = 'ready'
            AND (
              total_monthly_eur IS NULL
              OR jsonb_array_length(missing_components) > 0
            )
            THEN 'ready_result_inconsistent'
        END,
        CASE
          WHEN calculation_status = 'incomplete'
            AND total_monthly_eur IS NOT NULL
            THEN 'partial_result_has_total'
        END,
        CASE
          WHEN EXISTS (
            SELECT 1
            FROM jsonb_array_elements_text(missing_components)
              AS missing(component)
            WHERE missing.component <> 'depreciation'
          )
            THEN 'unexpected_missing_component'
        END,
        CASE
          WHEN fuel_or_energy_eur IS NOT NULL
            AND tax_eur IS NOT NULL
            AND insurance_eur IS NOT NULL
            AND available_subtotal_eur IS NOT NULL
            AND abs(
              available_subtotal_eur
              - (
                coalesce(depreciation_eur, 0)
                + fuel_or_energy_eur
                + tax_eur
                + insurance_eur
              )
            ) > 0.06
            THEN 'subtotal_not_reconciled'
        END,
        CASE
          WHEN calculation_status = 'ready'
            AND total_monthly_eur IS NOT NULL
            AND available_subtotal_eur IS NOT NULL
            AND abs(total_monthly_eur - available_subtotal_eur) > 0.01
            THEN 'total_not_reconciled'
        END
      ]::text[],
      NULL
    ) AS anomaly_codes
  FROM parsed
)
INSERT INTO mvp.tco_audit_results_v1 (
  vehicle_cluster_id,
  brand,
  model,
  version_label,
  powertrain_type,
  calculation_status,
  depreciation_confidence,
  depreciation_eur,
  fuel_or_energy_eur,
  tax_eur,
  insurance_eur,
  available_subtotal_eur,
  total_monthly_eur,
  missing_components,
  anomaly_codes,
  audited_at
)
SELECT
  vehicle_cluster_id,
  brand,
  model,
  version_label,
  powertrain_type,
  calculation_status,
  depreciation_confidence,
  depreciation_eur,
  fuel_or_energy_eur,
  tax_eur,
  insurance_eur,
  available_subtotal_eur,
  total_monthly_eur,
  missing_components,
  anomaly_codes,
  now()
FROM flagged;

CREATE TEMP TABLE auto_tco_energy_audit
ON COMMIT PRESERVE ROWS
AS
WITH valid_catalog AS (
  SELECT *
  FROM mvp.site_vehicle_catalog_eea_v2
  WHERE model_key NOT IN (
    'UNKNOWN', 'UNK', 'NA', 'NULL', 'NOTAVAILABLE',
    'GV80GENESISGV80'
  )
)
SELECT
  catalog.vehicle_cluster_id,
  low.calculation_status AS low_status,
  high.calculation_status AS high_status,
  low.annual_energy_cost_eur AS low_cost,
  high.annual_energy_cost_eur AS high_cost,
  CASE
    WHEN low.calculation_status <> 'complete'
      OR high.calculation_status <> 'complete'
      OR low.annual_energy_cost_eur IS NULL
      OR high.annual_energy_cost_eur IS NULL
      OR low.annual_energy_cost_eur <= 0
      OR high.annual_energy_cost_eur <= low.annual_energy_cost_eur
      OR abs(
        high.annual_energy_cost_eur
        / nullif(low.annual_energy_cost_eur, 0)
        - 10
      ) > 0.02
      THEN true
    ELSE false
  END AS has_issue
FROM valid_catalog AS catalog
CROSS JOIN LATERAL mvp.estimate_vehicle_cluster_energy_v1(
  catalog.vehicle_cluster_id,
  5000,
  'italia',
  CURRENT_DATE
) AS low
CROSS JOIN LATERAL mvp.estimate_vehicle_cluster_energy_v1(
  catalog.vehicle_cluster_id,
  50000,
  'italia',
  CURRENT_DATE
) AS high;

CREATE TEMP TABLE auto_tco_depreciation_audit
ON COMMIT PRESERVE ROWS
AS
WITH valid_catalog AS (
  SELECT *
  FROM mvp.site_vehicle_catalog_eea_v2
  WHERE model_key NOT IN (
    'UNKNOWN', 'UNK', 'NA', 'NULL', 'NOTAVAILABLE',
    'GV80GENESISGV80'
  )
), resolved_profiles AS (
  SELECT
    catalog.vehicle_cluster_id,
    CASE
      WHEN catalog.depreciation_data_status <> 'missing'
        THEN catalog.vehicle_profile_id
      ELSE mapping.vehicle_profile_id
    END AS vehicle_profile_id
  FROM valid_catalog AS catalog
  LEFT JOIN mvp.vehicle_cluster_depreciation_profile_v1 AS mapping
    ON mapping.vehicle_cluster_id = catalog.vehicle_cluster_id
  WHERE catalog.depreciation_data_status <> 'missing'
     OR mapping.vehicle_cluster_id IS NOT NULL
)
SELECT
  resolved.vehicle_cluster_id,
  one.monthly_depreciation_eur AS one_year_monthly,
  five.monthly_depreciation_eur AS five_year_monthly,
  ten.monthly_depreciation_eur AS ten_year_monthly,
  CASE
    WHEN one.monthly_depreciation_eur IS NULL
      OR five.monthly_depreciation_eur IS NULL
      OR ten.monthly_depreciation_eur IS NULL
      OR one.monthly_depreciation_eur <= 0
      OR five.monthly_depreciation_eur <= 0
      OR ten.monthly_depreciation_eur <= 0
      OR one.monthly_depreciation_eur + 0.01
          < five.monthly_depreciation_eur
      OR five.monthly_depreciation_eur + 0.01
          < ten.monthly_depreciation_eur
      THEN true
    ELSE false
  END AS has_issue
FROM resolved_profiles AS resolved
CROSS JOIN LATERAL mvp.estimate_vehicle_depreciation_v1(
  resolved.vehicle_profile_id,
  15000,
  1,
  CURRENT_DATE
) AS one
CROSS JOIN LATERAL mvp.estimate_vehicle_depreciation_v1(
  resolved.vehicle_profile_id,
  15000,
  5,
  CURRENT_DATE
) AS five
CROSS JOIN LATERAL mvp.estimate_vehicle_depreciation_v1(
  resolved.vehicle_profile_id,
  15000,
  10,
  CURRENT_DATE
) AS ten;

COMMIT;

-- Se esistono anomalie, questa tabella mostra fino a 20 casi concreti.
SELECT
  brand,
  model,
  version_label,
  anomaly_codes
FROM mvp.tco_audit_results_v1
WHERE cardinality(anomaly_codes) > 0
ORDER BY brand, model, version_label
LIMIT 20;

-- Riepilogo finale: il risultato ideale termina con verifica = ok.
WITH result_summary AS (
  SELECT
    count(*)::integer AS versioni_controllate,
    count(*) FILTER (
      WHERE calculation_status = 'ready'
    )::integer AS risultati_completi,
    count(*) FILTER (
      WHERE calculation_status = 'incomplete'
    )::integer AS risultati_parziali,
    count(*) FILTER (
      WHERE missing_components ? 'depreciation'
    )::integer AS svalutazioni_mancanti,
    count(*) FILTER (
      WHERE tax_eur = 0
    )::integer AS bolli_zero,
    count(*) FILTER (
      WHERE tax_eur = 0 AND powertrain_type <> 'electric'
    )::integer AS bolli_zero_non_elettrici,
    count(*) FILTER (
      WHERE cardinality(anomaly_codes) > 0
    )::integer AS risultati_con_anomalie,
    round(min(total_monthly_eur), 2) AS totale_minimo,
    round(
      (
        percentile_cont(0.5) WITHIN GROUP (
          ORDER BY total_monthly_eur
        ) FILTER (WHERE total_monthly_eur IS NOT NULL)
      )::numeric,
      2
    ) AS totale_mediano,
    round(
      (
        percentile_cont(0.95) WITHIN GROUP (
          ORDER BY total_monthly_eur
        ) FILTER (WHERE total_monthly_eur IS NOT NULL)
      )::numeric,
      2
    ) AS totale_p95,
    round(max(total_monthly_eur), 2) AS totale_massimo
  FROM mvp.tco_audit_results_v1
), slider_summary AS (
  SELECT
    count(*)::integer AS versioni_energia_controllate,
    count(*) FILTER (WHERE has_issue)::integer AS problemi_slider_km
  FROM auto_tco_energy_audit
), depreciation_summary AS (
  SELECT
    count(*)::integer AS svalutazioni_controllate,
    count(*) FILTER (WHERE has_issue)::integer
      AS problemi_slider_anni
  FROM auto_tco_depreciation_audit
)
SELECT
  result_summary.versioni_controllate,
  result_summary.risultati_completi,
  result_summary.risultati_parziali,
  result_summary.svalutazioni_mancanti,
  result_summary.bolli_zero,
  result_summary.bolli_zero_non_elettrici,
  result_summary.risultati_con_anomalie,
  slider_summary.versioni_energia_controllate,
  slider_summary.problemi_slider_km,
  depreciation_summary.svalutazioni_controllate,
  depreciation_summary.problemi_slider_anni,
  result_summary.totale_minimo,
  result_summary.totale_mediano,
  result_summary.totale_p95,
  result_summary.totale_massimo,
  CASE
    WHEN result_summary.versioni_controllate = 1733
      AND result_summary.risultati_completi = 1457
      AND result_summary.risultati_parziali = 276
      AND result_summary.svalutazioni_mancanti = 276
      AND result_summary.bolli_zero_non_elettrici = 0
      AND result_summary.risultati_con_anomalie = 0
      AND slider_summary.versioni_energia_controllate = 1733
      AND slider_summary.problemi_slider_km = 0
      AND depreciation_summary.svalutazioni_controllate = 1457
      AND depreciation_summary.problemi_slider_anni = 0
      THEN 'ok'
    ELSE 'controllare'
  END AS verifica
FROM result_summary
CROSS JOIN slider_summary
CROSS JOIN depreciation_summary;
