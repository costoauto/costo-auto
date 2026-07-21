# Costo Auto

Webapp mobile-first per stimare il costo mensile reale di possesso di un’auto.

La pagina consente di scegliere marca, modello e versione, quindi aggiorna
automaticamente la stima in base a chilometri annui, anni di possesso e area
geografica. I dati e i calcoli arrivano da PostgreSQL tramite un servizio Node.js:
le credenziali del database non vengono mai inviate al browser.

## Componenti mostrate

- svalutazione;
- carburante o energia;
- bollo;
- assicurazione.

Una componente mancante viene dichiarata come non disponibile e non viene
sostituita con un valore inventato.

## Avvio locale

1. Copiare `.env.example` in `.env`.
2. Inserire in `.env` la connessione PostgreSQL dell’utente web di sola lettura.
3. Eseguire `npm install`.
4. Eseguire `npm start`.
5. Aprire `http://localhost:3000`.

## Variabili d’ambiente

- `DATABASE_URL`: connessione PostgreSQL completa.
- `DATABASE_SSL`: `true` se il database remoto richiede SSL, altrimenti `false`.
- `PORT`: porta del servizio; in hosting viene assegnata automaticamente.

Il file `.env` contiene dati riservati ed è escluso da Git.

## API

- `GET /api/v1/health`
- `GET /api/v1/brands`
- `GET /api/v1/models?brand_key=ALFAROMEO`
- `GET /api/v1/versions?model_id=<model_catalog_id>`
- `GET /api/v1/regions`
- `POST /api/v1/tco/estimate`

Esempio della richiesta di calcolo:

```json
{
  "vehicle_cluster_id": "<vehicle_cluster_id>",
  "annual_km": 15000,
  "ownership_years": 5,
  "region_code": "italia"
}
```

## Oggetti PostgreSQL richiesti

Il servizio usa almeno questi oggetti del database Auto TCO:

- `mvp.site_vehicle_catalog_eea_v2`;
- `mvp.tax_jurisdictions`;
- `mvp.estimate_vehicle_cluster_tco_ui_v2(...)`.

Il trasferimento del database di produzione è separato dalla pubblicazione del
codice: dump, tabelle grezze e password non devono essere caricati su GitHub.

## Pubblicazione

Il repository contiene `render.yaml`, che configura un servizio web Node.js.
Durante la creazione del servizio vanno inserite in modo protetto
`DATABASE_URL` e `DATABASE_SSL`.
