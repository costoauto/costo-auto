$ErrorActionPreference = 'Stop'

$repository = Split-Path -Parent $PSScriptRoot
$psql = 'C:\Program Files\PostgreSQL\18\bin\psql.exe'
$verification = Join-Path $repository 'supabase\49_verifica_passo2_staging.sql'

if (-not (Test-Path -LiteralPath $psql)) {
  throw "psql non trovato in $psql"
}

Write-Host 'Verifica correttiva read-only del Passo 2...'
& $psql `
  -h 'aws-0-eu-west-1.pooler.supabase.com' `
  -p 5432 `
  -d postgres `
  -U 'postgres.fcrqsmggqpmdhttqdhqh' `
  -v ON_ERROR_STOP=1 `
  -f $verification

if ($LASTEXITCODE -ne 0) {
  throw 'La verifica correttiva non e passata.'
}

Write-Host 'Verifica completata. Nessun dato e stato modificato.'
