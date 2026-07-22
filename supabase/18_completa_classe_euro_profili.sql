-- Auto TCO - completa la classe Euro solo dove manca.
--
-- I profili originali non vengono sovrascritti. Per i profili sintetici che
-- hanno anno, alimentazione e potenza ma non la classe Euro, la classe viene
-- derivata dall'anno rappresentativo e marcata esplicitamente come stima.

BEGIN;

ALTER TABLE mvp.vehicle_profiles
  ADD COLUMN IF NOT EXISTS euro_class_source text;

ALTER TABLE mvp.vehicle_profiles
  ADD COLUMN IF NOT EXISTS euro_class_confidence text;

COMMENT ON COLUMN mvp.vehicle_profiles.euro_class_source IS
  'Provenienza della classe Euro: originale del database oppure derivata dall anno rappresentativo.';

COMMENT ON COLUMN mvp.vehicle_profiles.euro_class_confidence IS
  'Affidabilita della classe Euro esposta al motore del bollo.';

-- Registra la provenienza dei dati originali senza modificarli.
UPDATE mvp.vehicle_profiles
SET
  euro_class_source = COALESCE(euro_class_source, 'original_database'),
  euro_class_confidence = COALESCE(euro_class_confidence, 'original')
WHERE euro_class BETWEEN 0 AND 6;

-- Soglie basate sull'anno di prima immatricolazione obbligatoria delle
-- principali classi Euro. Con il solo anno disponibile la stima e prudente e
-- viene dichiarata come tale; nessun valore originale viene sovrascritto.
UPDATE mvp.vehicle_profiles
SET
  euro_class = CASE
    WHEN representative_year >= 2015 THEN 6
    WHEN representative_year >= 2011 THEN 5
    WHEN representative_year >= 2006 THEN 4
    WHEN representative_year >= 2001 THEN 3
    WHEN representative_year >= 1997 THEN 2
    WHEN representative_year >= 1993 THEN 1
    ELSE 0
  END,
  euro_class_source = 'derived_from_representative_year',
  euro_class_confidence = 'medium',
  source_notes = concat_ws(
    ' ',
    NULLIF(btrim(source_notes), ''),
    'Classe Euro assente nel profilo originale e derivata dall anno rappresentativo esclusivamente per il calcolo del bollo.'
  )
WHERE euro_class IS NULL
  AND representative_year BETWEEN 1900 AND 2100
  AND power_kw IS NOT NULL
  AND fuel_type IS NOT NULL;

-- Conserva la funzione pubblica completa precedente (inclusa manutenzione) e
-- aggiunge solo la correzione della provenienza nel payload restituito al sito.
DO $rename_previous$
BEGIN
  IF to_regprocedure(
    'public.auto_tco_estimate_before_euro_fallback_v1(text,integer,integer,text)'
  ) IS NULL THEN
    EXECUTE
      'ALTER FUNCTION public.auto_tco_estimate(text, integer, integer, text) '
      'RENAME TO auto_tco_estimate_before_euro_fallback_v1';
  END IF;
END;
$rename_previous$;

REVOKE ALL ON FUNCTION public.auto_tco_estimate_before_euro_fallback_v1(
  text, integer, integer, text
) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.auto_tco_estimate_before_euro_fallback_v1(
  text, integer, integer, text
) FROM anon;

CREATE OR REPLACE FUNCTION public.auto_tco_estimate(
  p_vehicle_cluster_id text,
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
  v_euro_source text;
  v_euro_confidence text;
BEGIN
  v_result := public.auto_tco_estimate_before_euro_fallback_v1(
    p_vehicle_cluster_id,
    p_annual_km,
    p_ownership_years,
    p_region_code
  );

  IF trim(p_vehicle_cluster_id) ~ '^profile:[0-9]{1,10}$' THEN
    v_profile_id := substring(trim(p_vehicle_cluster_id) FROM 9)::integer;

    SELECT
      profile.euro_class_source,
      profile.euro_class_confidence
    INTO
      v_euro_source,
      v_euro_confidence
    FROM mvp.vehicle_profiles AS profile
    WHERE profile.id = v_profile_id;

    IF v_euro_source = 'derived_from_representative_year' THEN
      v_result := jsonb_set(
        v_result,
        '{calculation_details,tax,euro_class_source}',
        to_jsonb(
          'Derivata dall anno rappresentativo perche assente nel profilo originale'::text
        ),
        true
      );

      v_result := jsonb_set(
        v_result,
        '{quality,confidence,tax}',
        to_jsonb(COALESCE(v_euro_confidence, 'medium')),
        true
      );
    END IF;
  END IF;

  -- Allinea anche il testo restituito dall API alla descrizione mostrata dal sito.
  v_result := jsonb_set(
    v_result,
    '{descriptions,maintenance}',
    to_jsonb(
      'Stima di tagliandi, materiali di consumo e usura prevedibile basata su chilometri, eta, alimentazione e potenza. Sono esclusi pneumatici e interventi straordinari.'::text
    ),
    true
  );

  RETURN v_result;
END;
$function$;

REVOKE ALL ON FUNCTION public.auto_tco_estimate(
  text, integer, integer, text
) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.auto_tco_estimate(
  text, integer, integer, text
) FROM anon;
GRANT EXECUTE ON FUNCTION public.auto_tco_estimate(
  text, integer, integer, text
) TO anon;

COMMIT;

NOTIFY pgrst, 'reload schema';

-- Verifica integrata: usa esattamente le due famiglie che fallivano nel sito.
CREATE TEMP TABLE auto_tco_migration_18_check AS
WITH samples AS (
  SELECT
    max(vehicle_cluster_id) FILTER (
      WHERE brand = 'Audi'
        AND model = 'A4'
        AND representative_year = 2025
        AND fuel_type = 'diesel'
        AND round(power_cv) = 286
        AND source_kind = 'original_historical_profile'
    ) AS audi_a4_id,
    max(vehicle_cluster_id) FILTER (
      WHERE brand = 'Ford'
        AND model = 'Mustang'
        AND representative_year = 2025
        AND fuel_type = 'electric'
        AND round(power_cv) = 374
        AND source_kind = 'original_historical_profile'
    ) AS mustang_id
  FROM mvp.site_vehicle_catalog_unified_v1
), results AS (
  SELECT
    samples.*,
    public.auto_tco_estimate(
      samples.audi_a4_id, 15000, 5, 'italia'
    ) AS audi_a4,
    public.auto_tco_estimate(
      samples.mustang_id, 15000, 5, 'italia'
    ) AS mustang
  FROM samples
), coverage AS (
  SELECT
    count(*) FILTER (
      WHERE profile_status = 'active'
        AND euro_class_source = 'derived_from_representative_year'
    )::integer AS classi_euro_derivate,
    count(*) FILTER (
      WHERE profile_status = 'active'
        AND power_kw IS NOT NULL
        AND representative_year IS NOT NULL
        AND fuel_type IS NOT NULL
        AND euro_class IS NULL
    )::integer AS profili_ancora_bloccati
  FROM mvp.vehicle_profiles
)
SELECT
  coverage.classi_euro_derivate,
  coverage.profili_ancora_bloccati,
  results.audi_a4 #>> '{vehicle,version_label}' AS audi_verificata,
  results.audi_a4 #>> '{monthly_costs,total_monthly_eur}' AS audi_totale,
  results.audi_a4 #>> '{calculation_details,tax,euro_class_source}'
    AS audi_fonte_classe_euro,
  results.mustang #>> '{vehicle,version_label}' AS mustang_verificata,
  results.mustang #>> '{monthly_costs,total_monthly_eur}' AS mustang_totale,
  results.mustang #>> '{calculation_details,tax,euro_class_source}'
    AS mustang_fonte_classe_euro,
  CASE
    WHEN coverage.classi_euro_derivate > 0
      AND coverage.profili_ancora_bloccati = 0
      AND results.audi_a4_id IS NOT NULL
      AND results.mustang_id IS NOT NULL
      AND results.audi_a4 #>> '{monthly_costs,total_monthly_eur}' IS NOT NULL
      AND results.mustang #>> '{monthly_costs,total_monthly_eur}' IS NOT NULL
    THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM coverage
CROSS JOIN results;

DO $verify$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM auto_tco_migration_18_check
    WHERE verifica = 'ok'
  ) THEN
    RAISE EXCEPTION 'Verifica completamento classe Euro fallita';
  END IF;
END;
$verify$;

TABLE auto_tco_migration_18_check;

DROP TABLE auto_tco_migration_18_check;
