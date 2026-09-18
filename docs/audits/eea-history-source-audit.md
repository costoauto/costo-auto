# Audit delle edizioni EEA storiche

Generato: 2026-09-15T15:04:30.104Z

## Esito

Il vecchio generatore leggeva tutte le righe presenti nei file annuali senza scegliere una singola edizione. 12 file su 15 contengono insieme dati finali (F) e provvisori (P), quindi le immatricolazioni e il peso relativo delle versioni potevano essere contati due volte o combinati tra revisioni diverse.

La regola canonica introdotta dall audit e:

- usare F quando esiste;
- usare P solo se F non esiste;
- rifiutare un anno senza una delle due edizioni;
- conservare hash, data di download, URL e statistiche per rendere il processo riproducibile.

Con questa regola si usano 229.917 righe su 386.633. Vengono escluse 156.716 righe (40.53%) appartenenti a edizioni alternative dello stesso anno. Questo non significa che siano tutte duplicati perfetti: 121.187 osservazioni tecniche compaiono sia in F sia in P e 4115 hanno conteggi di immatricolazioni diversi.

## Edizione scelta per anno

| Anno | Scelta | Righe F | Righe P | Righe escluse | Osservazioni comuni F/P | Qualita |
|---:|:---:|---:|---:|---:|---:|:---|
| 2010 | F | 6939 | 5819 | 5819 | 4808 | final |
| 2011 | F | 10.169 | 10.688 | 10.688 | 8401 | final |
| 2012 | F | 9437 | 9562 | 9562 | 8044 | final |
| 2013 | F | 10.236 | 10.343 | 10.343 | 8198 | final |
| 2014 | F | 9602 | 9606 | 9606 | 7358 | final |
| 2015 | F | 12.140 | 10.995 | 10.995 | 9465 | final |
| 2016 | F | 13.083 | 13.143 | 13.143 | 12.698 | final |
| 2017 | F | 13.601 | 13.921 | 13.921 | 12.288 | final |
| 2018 | F | 16.176 | 15.448 | 15.448 | 13.545 | final |
| 2019 | F | 18.504 | 18.572 | 18.572 | 14.741 | final |
| 2020 | F | 20.067 | 19.968 | 19.968 | 15.320 | final |
| 2021 | F | 23.124 | 18.651 | 18.651 | 6321 | final |
| 2022 | P | 0 | 20.348 | 0 | 0 | provisional |
| 2023 | F | 21.878 | 0 | 0 | 0 | final |
| 2024 | P | 0 | 24.613 | 0 | 0 | provisional |

## Conseguenze operative

1. Il catalogo storico corrente non va rigenerato con il vecchio script senza filtro: produrrebbe nuovamente il difetto.
2. Il prossimo generatore deve leggere il manifest e accettare soltanto l edizione scelta per ogni anno.
3. La scelta dell edizione risolve il doppio conteggio alla fonte, ma non basta a garantire identita commerciali corrette: normalizzazione di marca/modello, raggruppamento e donazione di consumi devono avere audit separati.
4. Nessuna modifica al database online e stata applicata da questo audit.
