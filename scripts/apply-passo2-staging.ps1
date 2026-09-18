$ErrorActionPreference = 'Stop'

$repository = Split-Path -Parent $PSScriptRoot
$workspace = Split-Path -Parent $repository
$psql = 'C:\Program Files\PostgreSQL\18\bin\psql.exe'
$generatedMigration = Join-Path $workspace 'pipeline_review_output_v2\48_passo2_staging_pipeline_eea.generated.sql'

if (-not (Test-Path -LiteralPath $psql)) {
  throw "psql non trovato in $psql"
}

function Invoke-NodeStep {
  param(
    [Parameter(Mandatory = $true)]
    [string]$Label,
    [Parameter(Mandatory = $true)]
    [string[]]$Arguments
  )

  Write-Host $Label
  & node @Arguments
  if ($LASTEXITCODE -ne 0) {
    throw "Passo 2 interrotto durante: $Label"
  }
}

Push-Location $repository
try {
  Invoke-NodeStep '1/8 Normalizzazione delle osservazioni EEA finali...' @(
    '.\scripts\normalize-eea-history.mjs'
  )
  Invoke-NodeStep '2/8 Costruzione delle identita commerciali candidate...' @(
    '.\scripts\build-eea-historical-catalog-v2.mjs'
  )
  Invoke-NodeStep '3/8 Costruzione degli intervalli TVV confermati...' @(
    '.\scripts\build-eea-display-ranges-v2.mjs'
  )
  Invoke-NodeStep '4/8 Riconciliazione col catalogo pubblico corrente...' @(
    '.\scripts\audit-eea-catalog-diff.mjs',
    '--offline'
  )
  Invoke-NodeStep '5/8 Test della pipeline storica...' @(
    '.\tests\eea-history-pipeline.mjs'
  )
  Invoke-NodeStep '6/8 Test delle regressioni del frontend...' @(
    '.\tests\frontend-regressions.mjs'
  )
  Invoke-NodeStep '7/8 Generazione della migrazione atomica di staging...' @(
    '.\scripts\build-passo2-staging-sql.mjs'
  )

  if (-not (Test-Path -LiteralPath $generatedMigration)) {
    throw "Migrazione generata non trovata in $generatedMigration"
  }

  Write-Host '8/8 Caricamento nello staging privato Supabase...'
  & $psql `
    -h 'aws-0-eu-west-1.pooler.supabase.com' `
    -p 5432 `
    -d postgres `
    -U 'postgres.fcrqsmggqpmdhttqdhqh' `
    -v ON_ERROR_STOP=1 `
    -f $generatedMigration

  if ($LASTEXITCODE -ne 0) {
    throw 'Caricamento non applicato: la transazione e stata annullata.'
  }

  Write-Host 'Passo 2 caricato nello staging privato e verificato.'
  Write-Host 'Il catalogo pubblico del sito non e stato modificato.'
  Write-Host 'Nessun commit e nessun push eseguito.'
}
finally {
  Pop-Location
}
