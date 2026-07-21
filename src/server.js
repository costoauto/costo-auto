import 'dotenv/config';
import express from 'express';
import pg from 'pg';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const { Pool } = pg;

const databaseUrl = process.env.DATABASE_URL?.trim();
const databaseHost = process.env.DATABASE_HOST?.trim();
const databaseName = process.env.DATABASE_NAME?.trim();
const databaseUser = process.env.DATABASE_USER?.trim();
const databasePassword = process.env.DATABASE_PASSWORD;

if (
  !databaseUrl
  && (!databaseHost || !databaseName || !databaseUser || !databasePassword)
) {
  throw new Error(
    'Configurare DATABASE_URL oppure DATABASE_HOST, DATABASE_NAME, '
      + 'DATABASE_USER e DATABASE_PASSWORD',
  );
}

const pool = new Pool({
  ...(databaseUrl
    ? { connectionString: databaseUrl }
    : {
        host: databaseHost,
        port: Number(process.env.DATABASE_PORT || 5432),
        database: databaseName,
        user: databaseUser,
        password: databasePassword,
      }),
  ssl: process.env.DATABASE_SSL === 'true'
    ? { rejectUnauthorized: false }
    : false,
  max: 5,
  idleTimeoutMillis: 30_000,
  connectionTimeoutMillis: 5_000,
  statement_timeout: 10_000,
  application_name: 'auto-tco-web',
});

const app = express();
const port = Number(process.env.PORT || 3000);
const currentDirectory = path.dirname(fileURLToPath(import.meta.url));
const publicDirectory = path.resolve(currentDirectory, '../public');

app.disable('x-powered-by');
app.set('trust proxy', 1);

app.use((_request, response, next) => {
  response.setHeader('X-Content-Type-Options', 'nosniff');
  response.setHeader('X-Frame-Options', 'DENY');
  response.setHeader('Referrer-Policy', 'strict-origin-when-cross-origin');
  response.setHeader(
    'Permissions-Policy',
    'camera=(), microphone=(), geolocation=(), payment=()',
  );
  response.setHeader(
    'Content-Security-Policy',
    "default-src 'self'; base-uri 'none'; connect-src 'self'; "
      + "font-src 'self'; form-action 'self'; frame-ancestors 'none'; "
      + "img-src 'self' data:; object-src 'none'; script-src 'self'; "
      + "style-src 'self'",
  );

  if (process.env.NODE_ENV === 'production') {
    response.setHeader(
      'Strict-Transport-Security',
      'max-age=31536000; includeSubDomains',
    );
  }

  next();
});

app.use(express.json({ limit: '32kb' }));

function createRateLimiter({ windowMs, maximum }) {
  const clients = new Map();

  const cleanup = setInterval(() => {
    const now = Date.now();

    for (const [key, value] of clients) {
      if (value.resetAt <= now) {
        clients.delete(key);
      }
    }
  }, windowMs);

  cleanup.unref();

  return (request, response, next) => {
    const now = Date.now();
    const key = request.ip || 'unknown';
    let client = clients.get(key);

    if (!client || client.resetAt <= now) {
      client = { count: 0, resetAt: now + windowMs };
      clients.set(key, client);
    }

    client.count += 1;
    response.setHeader('RateLimit-Limit', String(maximum));
    response.setHeader(
      'RateLimit-Remaining',
      String(Math.max(0, maximum - client.count)),
    );
    response.setHeader(
      'RateLimit-Reset',
      String(Math.ceil(client.resetAt / 1000)),
    );

    if (client.count > maximum) {
      response.setHeader(
        'Retry-After',
        String(Math.ceil((client.resetAt - now) / 1000)),
      );
      response.status(429).json({
        error: 'Troppe richieste. Riprova tra poco.',
      });
      return;
    }

    next();
  };
}

const apiRateLimiter = createRateLimiter({
  windowMs: 60_000,
  maximum: 120,
});
const estimateRateLimiter = createRateLimiter({
  windowMs: 60_000,
  maximum: 30,
});

app.use('/api/v1', apiRateLimiter);

function parseInteger(value, name, minimum, maximum) {
  const parsed = Number(value);

  if (!Number.isInteger(parsed) || parsed < minimum || parsed > maximum) {
    const error = new Error(
      `${name} deve essere un intero tra ${minimum} e ${maximum}`,
    );
    error.status = 400;
    throw error;
  }

  return parsed;
}

function requireText(value, name, maximumLength = 100) {
  if (typeof value !== 'string') {
    const error = new Error(`${name} non valido`);
    error.status = 400;
    throw error;
  }

  const normalized = value.trim();

  if (!normalized || normalized.length > maximumLength) {
    const error = new Error(`${name} non valido`);
    error.status = 400;
    throw error;
  }

  return normalized;
}

app.get('/api/v1/health', async (_request, response, next) => {
  try {
    await pool.query('SELECT 1');
    response.json({ status: 'ok' });
  } catch (error) {
    next(error);
  }
});

app.get('/api/v1/brands', async (_request, response, next) => {
  try {
    const result = await pool.query(`
      SELECT
        brand_key,
        min(brand) AS brand
      FROM mvp.site_vehicle_catalog_eea_v2
      WHERE model_key NOT IN (
        'UNKNOWN', 'UNK', 'NA', 'NULL', 'NOTAVAILABLE'
      )
        AND model_key <> 'GV80GENESISGV80'
      GROUP BY brand_key
      ORDER BY min(brand)
    `);

    response.json({ items: result.rows });
  } catch (error) {
    next(error);
  }
});

app.get('/api/v1/models', async (request, response, next) => {
  try {
    const brandKey = requireText(request.query.brand_key, 'brand_key', 60);
    const result = await pool.query(
      `
        SELECT DISTINCT
          model_catalog_id,
          brand_key,
          seed_model_id,
          brand,
          model_key,
          model
        FROM mvp.site_vehicle_catalog_eea_v2
        WHERE brand_key = $1
          AND model_key NOT IN (
            'UNKNOWN', 'UNK', 'NA', 'NULL', 'NOTAVAILABLE'
          )
          AND model_key <> 'GV80GENESISGV80'
        ORDER BY model
      `,
      [brandKey],
    );

    response.json({ items: result.rows });
  } catch (error) {
    next(error);
  }
});

app.get('/api/v1/versions', async (request, response, next) => {
  try {
    const modelId = requireText(
      request.query.model_id,
      'model_id',
      64,
    );
    const result = await pool.query(
      `
        SELECT
          vehicle_cluster_id,
          model_catalog_id,
          vehicle_profile_id,
          seed_model_id,
          brand,
          model,
          version_label,
          fuel_type,
          hybrid_type,
          powertrain_type,
          power_kw,
          power_cv,
          energy_data_status,
          depreciation_data_status,
          observation_quality,
          registrations_count
        FROM mvp.site_vehicle_catalog_eea_v2
        WHERE model_catalog_id = $1
          AND model_key NOT IN (
            'UNKNOWN', 'UNK', 'NA', 'NULL', 'NOTAVAILABLE'
          )
          AND model_key <> 'GV80GENESISGV80'
        ORDER BY
          registrations_count DESC,
          fuel_type,
          power_cv NULLS LAST,
          vehicle_cluster_id
      `,
      [modelId],
    );

    response.json({ items: result.rows });
  } catch (error) {
    next(error);
  }
});

app.get('/api/v1/regions', async (_request, response, next) => {
  try {
    const result = await pool.query(`
      SELECT
        region_code,
        region_name
      FROM mvp.tax_jurisdictions
      ORDER BY display_order, region_name
    `);

    response.json({ items: result.rows });
  } catch (error) {
    next(error);
  }
});

app.post(
  '/api/v1/tco/estimate',
  estimateRateLimiter,
  async (request, response, next) => {
  try {
    const vehicleClusterId = requireText(
      request.body.vehicle_cluster_id,
      'vehicle_cluster_id',
      64,
    );
    const annualKm = parseInteger(
      request.body.annual_km,
      'annual_km',
      1_000,
      100_000,
    );
    const ownershipYears = parseInteger(
      request.body.ownership_years,
      'ownership_years',
      1,
      10,
    );
    const regionCode = requireText(
      request.body.region_code,
      'region_code',
      60,
    ).toLowerCase();

    const result = await pool.query(
      `
        SELECT mvp.estimate_vehicle_cluster_tco_ui_v2(
          $1::text,
          $2::integer,
          $3::integer,
          $4::text,
          CURRENT_DATE
        ) AS estimate
      `,
      [vehicleClusterId, annualKm, ownershipYears, regionCode],
    );

    response.json(result.rows[0].estimate);
  } catch (error) {
    next(error);
  }
  },
);

app.use(express.static(publicDirectory, {
  etag: false,
  lastModified: false,
  setHeaders(response) {
    response.setHeader('Cache-Control', 'no-store, max-age=0');
  },
}));

app.use((request, response) => {
  if (request.path.startsWith('/api/')) {
    response.status(404).json({ error: 'Endpoint non trovato' });
    return;
  }

  response.sendFile(path.join(publicDirectory, 'index.html'));
});

app.use((error, _request, response, _next) => {
  const status = Number(error.status) || 500;

  if (status >= 500) {
    console.error(error);
  }

  response.status(status).json({
    error: status >= 500
      ? 'Errore interno del servizio'
      : error.message,
  });
});

const server = app.listen(port, () => {
  console.log(`Auto TCO disponibile su http://localhost:${port}`);
});

async function shutdown() {
  server.close(async () => {
    await pool.end();
    process.exit(0);
  });
}

process.on('SIGINT', shutdown);
process.on('SIGTERM', shutdown);
