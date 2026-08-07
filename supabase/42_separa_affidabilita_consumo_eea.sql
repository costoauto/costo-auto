\set ON_ERROR_STOP on
\pset pager off

-- Auto TCO - separa l'affidabilita energetica da quella economica.
--
-- I profili storici EEA compatti contengono sia un consumo sia un prezzo da
-- nuovo ereditato da un profilo comparabile. Il campo confidence del profilo
-- descriveva l'insieme, percio l'audit energetico finiva per attribuire al
-- consumo l'incertezza del prezzo. Questa migrazione conserva i valori e
-- collega al consumo il metodo e la confidenza gia presenti nella tabella
-- EEA compatta: dato diretto, stesso modello o comparabile.

BEGIN;
SET LOCAL statement_timeout = '0';
SET LOCAL lock_timeout = '10s';

CREATE TABLE IF NOT EXISTS mvp.historical_energy_provenance_v1 (
  vehicle_profile_id integer PRIMARY KEY,
  vehicle_cluster_id text NOT NULL UNIQUE,
  historical_version_id text NOT NULL,
  seed_model_id integer NOT NULL,
  brand text NOT NULL,
  model text NOT NULL,
  representative_year integer NOT NULL,
  fuel_type text NOT NULL,
  hybrid_type text NOT NULL,
  power_kw numeric NOT NULL,
  thermal_consumption_per_100km numeric,
  electric_consumption_kwh_100km numeric,
  registrations_count bigint NOT NULL,
  source_records_count integer NOT NULL,
  energy_method text NOT NULL,
  energy_confidence text NOT NULL,
  source_name text NOT NULL,
  source_url text NOT NULL,
  built_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT historical_energy_provenance_confidence_check
    CHECK (energy_confidence IN ('high', 'medium', 'low')),
  CONSTRAINT historical_energy_provenance_counts_check
    CHECK (registrations_count >= 3 AND source_records_count > 0),
  CONSTRAINT historical_energy_provenance_year_check
    CHECK (representative_year BETWEEN 2010 AND 2024)
);

COMMENT ON TABLE mvp.historical_energy_provenance_v1 IS
'Provenienza privata del consumo dei profili storici EEA, separata dall affidabilita del prezzo e della svalutazione.';

REVOKE ALL ON mvp.historical_energy_provenance_v1
FROM PUBLIC, anon, authenticated;

TRUNCATE TABLE mvp.historical_energy_provenance_v1;

WITH matched AS (
  SELECT
    profile.id AS vehicle_profile_id,
    'profile:' || profile.id::text AS vehicle_cluster_id,
    source.historical_version_id,
    source.seed_model_id,
    profile.brand,
    profile.model,
    profile.representative_year,
    profile.fuel_type,
    coalesce(profile.hybrid_type, 'none') AS hybrid_type,
    profile.power_kw,
    source.consumption_l_100km,
    source.electric_consumption_kwh_100km,
    source.registrations_count,
    source.source_records_count,
    source.energy_method,
    source.confidence AS energy_confidence,
    row_number() OVER (
      PARTITION BY profile.id
      ORDER BY
        CASE source.confidence
          WHEN 'high' THEN 1
          WHEN 'medium' THEN 2
          ELSE 3
        END,
        source.source_records_count DESC,
        source.registrations_count DESC,
        source.historical_version_id
    ) AS source_rank
  FROM mvp.vehicle_profiles AS profile
  JOIN mvp.eea_historical_versions_compact_v1 AS source
    ON source.seed_model_id = profile.seed_model_id
   AND source.representative_year = profile.representative_year
   AND source.fuel_type = profile.fuel_type
   AND source.hybrid_type = coalesce(profile.hybrid_type, 'none')
   AND abs(source.power_kw - profile.power_kw) <= 0.5
  WHERE profile.profile_status = 'active'
    AND profile.profile_kind = 'eea_historical_compact_v1'
)
INSERT INTO mvp.historical_energy_provenance_v1 (
  vehicle_profile_id,
  vehicle_cluster_id,
  historical_version_id,
  seed_model_id,
  brand,
  model,
  representative_year,
  fuel_type,
  hybrid_type,
  power_kw,
  thermal_consumption_per_100km,
  electric_consumption_kwh_100km,
  registrations_count,
  source_records_count,
  energy_method,
  energy_confidence,
  source_name,
  source_url,
  built_at
)
SELECT
  vehicle_profile_id,
  vehicle_cluster_id,
  historical_version_id,
  seed_model_id,
  brand,
  model,
  representative_year,
  fuel_type,
  hybrid_type,
  power_kw,
  consumption_l_100km,
  electric_consumption_kwh_100km,
  registrations_count,
  source_records_count,
  energy_method,
  energy_confidence,
  'European Environment Agency - CO2 monitoring for cars',
  'https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b',
  now()
FROM matched
WHERE source_rank = 1;

CREATE INDEX IF NOT EXISTS idx_historical_energy_provenance_method_v1
ON mvp.historical_energy_provenance_v1 (
  energy_confidence,
  energy_method
);

CREATE INDEX IF NOT EXISTS idx_historical_energy_provenance_model_v1
ON mvp.historical_energy_provenance_v1 (
  brand,
  model,
  representative_year
);

ANALYZE mvp.historical_energy_provenance_v1;

-- Conserva l'affidabilita economica complessiva del profilo e valorizza i
-- due campi specifici gia previsti per l'energia.
UPDATE mvp.vehicle_profiles AS profile
SET
  energy_input_source = provenance.energy_method,
  energy_input_confidence = provenance.energy_confidence
FROM mvp.historical_energy_provenance_v1 AS provenance
WHERE profile.id = provenance.vehicle_profile_id;

-- Normalmente i profili storici non sono presenti in questa cache; il ramo
-- rende comunque coerente un'eventuale riga gia materializzata.
UPDATE mvp.vehicle_cluster_energy_inputs_v1 AS input
SET
  thermal_method = CASE
    WHEN provenance.thermal_consumption_per_100km IS NOT NULL
      THEN provenance.energy_method
    ELSE input.thermal_method
  END,
  electric_method = CASE
    WHEN provenance.electric_consumption_kwh_100km IS NOT NULL
      THEN provenance.energy_method
    ELSE input.electric_method
  END,
  thermal_reference_count = CASE
    WHEN provenance.thermal_consumption_per_100km IS NOT NULL
      THEN provenance.source_records_count
    ELSE input.thermal_reference_count
  END,
  electric_reference_count = CASE
    WHEN provenance.electric_consumption_kwh_100km IS NOT NULL
      THEN provenance.source_records_count
    ELSE input.electric_reference_count
  END,
  confidence = provenance.energy_confidence,
  built_at = now()
FROM mvp.historical_energy_provenance_v1 AS provenance
WHERE input.vehicle_cluster_id = provenance.vehicle_cluster_id;

-- Espone metodo, numerosita e fonte nella risposta della singola versione.
-- Le PHEV con consumi specifici verificati restano prioritarie.
DO $block$
BEGIN
  IF to_regprocedure(
    'mvp.auto_tco_estimate_variant_before_historical_energy_provenance_v1(text,text,integer,integer,text)'
  ) IS NULL THEN
    IF to_regprocedure(
      'public.auto_tco_estimate_variant(text,text,integer,integer,text)'
    ) IS NULL THEN
      RAISE EXCEPTION
        'Funzione public.auto_tco_estimate_variant non disponibile';
    END IF;

    EXECUTE
      'ALTER FUNCTION public.auto_tco_estimate_variant(text,text,integer,integer,text) '
      'RENAME TO auto_tco_estimate_variant_before_historical_energy_provenance_v1';
    EXECUTE
      'ALTER FUNCTION public.auto_tco_estimate_variant_before_historical_energy_provenance_v1(text,text,integer,integer,text) '
      'SET SCHEMA mvp';
  END IF;
END;
$block$;

REVOKE ALL ON FUNCTION
  mvp.auto_tco_estimate_variant_before_historical_energy_provenance_v1(
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
  v_provenance mvp.historical_energy_provenance_v1%ROWTYPE;
  v_details jsonb;
  v_assumptions jsonb;
BEGIN
  v_result :=
    mvp.auto_tco_estimate_variant_before_historical_energy_provenance_v1(
      p_vehicle_cluster_id,
      p_display_variant_id,
      p_annual_km,
      p_ownership_years,
      p_region_code
    );

  -- Non sostituisce il metodo PHEV specifico applicato dalle migrazioni
  -- 31 e 40, che e piu preciso del profilo compatto.
  IF v_result #>> '{calculation_details,fuel_or_energy,method}'
      = 'variant_wltp_weighted_combined_v1'
  THEN
    RETURN v_result;
  END IF;

  IF trim(p_vehicle_cluster_id) !~ '^profile:[0-9]{1,10}$' THEN
    RETURN v_result;
  END IF;

  v_profile_id := substring(trim(p_vehicle_cluster_id) FROM 9)::integer;

  SELECT provenance.*
  INTO v_provenance
  FROM mvp.historical_energy_provenance_v1 AS provenance
  WHERE provenance.vehicle_profile_id = v_profile_id;

  IF NOT FOUND THEN
    RETURN v_result;
  END IF;

  v_details := coalesce(
    v_result #> '{calculation_details,fuel_or_energy}',
    '{}'::jsonb
  ) || jsonb_strip_nulls(jsonb_build_object(
    'method', v_provenance.energy_method,
    'energy_confidence', v_provenance.energy_confidence,
    'source_name', v_provenance.source_name,
    'source_urls', jsonb_build_array(v_provenance.source_url),
    'source_records', v_provenance.source_records_count,
    'registrations_count', v_provenance.registrations_count,
    'historical_version_id', v_provenance.historical_version_id
  ));

  v_result := jsonb_set(
    v_result,
    '{calculation_details,fuel_or_energy}',
    v_details,
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,energy_source_method}',
    to_jsonb(v_provenance.energy_method),
    true
  );
  v_result := jsonb_set(
    v_result,
    '{quality,energy_source_confidence}',
    to_jsonb(v_provenance.energy_confidence),
    true
  );

  IF v_provenance.energy_method <> 'dato_eea_diretto' THEN
    v_assumptions := coalesce(v_result -> 'assumptions', '[]'::jsonb)
      || jsonb_build_array(
        CASE
          WHEN v_provenance.energy_method LIKE '%stesso_modello%'
            THEN 'Il consumo mancante nella singola osservazione e stato ricostruito usando registrazioni EEA dello stesso modello.'
          ELSE 'Il consumo mancante nella singola osservazione e stato stimato usando registrazioni EEA tecnicamente comparabili.'
        END
      );
    v_result := jsonb_set(
      v_result,
      '{assumptions}',
      v_assumptions,
      true
    );
  END IF;

  RETURN v_result;
END;
$function$;

COMMENT ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) IS
'Calcola il TCO e distingue l affidabilita del consumo storico EEA dall affidabilita economica della svalutazione.';

REVOKE ALL ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) FROM PUBLIC, authenticated;
GRANT EXECUTE ON FUNCTION public.auto_tco_estimate_variant(
  text, text, integer, integer, text
) TO anon;

NOTIFY pgrst, 'reload schema';

-- Verifica integrata: corrispondenza numerica con la tabella compatta,
-- provenienza esposta e nessuna regressione del calcolo.
CREATE OR REPLACE FUNCTION pg_temp.safe_tco_energy_provenance_v1(
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

CREATE TEMP TABLE published_historical_energy_v1
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
SELECT DISTINCT ON (
  provenance.vehicle_profile_id,
  item ->> 'display_variant_id'
)
  provenance.*,
  item ->> 'display_variant_id' AS display_variant_id,
  item ->> 'version_label' AS version_label
FROM version_item
JOIN mvp.historical_energy_provenance_v1 AS provenance
  ON provenance.vehicle_cluster_id = item ->> 'vehicle_cluster_id'
ORDER BY
  provenance.vehicle_profile_id,
  item ->> 'display_variant_id';

CREATE INDEX ON published_historical_energy_v1 (energy_confidence);
ANALYZE published_historical_energy_v1;

CREATE TEMP TABLE historical_energy_samples_v1
ON COMMIT DROP
AS
WITH ranked AS (
  SELECT
    published.*,
    row_number() OVER (
      PARTITION BY energy_confidence
      ORDER BY registrations_count DESC, vehicle_profile_id
    ) AS confidence_rank
  FROM published_historical_energy_v1 AS published
)
SELECT
  ranked.*,
  pg_temp.safe_tco_energy_provenance_v1(
    ranked.vehicle_cluster_id,
    ranked.display_variant_id
  ) AS result
FROM ranked
WHERE confidence_rank <= 5;

DO $verification$
DECLARE
  v_mapped integer;
  v_published integer;
  v_numeric_mismatch integer;
  v_failed_samples integer;
  v_wrong_method integer;
  v_private_read boolean;
BEGIN
  SELECT count(*) INTO v_mapped
  FROM mvp.historical_energy_provenance_v1;

  SELECT count(*) INTO v_published
  FROM published_historical_energy_v1;

  SELECT count(*) INTO v_numeric_mismatch
  FROM mvp.historical_energy_provenance_v1 AS provenance
  JOIN mvp.vehicle_profiles AS profile
    ON profile.id = provenance.vehicle_profile_id
  WHERE (
      provenance.thermal_consumption_per_100km IS NOT NULL
      AND profile.consumption_l_100km IS DISTINCT FROM
        provenance.thermal_consumption_per_100km
    )
    OR (
      provenance.electric_consumption_kwh_100km IS NOT NULL
      AND profile.electric_consumption_kwh_100km IS DISTINCT FROM
        provenance.electric_consumption_kwh_100km
    );

  SELECT count(*) FILTER (
      WHERE NULLIF(result ->> '_audit_error', '') IS NOT NULL
        OR result #>> '{quality,status}' IS DISTINCT FROM 'ready'
    ),
    count(*) FILTER (
      WHERE result #>> '{calculation_details,fuel_or_energy,method}'
        IS DISTINCT FROM energy_method
        AND coalesce(
          result #>> '{calculation_details,fuel_or_energy,method}',
          ''
        ) <> 'variant_wltp_weighted_combined_v1'
    )
  INTO v_failed_samples, v_wrong_method
  FROM historical_energy_samples_v1;

  v_private_read := has_table_privilege(
    'anon',
    'mvp.historical_energy_provenance_v1',
    'SELECT'
  );

  IF v_mapped < 10000
    OR v_published < 1500
    OR v_numeric_mismatch <> 0
    OR v_failed_samples <> 0
    OR v_wrong_method <> 0
    OR v_private_read
  THEN
    RAISE EXCEPTION
      'Verifica fallita: mappati %, pubblicati %, consumi diversi %, campioni falliti %, metodi errati %, tabella leggibile %',
      v_mapped,
      v_published,
      v_numeric_mismatch,
      v_failed_samples,
      v_wrong_method,
      v_private_read;
  END IF;
END;
$verification$;

SELECT
  count(*) AS profili_storici_mappati,
  count(*) FILTER (WHERE energy_confidence = 'high')
    AS consumi_diretti_alta_affidabilita,
  count(*) FILTER (WHERE energy_confidence = 'medium')
    AS consumi_stesso_modello,
  count(*) FILTER (WHERE energy_confidence = 'low')
    AS consumi_comparabili_deboli,
  sum(registrations_count) AS immatricolazioni_rappresentate,
  (SELECT count(*) FROM published_historical_energy_v1)
    AS versioni_pubbliche_interessate,
  (SELECT count(*) FROM historical_energy_samples_v1)
    AS campioni_calcolati,
  NOT has_table_privilege(
    'anon',
    'mvp.historical_energy_provenance_v1',
    'SELECT'
  ) AS dati_privati_protetti,
  'ok' AS verifica
FROM mvp.historical_energy_provenance_v1;

COMMIT;
