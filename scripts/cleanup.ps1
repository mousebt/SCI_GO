param(
    [switch]$Apply,
    [int]$RetentionDays = -1
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$root = Split-Path -Parent $PSScriptRoot
$policyPath = Join-Path $root 'config\cleanup-policy.json'
$policy = Get-Content -Raw -Encoding UTF8 -LiteralPath $policyPath | ConvertFrom-Json

if ($RetentionDays -lt 0) {
    $RetentionDays = [int]$policy.retention_days
}

$cutoff = (Get-Date).AddDays(-$RetentionDays)
$papersRoot = Join-Path $root 'papers'
$preserve = @($policy.preserve_names)
$temporaryNames = @($policy.temporary_directory_names)
$candidates = @()

if (Test-Path -LiteralPath $papersRoot) {
    $tempDirs = Get-ChildItem -LiteralPath $papersRoot -Directory -Recurse -Force |
        Where-Object { $temporaryNames -contains $_.Name }

    foreach ($directory in $tempDirs) {
        $candidates += Get-ChildItem -LiteralPath $directory.FullName -File -Recurse -Force |
            Where-Object { ($preserve -notcontains $_.Name) -and ($_.LastWriteTime -lt $cutoff) }
    }
}

$candidates = @($candidates | Sort-Object FullName -Unique)
if ($candidates.Count -eq 0) {
    Write-Output "No temporary files older than $RetentionDays days."
    exit 0
}

$mode = if ($Apply) { 'APPLY' } else { 'DRY RUN' }
Write-Output "$mode`: found $($candidates.Count) temporary files older than $RetentionDays days:"

foreach ($file in $candidates) {
    Write-Output $file.FullName
    if ($Apply) {
        Remove-Item -LiteralPath $file.FullName -Force
    }
}

if (-not $Apply) {
    Write-Output 'Nothing was deleted. Re-run with -Apply after review.'
}
