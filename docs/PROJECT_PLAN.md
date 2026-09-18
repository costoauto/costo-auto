# Piano di consolidamento Auto TCO

Aggiornato il 15 settembre 2026. Questo documento mantiene nel repository il
piano emerso dall'audit completo. Gli interventi vanno applicati in ordine:
ogni passo deve lasciare verifiche ripetibili prima di iniziare il successivo.

## Passo 1 — Identità e regressioni bloccanti

Stato: **database applicato e verificato il 15 settembre 2026; frontend pronto
per la pubblicazione**. Migrazione:
`supabase/47_passo1_integrita_catalogo_e_superbollo.sql`.

Esito registrato: 4.646 versioni pubblicate, 4 versioni impossibili in
quarantena, zero collisioni di identità, Panda 100 HP e Grande Panda benzina
collegate a profili distinti, vecchi endpoint di calcolo chiusi e 7/7 test delle
regressioni frontend superati.

- Separare i profili di Panda 100 HP e Grande Panda benzina.
- Rendere univoca l'identità delle versioni pubblicate.
- Validare insieme modello, versione visualizzata e profilo di calcolo.
- Escludere dal solo catalogo pubblico le versioni già dimostrate impossibili
  di Formentor, Giulia e Stelvio, conservando i dati sorgente.
- Correggere la decorrenza delle riduzioni del superbollo e provarne i confini.
- Eliminare le regressioni asincrone del frontend con test automatici.

Uscita richiesta: nessuna collisione; nessuna versione impossibile nota;
risposte sempre riferite alla selezione corrente; confini fiscali corretti.

## Passo 2 — Pipeline storica riproducibile

Stato: **pipeline completata e staging privato caricato e verificato il 18
settembre 2026; catalogo pubblico invariato**. La verifica correttiva ha contato
4.646 versioni pubbliche, 15.060 osservazioni commerciali, 10.761 identità
candidate, 185 quarantene, 2.263 intervalli TVV e zero candidati invalidi.
Procedura e risultati: `docs/PASSO_2_PIPELINE_EEA.md`.

- Usare una sola edizione EEA per paese e anno, evitando doppi conteggi P/F.
- Separare dati grezzi, osservazioni normalizzate, identità commerciali e stime.
- Rendere tracciabili generazione, motorizzazione, potenze, cambio/trazione,
  ciclo dei consumi e fonte.
- Trattare gli abbinamenti approssimativi come candidati da verificare, non
  come versioni automaticamente pubblicabili.
- Produrre a ogni aggiornamento un diff leggibile di conferme, separazioni,
  esclusioni e casi in attesa.

Uscita richiesta: nessun doppio conteggio e prove compatibili per ogni
intervallo pubblicato.

## Passo 3 — Verifica commerciale estensibile

- Privilegiare listini, schede tecniche e archivi pubblici dei costruttori.
- Usare EEA come riscontro tecnico, ADAC come supporto esplicito per mercato e
  specifica, Wikipedia soltanto come indice o fonte secondaria.
- Procedere per famiglie e generazioni: anomalie note, elettriche ambigue,
  intervalli lunghi, provenienze deboli.
- Mantenere lo stesso nome modello quando corretto, distinguendo le versioni;
  separare gli intervalli quando motore, configurazione o consumo cambiano.

Uscita richiesta: nessuna versione in conflitto con le fonti e provenienza
disponibile per i campi determinanti.

## Passo 4 — Contratto unico di calcolo

- Usare un solo scenario coerente: identità commerciale, anno rappresentativo,
  percorrenza, durata e area.
- Alimentare tutte le componenti con lo stesso anno, salvo differenze motivate
  e dichiarate.
- Distinguere sempre dato ufficiale, misurato, ricostruito e stimato.
- Calcolare l'affidabilità complessiva dal dato rilevante più debole.

Uscita richiesta: componenti semanticamente coerenti e qualità trasparente.

## Passo 5 — Prova finale e pubblicazione controllata

- Ricalcolare tutte le versioni passando dalle API pubbliche reali.
- Verificare corrispondenza menu-risposta, input, slider, regioni e soglie.
- Completare i test mobile, accessibilità, rete lenta/offline e confronto auto.
- Eseguire audit amministrativo dei privilegi e prova di ripristino.
- Dimostrare l'installazione da database vuoto mediante migrazioni ordinate.
- Pubblicare migrazione e frontend come coppia compatibile e verificare il
  codice realmente servito online.

Uscita richiesta: ambiente riproducibile, controllato e monitorabile.

## Regole permanenti

- I dati grezzi non si cancellano per correggere ciò che vede l'utente.
- Un dato proveniente dal database originale non è esente dai controlli.
- Un valore mancante non si trasforma in dato preciso senza fonte o metodo
  esplicito.
- Il catalogo viene corretto a monte: il frontend non deve mascherare versioni
  sbagliate con sole modifiche alle etichette.
- Ogni migrazione strutturale deve essere atomica, reversibile tramite il
  wrapper precedente e accompagnata da verifiche che fermino il commit in caso
  di incoerenza.
