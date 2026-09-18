# Passo 2 — Pipeline storica EEA riproducibile

Aggiornato il 18 settembre 2026.

Stato: **staging privato caricato su Supabase e verificato; catalogo pubblico
invariato a 4.646 versioni**.

## Risultato

La pipeline storica non legge più indiscriminatamente le edizioni provvisorie
e finali dello stesso anno. Per ogni annualità italiana dal 2010 al 2024 usa
una sola edizione finale EEA e conserva separati questi livelli:

1. snapshot sorgente preservato;
2. annualità canonica finale;
3. osservazione normalizzata, con ID e provenienza;
4. osservazione commerciale aggregata;
5. identità candidata e stima;
6. intervallo di anni sostenuto da continuità TVV;
7. riconciliazione col catalogo pubblico corrente.

I dati del 2025 restano la fotografia recente già importata e vengono usati
soltanto nella continuità TVV 2010–2025. Non vengono mescolati alle annualità
storiche finali 2010–2024.

## Perché era necessario

Nei file preservati 2010–2021 erano presenti insieme edizioni `P`
(provvisorie) e `F` (finali). La vecchia pipeline le sommava. La selezione
canonica elimina 156.716 righe duplicate tra edizioni, pari al 40,53% delle
righe dello snapshot di partenza, senza cancellare i file grezzi.

La vecchia pipeline poteva inoltre completare un consumo mancante prendendolo
da un altro modello e pubblicare il risultato. Nella pipeline v2 questi 185
casi sono candidati in quarantena: rimangono analizzabili, ma non possono
diventare automaticamente versioni pubbliche.

## Numeri verificati

- 15 annualità finali consecutive, dal 2010 al 2024;
- 231.817 osservazioni normalizzate;
- 11.343.234 immatricolazioni nella sorgente canonica;
- 8.955.114 immatricolazioni abbinate a un modello noto, pari al 78,95%;
- 15.060 osservazioni commerciali aggregate;
- 10.761 identità candidate selezionate;
- 10.576 candidate pubblicabili secondo le sole regole automatiche;
- 185 candidate in quarantena;
- 2.263 intervalli TVV ad alta affidabilità;
- 4.646 versioni online riconciliate;
- 14/14 controlli della pipeline e 7/7 regressioni frontend superati.
- zero candidati invalidi nello staging online;
- privilegi di lettura negati al ruolo pubblico `anon`.

Il 21,05% delle immatricolazioni non abbinate non viene trasformato in modelli
inventati: resta esplicitamente fuori dall’automazione e potrà essere trattato
nel Passo 3.

## Confronto col catalogo online

La pipeline non sostituisce ancora il catalogo pubblico. Il confronto corrente
classifica le 4.646 versioni online così:

- 862 confermate da continuità TVV;
- 1.225 da separare o ricostruire;
- 1.346 osservate nei dati EEA ma sotto la soglia automatica di pubblicazione;
- 1.141 non sufficientemente sostenute dalla selezione EEA canonica;
- 41 fuori dal perimetro temporale EEA 2010–2024;
- 31 curate commercialmente, da conservare finché una fonte migliore non le
  sostituisce.

L’assenza dai dati di immatricolazione EEA non dimostra che una versione
commerciale non sia mai esistita. Per questo le righe non sostenute non vengono
cancellate automaticamente: diventano il lavoro prioritario del Passo 3.

## Sicurezza dello staging online

La migrazione `supabase/48_passo2_staging_pipeline_eea.sql` crea solo tabelle
private nello schema `mvp`. Revoca esplicitamente ogni privilegio a `PUBLIC`,
`anon` e `authenticated`; non crea endpoint pubblici e non modifica le funzioni
usate dal sito.

Il caricamento è racchiuso in una transazione. Prima e dopo conta le versioni
restituite da `public.auto_tco_versions`: se cambiano, la transazione fallisce.
Controlla inoltre conteggi, edizioni finali, quarantene, intervalli e privilegi.

## Esecuzione locale ripetibile

Gli script vanno eseguiti in quest’ordine:

```text
node scripts/normalize-eea-history.mjs
node scripts/build-eea-historical-catalog-v2.mjs
node scripts/build-eea-display-ranges-v2.mjs
node scripts/audit-eea-catalog-diff.mjs --offline
node tests/eea-history-pipeline.mjs
node tests/frontend-regressions.mjs
node scripts/build-passo2-staging-sql.mjs
```

Il wrapper `scripts/apply-passo2-staging.ps1` esegue l’intera sequenza e poi
carica il risultato nello staging Supabase. Chiede la password del database una
sola volta. Non esegue commit Git e non pubblica nulla.

Gli output voluminosi restano fuori dal repository nelle cartelle sorelle:

- `eea_history_canonical`;
- `eea_history_normalized_v2`;
- `historical_catalog_output_v2`;
- `catalog_audit_output_v2`;
- `pipeline_review_output_v2`.

## Regola di promozione

Nessuna riga dello staging diventa visibile automaticamente. Nel Passo 3 si
conserveranno le cure documentate, si promuoveranno le conferme TVV e si
verificheranno per famiglia commerciale separazioni, casi sotto soglia e casi
non sostenuti. Solo dopo un nuovo audit completo verrà sostituita la vista
pubblica.
