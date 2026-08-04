import crypto from 'node:crypto';
import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const cacheDir = path.join(scriptDir, '.cache', 'adac-phev');
const matches = JSON.parse(
  await fs.readFile(
    path.join(scriptDir, 'adac-phev-model-matches.json'),
    'utf8',
  ),
);
const powerCatalog = JSON.parse(
  await fs.readFile(
    path.join(scriptDir, 'adac-phev-system-power.json'),
    'utf8',
  ),
);

function decodeHtml(value) {
  return String(value || '')
    .replace(/<[^>]+>/g, ' ')
    .replace(/&nbsp;|&#160;/gi, ' ')
    .replace(/&amp;/gi, '&')
    .replace(/\s+/g, ' ')
    .trim();
}

const models = [
  ...new Map(
    powerCatalog.coverage.uncovered.map((item) => [
      `${item.brand}|${item.model}`,
      item,
    ]),
  ).values(),
];

for (const model of models) {
  const match = matches.items.find(
    (item) => item.brand === model.brand && item.model === model.model,
  );
  const fuels = new Set();
  let rows = 0;
  let firstPhevDetailUrl = null;
  let technicalPowerText = null;

  for (const url of match?.generation_urls || []) {
    const hash = crypto.createHash('sha256').update(url).digest('hex');
    const target = path.join(cacheDir, `${hash}.html`);
    let html = '';
    try {
      html = await fs.readFile(target, 'utf8');
    } catch {
      // La pagina non era inclusa nel primo passaggio.
    }
    const cells = html.match(
      /<td[^>]*data-th="Kraftstoff"[^>]*>[\s\S]*?<\/td>/gi,
    ) || [];
    rows += cells.length;
    cells.forEach((cell) => fuels.add(decodeHtml(cell)));

    if (!firstPhevDetailUrl) {
      const tableRows = html.match(
        /<tr[^>]*data-testid="carpages:generation:model:row"[\s\S]*?<\/tr>/gi,
      ) || [];
      const phevRow = tableRows.find((row) => {
        const fuelCell = row.match(
          /<td[^>]*data-th="Kraftstoff"[^>]*>([\s\S]*?)<\/td>/i,
        )?.[1];
        return /strom/i.test(decodeHtml(fuelCell))
          && /(super|benzin|diesel)/i.test(decodeHtml(fuelCell));
      });
      const href = phevRow?.match(
        /href="(\/rund-ums-fahrzeug\/autokatalog\/marken-modelle\/[^"]+\/\d+\/)"/i,
      )?.[1];
      if (href) {
        firstPhevDetailUrl = new URL(href, 'https://www.adac.de').href;
      }
    }
  }

  if (firstPhevDetailUrl) {
    const hash = crypto
      .createHash('sha256')
      .update(firstPhevDetailUrl)
      .digest('hex');
    const target = path.join(cacheDir, `${hash}.html`);
    try {
      const detail = decodeHtml(await fs.readFile(target, 'utf8'));
      const marker = detail.toLowerCase().indexOf('verbrennungsmotor');
      technicalPowerText = marker >= 0
        ? detail.slice(Math.max(0, marker - 100), marker + 300)
        : null;
    } catch {
      // Nessuna scheda tecnica in cache.
    }
  }

  console.log(JSON.stringify({
    brand: model.brand,
    model: model.model,
    adac_model_slug: match?.adac_model_slug,
    generation_pages: match?.generation_urls?.length || 0,
    rows,
    fuels: [...fuels],
    first_phev_detail_url: firstPhevDetailUrl,
    technical_power_text: technicalPowerText,
  }));
}
