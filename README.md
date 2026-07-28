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
- La chiave `publishable` presente in `public/config.js` è una credenziale
  pubblica prevista per applicazioni web e opera con il ruolo limitato `anon`.

## Componenti mostrate

- svalutazione;
- carburante o energia;
- bollo;
- assicurazione.

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
- `public.auto_tco_estimate(text, integer, integer, text)`.

## Pubblicazione

GitHub Pages pubblica direttamente il ramo `main`, usando `index.html` come
pagina iniziale.

Dump, snapshot del database, file `.env`, password e chiavi amministrative non
devono essere caricati nel repository.
