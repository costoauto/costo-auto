$ErrorActionPreference = 'Stop'

$repository = Split-Path -Parent $PSScriptRoot
$psql = 'C:\Program Files\PostgreSQL\18\bin\psql.exe'
$migration = Join-Path $repository 'supabase\47_passo1_integrita_catalogo_e_superbollo.sql'
$frontendTest = Join-Path $repository 'tests\frontend-regressions.mjs'

if (-not (Test-Path -LiteralPath $psql)) {
  throw "psql non trovato in $psql"
}

Write-Host 'Passo 1/2: applicazione atomica della migrazione al database online...'
& $psql `
  -h 'aws-0-eu-west-1.pooler.supabase.com' `
  -p 5432 `
  -d postgres `
  -U 'postgres.fcrqsmggqpmdhttqdhqh' `
  -v ON_ERROR_STOP=1 `
  -f $migration

if ($LASTEXITCODE -ne 0) {
  throw 'Migrazione non applicata: la transazione e stata annullata.'
}

Write-Host 'Passo 2/2: test delle regressioni del frontend...'
& node $frontendTest

if ($LASTEXITCODE -ne 0) {
  throw 'Il database e stato aggiornato, ma i test del frontend non sono passati.'
}

Write-Host 'Passo 1 completato e verificato. Nessun commit e nessun push eseguito.'
