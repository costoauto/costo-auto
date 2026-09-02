# Costo Auto

Webapp mobile-first per stimare il costo mensile reale di possesso di un’auto.

## Architettura

- GitHub Pages pubblica i file statici presenti nella cartella principale del
  repository, come nella precedente versione del sito.
- Supabase conserva il database PostgreSQL ed espone soltanto cinque funzioni
  RPC in sola lettura.
- Le tabelle negli schemi `raw`, `curated` e `mvp` non sono accessibili
  direttamente dal browser.
- Nessuna password del database o chiave amministrativa è presente nel codice.
- La chiave `publishable` presente in `config.js` è una credenziale
  pubblica prevista per applicazioni web e opera con il ruolo limitato `anon`.

## Componenti mostrate

- svalutazione;
- carburante o energia;
- bollo;
- RC Auto media;
- manutenzione ordinaria.

Pneumatici, revisione e interventi straordinari non sono inclusi. La pagina
permette anche di confrontare due versioni applicando a entrambe gli stessi
chilometri annui, anni di possesso e area di riferimento.

Una componente mancante viene dichiarata come non disponibile e non viene
sostituita con un valore inventato.

## Configurazione Supabase

Eseguire una sola volta `supabase/01_public_api.sql` nel SQL Editor del progetto,
quindi abilitare la Data API lasciando disattivata l’esposizione automatica delle
nuove tabelle.

Le sole funzioni accessibili al ruolo anonimo sono:

- `public.auto_tco_brands()`;
- `public.auto_tco_models(text)`;
- `public.auto_tco_versions(text)`;
- `public.auto_tco_regions()`;
- `public.auto_tco_estimate_variant(text, text, integer, integer, text)`.

Il browser invia soltanto gli identificativi pubblici della versione e gli
input scelti dall’utente. Formule, fonti di costo e tabelle tecniche rimangono
nel database e non sono esposte dalla Data API.

## Dati e qualità delle stime

- consumi e caratteristiche tecniche provengono dal catalogo pubblico curato e
  dalle fonti registrate nel database;
- i prezzi di benzina, gasolio, GPL e metano usano le medie MIMIT disponibili;
- il prezzo dell’energia elettrica usa il riferimento ARERA registrato nel
  database;
- il bollo è calcolato con le regole disponibili per area, potenza,
  alimentazione e classe ambientale;
- la RC Auto è una media territoriale IVASS, non un preventivo personale;
- la manutenzione è una stima di tagliandi, materiali di consumo e usura
  prevedibile; esclude pneumatici, revisione e interventi straordinari;
- la svalutazione usa il profilo economico disponibile e, dove previsto,
  confronti dichiarati con versioni o modelli comparabili.

Ogni componente conserva nel payload il metodo, le assunzioni e il livello di
affidabilità disponibili. Un dato assente non viene sostituito con un importo
casuale.

## Pubblicazione

GitHub Pages pubblica direttamente il ramo `main`, usando `index.html` come
pagina iniziale.

Dump, snapshot del database, file `.env`, password e chiavi amministrative non
devono essere caricati nel repository.
