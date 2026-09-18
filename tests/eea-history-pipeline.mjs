import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const testDir = path.dirname(fileURLToPath(import.meta.url));
const repoDir = path.dirname(testDir);
const workspaceDir = path.dirname(repoDir);

const manifest = JSON.parse(fs.readFileSync(
  path.join(repoDir, 'docs', 'audits', 'eea-history-canonical-manifest.json'),
  'utf8',
));
const normalizedManifest = JSON.parse(fs.readFileSync(
  path.join(repoDir, 'docs', 'audits', 'eea-history-normalized-manifest.json'),
  'utf8',
));
const catalog = JSON.parse(fs.readFileSync(
  path.join(workspaceDir, 'historical_catalog_output_v2', 'historical-versions.json'),
  'utf8',
));
const diff = JSON.parse(fs.readFileSync(
  path.join(workspaceDir, 'historical_catalog_output_v2', 'catalog-diff.json'),
  'utf8',
));

assert.equal(manifest.files.length, 15, 'Devono essere presenti 15 annualita');
assert.deepEqual(
  manifest.files.map((item) => item.year),
  Array.from({ length: 15 }, (_, index) => 2010 + index),
  'Gli anni devono coprire senza buchi il periodo 2010-2024',
);
assert.ok(
  manifest.files.every((item) => item.status === 'F' && item.quality === 'final'),
  'Ogni anno deve usare una sola edizione finale',
);
assert.ok(
  manifest.files.every((item) => item.rows > 0 && /^[a-f0-9]{64}$/.test(item.data_sha256)),
  'Ogni sorgente deve avere righe e hash SHA-256',
);

assert.equal(
  normalizedManifest.files.length,
  15,
  'Devono essere presenti 15 annualita normalizzate',
);
assert.equal(
  normalizedManifest.totals.rows,
  manifest.totals.rows,
  'Il livello normalizzato non deve perdere osservazioni canoniche',
);
assert.ok(
  normalizedManifest.files.every((item) => (
    item.source_status === 'F'
    && /^[a-f0-9]{64}$/.test(item.source_data_sha256)
    && /^[a-f0-9]{64}$/.test(item.normalized_sha256)
  )),
  'Ogni file normalizzato deve essere riconducibile a una sorgente finale verificata',
);

const normalizedObservationIds = new Set();
let normalizedRows = 0;
for (const file of normalizedManifest.files) {
  const payload = JSON.parse(fs.readFileSync(
    path.join(workspaceDir, 'eea_history_normalized_v2', file.file),
    'utf8',
  ));
  for (const row of payload.rows) {
    normalizedRows += 1;
    assert.equal(row.source_status, 'F', 'Una osservazione normalizzata non e finale');
    assert.equal(row.generation, null, 'La generazione non deve essere inventata dai dati EEA');
    assert.equal(row.transmission, null, 'Il cambio non deve essere inventato dai dati EEA');
    assert.equal(row.traction, null, 'La trazione non deve essere inventata dai dati EEA');
    assert.equal(
      row.power_semantics,
      'engine_power_reported_by_eea_not_commercial_system_power',
      'La semantica della potenza EEA deve essere esplicita',
    );
    assert.ok(
      !normalizedObservationIds.has(row.observation_id),
      `ID osservazione duplicato: ${row.observation_id}`,
    );
    normalizedObservationIds.add(row.observation_id);
  }
}
assert.equal(
  normalizedRows,
  normalizedManifest.totals.rows,
  'Il totale delle osservazioni normalizzate deve coincidere col manifest',
);

const ids = catalog.map((item) => item.historical_version_id);
assert.equal(new Set(ids).size, ids.length, 'Gli ID storici devono essere univoci');
assert.ok(
  catalog.every((item) => item.source_status === 'F'),
  'Il catalogo v2 non deve contenere righe provvisorie',
);
assert.ok(
  catalog.filter((item) => item.publication_status === 'publishable')
    .every((item) => item.confidence !== 'low'),
  'Le donazioni da altri modelli non devono essere pubblicate automaticamente',
);
assert.ok(
  catalog.filter((item) => item.publication_status === 'candidate')
    .every((item) => item.quarantine_reasons.length > 0),
  'Ogni candidato deve avere un motivo di quarantena',
);

assert.ok(
  diff.removed_from_publishable.some((item) => (
    item.brand === 'Alfa Romeo' && item.model === '147' && item.year === 2017
  )),
  'Il falso profilo Alfa Romeo 147 del 2017 deve risultare rimosso',
);
assert.equal(
  diff.counts.canonical_selected_versions,
  catalog.length,
  'Il riepilogo del diff deve coincidere con il catalogo generato',
);

console.log('EEA history pipeline: 14/14 ok');
