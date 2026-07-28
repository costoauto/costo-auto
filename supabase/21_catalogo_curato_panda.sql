-- Auto TCO - primo catalogo commerciale curato e pilota Fiat Panda.
--
-- Obiettivo:
--   * non usare l'anno di immatricolazione EEA come se fosse automaticamente
--     l'anno commerciale di una versione;
--   * separare Panda/Pandina dalla Grande Panda;
--   * mantenere un vero vehicle_cluster_id per tutti i calcoli;
--   * creare un meccanismo riutilizzabile per gli altri modelli.
--
-- Gerarchia delle fonti usata per il pilota:
--   1. guide annuali MIMIT del mercato italiano;
--   2. dati strutturati ADEME per potenza/cambio delle versioni recenti;
--   3. cronologia della generazione Fiat Panda (2012) per colmare gli
--      intervalli non coperti dalle guide MIMIT disponibili online.
--
-- Nessun profilo tecnico o calcolo TCO esistente viene modificato.

\set ON_ERROR_STOP on

BEGIN;

SET LOCAL statement_timeout = '15min';

CREATE TABLE IF NOT EXISTS mvp.site_vehicle_model_curations_v1 (
  public_model_id text PRIMARY KEY,
  source_model_catalog_id text NOT NULL,
  brand_key text NOT NULL,
  brand text NOT NULL,
  model_key text NOT NULL,
  model text NOT NULL,
  replace_source_year_from integer NOT NULL,
  replace_source_year_to integer NOT NULL,
  include_uncurated_source_versions boolean NOT NULL DEFAULT false,
  source_name text NOT NULL,
  source_url text NOT NULL,
  confidence text NOT NULL,
  updated_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT site_vehicle_model_curations_years_check
    CHECK (
      replace_source_year_from BETWEEN 1900 AND 2100
      AND replace_source_year_to BETWEEN replace_source_year_from AND 2100
    ),
  CONSTRAINT site_vehicle_model_curations_confidence_check
    CHECK (confidence IN ('high', 'medium_high', 'medium', 'medium_low', 'low'))
);

CREATE TABLE IF NOT EXISTS mvp.site_vehicle_version_curations_v1 (
  curated_version_id text PRIMARY KEY,
  public_model_id text NOT NULL
    REFERENCES mvp.site_vehicle_model_curations_v1(public_model_id)
    ON DELETE CASCADE,
  calculation_vehicle_cluster_id text NOT NULL,
  year_from integer NOT NULL,
  year_to integer NOT NULL,
  fuel_type text NOT NULL,
  hybrid_type text NOT NULL DEFAULT 'none',
  powertrain_type text NOT NULL,
  power_kw numeric,
  power_cv integer,
  transmission_label text,
  gear_count integer,
  commercial_name text,
  source_name text NOT NULL,
  source_url text NOT NULL,
  source_note text,
  confidence text NOT NULL,
  display_order integer NOT NULL DEFAULT 0,
  is_active boolean NOT NULL DEFAULT true,
  updated_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT site_vehicle_version_curations_years_check
    CHECK (
      year_from BETWEEN 1900 AND 2100
      AND year_to BETWEEN year_from AND 2100
    ),
  CONSTRAINT site_vehicle_version_curations_power_check
    CHECK (power_cv IS NULL OR power_cv > 0),
  CONSTRAINT site_vehicle_version_curations_gears_check
    CHECK (gear_count IS NULL OR gear_count >= 0),
  CONSTRAINT site_vehicle_version_curations_confidence_check
    CHECK (confidence IN ('high', 'medium_high', 'medium', 'medium_low', 'low'))
);

COMMENT ON TABLE mvp.site_vehicle_model_curations_v1 IS
'Regole tracciabili che separano o rinominano famiglie commerciali senza modificare il catalogo tecnico sorgente.';

COMMENT ON TABLE mvp.site_vehicle_version_curations_v1 IS
'Versioni commerciali curate: intervalli, alimentazione, potenza e cambio verificati, collegati a un cluster reale usato dal motore TCO.';

REVOKE ALL ON TABLE mvp.site_vehicle_model_curations_v1
  FROM PUBLIC, anon, authenticated;
REVOKE ALL ON TABLE mvp.site_vehicle_version_curations_v1
  FROM PUBLIC, anon, authenticated;

-- La migrazione e' ripetibile: sostituisce soltanto il pilota Fiat Panda.
DELETE FROM mvp.site_vehicle_model_curations_v1
WHERE public_model_id IN (
  'curated:fiat:panda-2012',
  'curated:fiat:grande-panda'
);

WITH panda_source AS (
  SELECT model_catalog_id
  FROM mvp.site_vehicle_catalog_publishable_v1
  WHERE brand_key = 'FIAT'
    AND model_key = 'PANDA'
  GROUP BY model_catalog_id
  ORDER BY sum(registrations_count) DESC, model_catalog_id
  LIMIT 1
)
INSERT INTO mvp.site_vehicle_model_curations_v1 (
  public_model_id,
  source_model_catalog_id,
  brand_key,
  brand,
  model_key,
  model,
  replace_source_year_from,
  replace_source_year_to,
  include_uncurated_source_versions,
  source_name,
  source_url,
  confidence
)
SELECT
  item.public_model_id,
  panda_source.model_catalog_id,
  'FIAT',
  'Fiat',
  item.model_key,
  item.model,
  2012,
  2100,
  item.include_uncurated_source_versions,
  item.source_name,
  item.source_url,
  item.confidence
FROM panda_source
CROSS JOIN (
  VALUES
    (
      'curated:fiat:panda-2012',
      'PANDA',
      'Panda',
      true,
      'MIMIT + ADEME + cronologia generazione Panda 2012',
      'https://www.mimit.gov.it/index.php/it/component/tags/tag/862',
      'medium_high'
    ),
    (
      'curated:fiat:grande-panda',
      'GRANDEPANDA',
      'Grande Panda',
      false,
      'MIMIT - Guida CO2 2025',
      'https://www.mimit.gov.it/images/stories/normativa/allegati/Guida_CO2_ed_2025.pdf',
      'high'
    )
) AS item(
  public_model_id,
  model_key,
  model,
  include_uncurated_source_versions,
  source_name,
  source_url,
  confidence
);

-- Ogni riga commerciale viene collegata al miglior cluster tecnico reale.
-- La potenza esposta usa i CV commerciali; il cluster conserva i dati
-- tecnici gia usati per consumo, bollo, assicurazione e svalutazione.
WITH panda_source AS (
  SELECT source_model_catalog_id AS model_catalog_id
  FROM mvp.site_vehicle_model_curations_v1
  WHERE public_model_id = 'curated:fiat:panda-2012'
), specs AS (
  SELECT *
  FROM (
    VALUES
      (
        'panda-2012-petrol-85-2012-2021',
        'curated:fiat:panda-2012',
        2012, 2021,
        'petrol', 'none', 'combustion',
        63::numeric, 85,
        'Manuale o Dualogic', NULL::integer,
        '0.9 TwinAir Turbo',
        2016, 2,
        'MIMIT 2013 + cronologia Fiat Panda 2012',
        'https://it.wikipedia.org/wiki/Fiat_Panda_(2012)#Motorizzazioni',
        'Intervallo interrotto dopo il 2021; la serie speciale 2023 e pubblicata separatamente.',
        'medium_high', 10
      ),
      (
        'panda-2012-petrol-90-cross-2014-2020',
        'curated:fiat:panda-2012',
        2014, 2020,
        'petrol', 'none', 'combustion',
        66::numeric, 90,
        'Manuale', 6,
        '0.9 TwinAir Turbo Cross',
        2017, 1,
        'Cronologia Fiat Panda 2012',
        'https://it.wikipedia.org/wiki/Fiat_Panda_(2012)#Motorizzazioni',
        'Versione Cross distinta dalla TwinAir da 85 CV.',
        'medium', 20
      ),
      (
        'panda-2012-petrol-69-2012-2021',
        'curated:fiat:panda-2012',
        2012, 2021,
        'petrol', 'none', 'combustion',
        51::numeric, 69,
        'Manuale', 5,
        '1.2 FIRE',
        2016, 1,
        'Cronologia Fiat Panda 2012',
        'https://it.wikipedia.org/wiki/Fiat_Panda_(2012)#Motorizzazioni',
        'La versione Trussardi con questo motore e rimasta a listino fino al 2021.',
        'medium', 30
      ),
      (
        'panda-2012-diesel-75-2012-2015',
        'curated:fiat:panda-2012',
        2012, 2015,
        'diesel', 'none', 'combustion',
        55::numeric, 75,
        'Manuale', 5,
        '1.3 Multijet II',
        2014, 1,
        'Cronologia Fiat Panda 2012',
        'https://it.wikipedia.org/wiki/Fiat_Panda_(2012)#Motorizzazioni',
        'Sostituita dalla versione da 95 CV con il passaggio Euro 6.',
        'medium_high', 40
      ),
      (
        'panda-2012-diesel-80-cross-2014-2015',
        'curated:fiat:panda-2012',
        2014, 2015,
        'diesel', 'none', 'combustion',
        59::numeric, 80,
        'Manuale', 5,
        '1.3 Multijet II Cross',
        2015, 1,
        'Cronologia Fiat Panda 2012',
        'https://it.wikipedia.org/wiki/Fiat_Panda_(2012)#Motorizzazioni',
        'Versione Cross precedente all omologazione Euro 6.',
        'medium_high', 50
      ),
      (
        'panda-2012-diesel-95-2015-2018',
        'curated:fiat:panda-2012',
        2015, 2018,
        'diesel', 'none', 'combustion',
        70::numeric, 95,
        'Manuale', 5,
        '1.3 Multijet II',
        2016, 1,
        'Cronologia Fiat Panda 2012',
        'https://it.wikipedia.org/wiki/Fiat_Panda_(2012)#Motorizzazioni',
        'Include la variante Cross con la stessa potenza.',
        'medium_high', 60
      ),
      (
        'panda-2012-lpg-69-2012-2023',
        'curated:fiat:panda-2012',
        2012, 2023,
        'lpg', 'none', 'combustion',
        51::numeric, 69,
        'Manuale', 5,
        '1.2 EasyPower',
        2019, 1,
        'MIMIT - guide CO2 2014, 2022 e 2023',
        'https://www.mimit.gov.it/images/stories/documenti/Guida_CO2_-_2023.pdf',
        'La presenza nel mercato italiano e confermata anche dalla guida MIMIT 2023.',
        'high', 70
      ),
      (
        'panda-2012-ng-80-2012-2020',
        'curated:fiat:panda-2012',
        2012, 2020,
        'ng', 'none', 'combustion',
        59::numeric, 80,
        'Manuale', 6,
        '0.9 TwinAir Natural Power',
        2018, 5,
        'Cronologia Fiat Panda 2012',
        'https://it.wikipedia.org/wiki/Fiat_Panda_(2012)#Motorizzazioni',
        'La potenza commerciale varia secondo il carburante; si espone la denominazione da 80 CV.',
        'medium', 80
      ),
      (
        'panda-2012-hybrid-70-2020-2025',
        'curated:fiat:panda-2012',
        2020, 2025,
        'petrol', 'hybrid', 'hybrid',
        51.5::numeric, 70,
        'Manuale', 6,
        '1.0 FireFly mild hybrid',
        2023, 2,
        'MIMIT 2021-2025 + ADEME Car Labelling',
        'https://www.mimit.gov.it/images/stories/documenti/Guida_CO2_Edizione_2024.pdf',
        'Panda e Pandina condividono il 1.0 mild hybrid; ADEME conferma cambio manuale a 6 rapporti.',
        'high', 90
      ),
      (
        'panda-2012-petrol-85-4x40-2023',
        'curated:fiat:panda-2012',
        2023, 2023,
        'petrol', 'none', 'combustion',
        63::numeric, 85,
        'Manuale', 6,
        '0.9 TwinAir 4x40',
        2023, 2,
        'Fiat Panda 4x40 - serie speciale 2023',
        'https://it.wikipedia.org/wiki/Fiat_Panda_(2012)#Panda_4x40º',
        'Serie speciale del 2023, separata per non inventare continuita nel 2022.',
        'medium', 100
      ),
      (
        'grande-panda-electric-113-2025',
        'curated:fiat:grande-panda',
        2025, 2025,
        'electric', 'electric', 'electric',
        83::numeric, 113,
        'Automatico monomarcia', 1,
        'Grande Panda elettrica',
        2024, 1,
        'MIMIT - Guida CO2 2025',
        'https://www.mimit.gov.it/images/stories/normativa/allegati/Guida_CO2_ed_2025.pdf',
        'La guida MIMIT separa esplicitamente Grande Panda elettrica da Panda/Pandina.',
        'high', 10
      )
  ) AS s(
    curated_version_id,
    public_model_id,
    year_from,
    year_to,
    fuel_type,
    hybrid_type,
    powertrain_type,
    power_kw,
    power_cv,
    transmission_label,
    gear_count,
    commercial_name,
    preferred_year,
    max_power_delta_cv,
    source_name,
    source_url,
    source_note,
    confidence,
    display_order
  )
), resolved AS (
  SELECT
    specs.*,
    candidate.vehicle_cluster_id AS calculation_vehicle_cluster_id
  FROM specs
  CROSS JOIN panda_source
  LEFT JOIN LATERAL (
    SELECT catalog.*
    FROM mvp.site_vehicle_catalog_publishable_v1 AS catalog
    WHERE catalog.model_catalog_id = panda_source.model_catalog_id
      AND catalog.fuel_type = specs.fuel_type
      AND COALESCE(catalog.hybrid_type, 'none') = specs.hybrid_type
      AND catalog.power_cv IS NOT NULL
      AND abs(round(catalog.power_cv)::integer - specs.power_cv)
        <= specs.max_power_delta_cv
    ORDER BY
      CASE WHEN catalog.energy_data_status = 'ready' THEN 0 ELSE 1 END,
      CASE
        WHEN catalog.depreciation_data_status <> 'missing' THEN 0
        ELSE 1
      END,
      abs(COALESCE(catalog.representative_year, specs.preferred_year)
        - specs.preferred_year),
      abs(round(catalog.power_cv)::integer - specs.power_cv),
      catalog.registrations_count DESC,
      catalog.vehicle_cluster_id
    LIMIT 1
  ) AS candidate ON true
)
INSERT INTO mvp.site_vehicle_version_curations_v1 (
  curated_version_id,
  public_model_id,
  calculation_vehicle_cluster_id,
  year_from,
  year_to,
  fuel_type,
  hybrid_type,
  powertrain_type,
  power_kw,
  power_cv,
  transmission_label,
  gear_count,
  commercial_name,
  source_name,
  source_url,
  source_note,
  confidence,
  display_order,
  is_active,
  updated_at
)
SELECT
  curated_version_id,
  public_model_id,
  calculation_vehicle_cluster_id,
  year_from,
  year_to,
  fuel_type,
  hybrid_type,
  powertrain_type,
  power_kw,
  power_cv,
  transmission_label,
  gear_count,
  commercial_name,
  source_name,
  source_url,
  source_note,
  confidence,
  display_order,
  true,
  now()
FROM resolved
WHERE calculation_vehicle_cluster_id IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_site_vehicle_version_curations_model
  ON mvp.site_vehicle_version_curations_v1 (
    public_model_id,
    year_to DESC,
    year_from DESC
  );

CREATE OR REPLACE FUNCTION public.auto_tco_models(p_brand_key text)
RETURNS jsonb
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public
AS $function$
  WITH base AS (
    SELECT
      model_catalog_id,
      brand_key,
      min(seed_model_id) AS seed_model_id,
      min(brand) AS brand,
      model_key,
      min(model) AS model
    FROM mvp.site_vehicle_catalog_unified_v1
    WHERE brand_key = left(trim(p_brand_key), 60)
    GROUP BY model_catalog_id, brand_key, model_key
  ), curated AS (
    SELECT
      curation.public_model_id AS model_catalog_id,
      curation.brand_key,
      min(catalog.seed_model_id) AS seed_model_id,
      min(curation.brand) AS brand,
      curation.model_key,
      min(curation.model) AS model
    FROM mvp.site_vehicle_model_curations_v1 AS curation
    LEFT JOIN mvp.site_vehicle_catalog_unified_v1 AS catalog
      ON catalog.model_catalog_id = curation.source_model_catalog_id
    WHERE curation.brand_key = left(trim(p_brand_key), 60)
      AND EXISTS (
        SELECT 1
        FROM mvp.site_vehicle_version_curations_v1 AS version
        WHERE version.public_model_id = curation.public_model_id
          AND version.is_active
      )
    GROUP BY curation.public_model_id, curation.brand_key, curation.model_key
  ), combined AS (
    SELECT * FROM base
    WHERE NOT EXISTS (
      SELECT 1
      FROM mvp.site_vehicle_model_curations_v1 AS curation
      WHERE curation.source_model_catalog_id = base.model_catalog_id
    )
    UNION ALL
    SELECT * FROM curated
  ), item AS (
    SELECT DISTINCT ON (model_catalog_id)
      model_catalog_id,
      brand_key,
      seed_model_id,
      brand,
      model_key,
      model
    FROM combined
    ORDER BY model_catalog_id, model
  )
  SELECT jsonb_build_object(
    'items',
    COALESCE(jsonb_agg(to_jsonb(item) ORDER BY item.model), '[]'::jsonb)
  )
  FROM item;
$function$;

CREATE OR REPLACE FUNCTION public.auto_tco_versions(p_model_id text)
RETURNS jsonb
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public
AS $function$
  WITH requested AS (
    SELECT
      left(trim(p_model_id), 64) AS model_id,
      COALESCE(
        curation.source_model_catalog_id,
        left(trim(p_model_id), 64)
      ) AS source_model_id,
      COALESCE(
        curation.include_uncurated_source_versions,
        true
      ) AS include_uncurated_source_versions
    FROM (SELECT 1) AS singleton
    LEFT JOIN mvp.site_vehicle_model_curations_v1 AS curation
      ON curation.public_model_id = left(trim(p_model_id), 64)
  ), raw_ranked AS (
    SELECT
      catalog.*,
      COALESCE(catalog.fuel_type, 'unknown') AS fuel_key,
      COALESCE(catalog.hybrid_type, 'none') AS hybrid_key,
      COALESCE(round(catalog.power_kw)::integer, -1) AS power_key,
      row_number() OVER (
        PARTITION BY
          catalog.model_catalog_id,
          catalog.display_year,
          COALESCE(catalog.fuel_type, 'unknown'),
          COALESCE(catalog.hybrid_type, 'none'),
          COALESCE(round(catalog.power_kw)::integer, -1)
        ORDER BY
          CASE
            WHEN catalog.source_kind = 'eea_current' THEN 0
            WHEN profile.profile_kind = 'eea_historical_compact_v1' THEN 2
            ELSE 1
          END,
          CASE WHEN catalog.energy_data_status = 'ready' THEN 0 ELSE 1 END,
          CASE
            WHEN catalog.depreciation_data_status <> 'missing' THEN 0
            ELSE 1
          END,
          catalog.registrations_count DESC,
          catalog.vehicle_cluster_id
      ) AS duplicate_rank
    FROM mvp.site_vehicle_catalog_publishable_v1 AS catalog
    CROSS JOIN requested
    LEFT JOIN mvp.vehicle_profiles AS profile
      ON profile.id = catalog.vehicle_profile_id
    WHERE requested.include_uncurated_source_versions
      AND catalog.model_catalog_id = requested.source_model_id
      AND catalog.display_year BETWEEN 1900 AND 2100
      AND NOT EXISTS (
        SELECT 1
        FROM mvp.site_vehicle_model_curations_v1 AS curation
        WHERE curation.source_model_catalog_id = catalog.model_catalog_id
          AND catalog.display_year BETWEEN
            curation.replace_source_year_from
            AND curation.replace_source_year_to
      )
  ), raw_yearly AS (
    SELECT *
    FROM raw_ranked
    WHERE duplicate_rank = 1
  ), raw_sequenced AS (
    SELECT
      raw_yearly.*,
      display_year
        - row_number() OVER (
            PARTITION BY
              model_catalog_id,
              fuel_key,
              hybrid_key,
              power_key
            ORDER BY display_year
          )::integer AS year_island
    FROM raw_yearly
  ), raw_ranged AS (
    SELECT
      raw_sequenced.*,
      min(display_year) OVER (
        PARTITION BY
          model_catalog_id, fuel_key, hybrid_key, power_key, year_island
      ) AS year_from,
      max(display_year) OVER (
        PARTITION BY
          model_catalog_id, fuel_key, hybrid_key, power_key, year_island
      ) AS year_to,
      count(*) OVER (
        PARTITION BY
          model_catalog_id, fuel_key, hybrid_key, power_key, year_island
      )::integer AS years_in_range,
      sum(registrations_count) OVER (
        PARTITION BY
          model_catalog_id, fuel_key, hybrid_key, power_key, year_island
      ) AS registrations_in_range
    FROM raw_sequenced
  ), raw_representatives AS (
    SELECT
      raw_ranged.*,
      row_number() OVER (
        PARTITION BY
          model_catalog_id, fuel_key, hybrid_key, power_key, year_island
        ORDER BY
          CASE WHEN energy_data_status = 'ready' THEN 0 ELSE 1 END,
          CASE
            WHEN depreciation_data_status <> 'missing' THEN 0
            ELSE 1
          END,
          abs(display_year - ((year_from + year_to) / 2.0)),
          registrations_count DESC,
          vehicle_cluster_id
      ) AS representative_rank
    FROM raw_ranged
  ), raw_item AS (
    SELECT
      vehicle_cluster_id,
      model_catalog_id,
      vehicle_profile_id,
      seed_model_id,
      brand,
      model,
      (
        CASE
          WHEN year_from = year_to THEN year_from::text
          ELSE year_from::text || '-' || year_to::text
        END
        || ' ' || chr(183) || ' '
        || CASE
          WHEN hybrid_type = 'plug_in_hybrid' THEN
            'Ibrida plug-in '
            || CASE fuel_type WHEN 'diesel' THEN 'diesel' ELSE 'benzina' END
          WHEN hybrid_type = 'hybrid' THEN
            'Ibrida '
            || CASE fuel_type WHEN 'diesel' THEN 'diesel' ELSE 'benzina' END
          WHEN powertrain_type = 'electric' OR fuel_type = 'electric'
            THEN 'Elettrica'
          WHEN fuel_type = 'petrol' THEN 'Benzina'
          WHEN fuel_type = 'diesel' THEN 'Diesel'
          WHEN fuel_type = 'lpg' THEN 'GPL'
          WHEN fuel_type = 'ng' THEN 'Metano'
          ELSE initcap(COALESCE(fuel_type, 'Alimentazione non specificata'))
        END
        || CASE
          WHEN power_cv IS NULL THEN ''
          ELSE ' ' || chr(183) || ' '
            || round(power_cv)::integer::text || ' CV'
        END
      )::text AS version_label,
      representative_year,
      display_year,
      year_from,
      year_to,
      years_in_range,
      year_source,
      year_confidence,
      fuel_type,
      hybrid_type,
      powertrain_type,
      power_kw,
      power_cv,
      NULL::text AS transmission_label,
      NULL::integer AS gear_count,
      NULL::text AS commercial_name,
      NULL::text AS data_source,
      NULL::text AS data_source_url,
      energy_data_status,
      depreciation_data_status,
      observation_quality,
      registrations_count,
      registrations_in_range,
      1::integer AS item_kind
    FROM raw_representatives
    WHERE representative_rank = 1
  ), curated_item AS (
    SELECT
      version.calculation_vehicle_cluster_id AS vehicle_cluster_id,
      version.public_model_id AS model_catalog_id,
      catalog.vehicle_profile_id,
      catalog.seed_model_id,
      curation.brand,
      curation.model,
      (
        CASE
          WHEN version.year_from = version.year_to
            THEN version.year_from::text
          ELSE version.year_from::text || '-' || version.year_to::text
        END
        || ' ' || chr(183) || ' '
        || CASE
          WHEN version.hybrid_type = 'plug_in_hybrid' THEN
            'Ibrida plug-in '
            || CASE version.fuel_type
              WHEN 'diesel' THEN 'diesel'
              ELSE 'benzina'
            END
          WHEN version.hybrid_type = 'hybrid' THEN
            'Ibrida '
            || CASE version.fuel_type
              WHEN 'diesel' THEN 'diesel'
              ELSE 'benzina'
            END
          WHEN version.powertrain_type = 'electric'
            OR version.fuel_type = 'electric' THEN 'Elettrica'
          WHEN version.fuel_type = 'petrol' THEN 'Benzina'
          WHEN version.fuel_type = 'diesel' THEN 'Diesel'
          WHEN version.fuel_type = 'lpg' THEN 'GPL'
          WHEN version.fuel_type = 'ng' THEN 'Metano'
          ELSE initcap(version.fuel_type)
        END
        || CASE
          WHEN version.power_cv IS NULL THEN ''
          ELSE ' ' || chr(183) || ' ' || version.power_cv::text || ' CV'
        END
      )::text AS version_label,
      catalog.representative_year,
      round((version.year_from + version.year_to) / 2.0)::integer
        AS display_year,
      version.year_from,
      version.year_to,
      (version.year_to - version.year_from + 1)::integer AS years_in_range,
      'curated_commercial_catalog'::text AS year_source,
      version.confidence AS year_confidence,
      version.fuel_type,
      version.hybrid_type,
      version.powertrain_type,
      version.power_kw,
      version.power_cv,
      version.transmission_label,
      version.gear_count,
      version.commercial_name,
      version.source_name AS data_source,
      version.source_url AS data_source_url,
      catalog.energy_data_status,
      catalog.depreciation_data_status,
      version.confidence AS observation_quality,
      catalog.registrations_count,
      catalog.registrations_count AS registrations_in_range,
      0::integer AS item_kind
    FROM mvp.site_vehicle_version_curations_v1 AS version
    JOIN mvp.site_vehicle_model_curations_v1 AS curation
      ON curation.public_model_id = version.public_model_id
    JOIN mvp.site_vehicle_catalog_publishable_v1 AS catalog
      ON catalog.vehicle_cluster_id = version.calculation_vehicle_cluster_id
    CROSS JOIN requested
    WHERE version.public_model_id = requested.model_id
      AND version.is_active
  ), item AS (
    SELECT * FROM curated_item
    UNION ALL
    SELECT * FROM raw_item
  )
  SELECT jsonb_build_object(
    'items',
    COALESCE(
      jsonb_agg(
        to_jsonb(item) - 'item_kind'
        ORDER BY
          item.year_to DESC,
          item.year_from DESC,
          item.item_kind,
          item.registrations_in_range DESC,
          item.fuel_type,
          item.power_cv NULLS LAST,
          item.vehicle_cluster_id
      ),
      '[]'::jsonb
    )
  )
  FROM item;
$function$;

COMMENT ON FUNCTION public.auto_tco_versions(text) IS
'Restituisce prima le versioni commerciali curate; per i modelli non ancora curati mantiene gli intervalli EEA esistenti.';

REVOKE ALL ON FUNCTION public.auto_tco_models(text) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.auto_tco_versions(text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.auto_tco_models(text) TO anon;
GRANT EXECUTE ON FUNCTION public.auto_tco_versions(text) TO anon;

NOTIFY pgrst, 'reload schema';

-- Verifica integrata.
WITH model_payload AS (
  SELECT public.auto_tco_models('FIAT') AS payload
), models AS (
  SELECT item
  FROM model_payload
  CROSS JOIN LATERAL jsonb_array_elements(payload -> 'items') AS item
), selected_models AS (
  SELECT
    item ->> 'model_catalog_id' AS model_id,
    item ->> 'model' AS model
  FROM models
  WHERE item ->> 'model' IN ('Panda', 'Grande Panda')
), versions AS (
  SELECT
    selected_models.model,
    item
  FROM selected_models
  CROSS JOIN LATERAL jsonb_array_elements(
    public.auto_tco_versions(selected_models.model_id) -> 'items'
  ) AS item
), summary AS (
  SELECT
    count(*) FILTER (WHERE model = 'Panda')::integer AS versioni_panda,
    count(*) FILTER (WHERE model = 'Grande Panda')::integer
      AS versioni_grande_panda,
    count(*) FILTER (
      WHERE model = 'Panda'
        AND (item ->> 'year_from')::integer >= 2012
        AND (
          item ->> 'fuel_type' = 'electric'
          OR item ->> 'version_label' ~ '^2025.*Diesel'
        )
    )::integer AS anomalie_panda,
    count(*) FILTER (
      WHERE model = 'Panda'
        AND item ->> 'year_source' = 'curated_commercial_catalog'
    )::integer AS panda_curate,
    count(*) FILTER (
      WHERE model = 'Panda'
        AND item ->> 'version_label' LIKE '%70 CV%'
        AND item ->> 'hybrid_type' = 'hybrid'
    )::integer AS panda_ibride_70,
    count(*) FILTER (
      WHERE model = 'Grande Panda'
        AND item ->> 'fuel_type' = 'electric'
        AND item ->> 'version_label' LIKE '%113 CV%'
    )::integer AS grande_panda_elettriche,
    count(*) FILTER (
      WHERE COALESCE(item ->> 'vehicle_cluster_id', '') = ''
    )::integer AS id_calcolo_mancanti,
    count(*) FILTER (
      WHERE COALESCE(item ->> 'data_source', '') = ''
        AND item ->> 'year_source' = 'curated_commercial_catalog'
    )::integer AS fonti_curate_mancanti
  FROM versions
)
SELECT
  versioni_panda,
  versioni_grande_panda,
  panda_curate,
  panda_ibride_70,
  grande_panda_elettriche,
  anomalie_panda,
  id_calcolo_mancanti,
  fonti_curate_mancanti,
  CASE
    WHEN versioni_panda >= 10
      AND versioni_grande_panda >= 1
      AND panda_curate >= 10
      AND panda_ibride_70 >= 1
      AND grande_panda_elettriche >= 1
      AND anomalie_panda = 0
      AND id_calcolo_mancanti = 0
      AND fonti_curate_mancanti = 0
      THEN 'ok'
    ELSE 'verificare'
  END AS verifica
FROM summary;

WITH curated_ids AS (
  SELECT calculation_vehicle_cluster_id
  FROM mvp.site_vehicle_version_curations_v1
  WHERE public_model_id IN (
    'curated:fiat:panda-2012',
    'curated:fiat:grande-panda'
  )
    AND is_active
), calculations AS (
  SELECT
    curated_ids.calculation_vehicle_cluster_id,
    public.auto_tco_estimate(
      curated_ids.calculation_vehicle_cluster_id,
      15000,
      5,
      'italia'
    ) AS result
  FROM curated_ids
), summary AS (
  SELECT
    count(*)::integer AS versioni_calcolate,
    count(*) FILTER (
      WHERE result #>> '{quality,status}' = 'ready'
    )::integer AS risultati_ready,
    count(*) FILTER (
      WHERE (result #>> '{monthly_costs,total_monthly_eur}')::numeric <= 0
    )::integer AS totali_non_validi
  FROM calculations
)
SELECT
  versioni_calcolate,
  risultati_ready,
  totali_non_validi,
  CASE
    WHEN versioni_calcolate >= 11
      AND risultati_ready = versioni_calcolate
      AND totali_non_validi = 0
      THEN 'ok'
    ELSE 'verificare'
  END AS verifica_calcoli
FROM summary;

DO $verify$
DECLARE
  v_models jsonb;
  v_panda jsonb;
  v_grande_panda jsonb;
  v_panda_count integer;
  v_panda_curated_count integer;
  v_grande_panda_count integer;
  v_anomalies integer;
  v_calculation record;
BEGIN
  v_models := public.auto_tco_models('FIAT');
  v_panda := public.auto_tco_versions('curated:fiat:panda-2012');
  v_grande_panda := public.auto_tco_versions('curated:fiat:grande-panda');

  IF NOT EXISTS (
    SELECT 1
    FROM jsonb_array_elements(v_models -> 'items') AS model
    WHERE model ->> 'model' = 'Panda'
  ) OR NOT EXISTS (
    SELECT 1
    FROM jsonb_array_elements(v_models -> 'items') AS model
    WHERE model ->> 'model' = 'Grande Panda'
  ) THEN
    RAISE EXCEPTION 'Verifica catalogo Panda fallita: modelli non pubblicati';
  END IF;

  SELECT
    count(*)::integer,
    count(*) FILTER (
      WHERE item ->> 'year_source' = 'curated_commercial_catalog'
    )::integer,
    count(*) FILTER (
      WHERE (item ->> 'year_from')::integer >= 2012
        AND (
          item ->> 'fuel_type' = 'electric'
          OR item ->> 'version_label' ~ '^2025.*Diesel'
        )
    )::integer
  INTO v_panda_count, v_panda_curated_count, v_anomalies
  FROM jsonb_array_elements(v_panda -> 'items') AS item;

  SELECT count(*)::integer
  INTO v_grande_panda_count
  FROM jsonb_array_elements(v_grande_panda -> 'items') AS item
  WHERE item ->> 'fuel_type' = 'electric'
    AND item ->> 'version_label' LIKE '%113 CV%';

  IF v_panda_count < 10
    OR v_panda_curated_count < 10
    OR v_grande_panda_count < 1
    OR v_anomalies <> 0
  THEN
    RAISE EXCEPTION
      'Verifica catalogo Panda fallita: panda %, curate %, grande %, anomalie %',
      v_panda_count,
      v_panda_curated_count,
      v_grande_panda_count,
      v_anomalies;
  END IF;

  FOR v_calculation IN
    SELECT
      version.curated_version_id,
      public.auto_tco_estimate(
        version.calculation_vehicle_cluster_id,
        15000,
        5,
        'italia'
      ) AS result
    FROM mvp.site_vehicle_version_curations_v1 AS version
    WHERE version.public_model_id IN (
      'curated:fiat:panda-2012',
      'curated:fiat:grande-panda'
    )
      AND version.is_active
  LOOP
    IF v_calculation.result #>> '{quality,status}' <> 'ready'
      OR COALESCE(
        (v_calculation.result
          #>> '{monthly_costs,total_monthly_eur}')::numeric,
        0
      ) <= 0
    THEN
      RAISE EXCEPTION
        'Verifica calcolo fallita per %',
        v_calculation.curated_version_id;
    END IF;
  END LOOP;
END;
$verify$;

COMMIT;
