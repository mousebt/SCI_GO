param([string]$Slug)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$root = Split-Path -Parent $PSScriptRoot
$papersRoot = Join-Path $root 'papers'
$paperDirs = @(if ($Slug) {
    @((Get-Item -LiteralPath (Join-Path $papersRoot $Slug)))
} else {
    @(Get-ChildItem -LiteralPath $papersRoot -Directory -ErrorAction SilentlyContinue)
})

$requiredPaths = @(
    'paper.yaml',
    '00_admin\intake-manifest.csv',
    '01_planning\research-brief.md',
    '02_evidence\claim-evidence.csv',
    '02_evidence\terminology.csv',
    '03_manuscript\main.md',
    '06_review\change-log.md',
    '07_submission\checklist.md',
    '90_learning\lessons.csv',
    'tmp'
)

$errors = @()
foreach ($paper in $paperDirs) {
    foreach ($relative in $requiredPaths) {
        if (-not (Test-Path -LiteralPath (Join-Path $paper.FullName $relative))) {
            $errors += "$($paper.Name): missing $relative"
        }
    }

    $paperConfig = Join-Path $paper.FullName 'paper.yaml'
    if (Test-Path -LiteralPath $paperConfig) {
        $configText = Get-Content -Raw -Encoding UTF8 -LiteralPath $paperConfig
        if ($configText -notmatch '(?m)^start_mode:\s*"?(auto|existing_zh_manuscript|materials_from_scratch)"?\s*$') {
            $errors += "$($paper.Name): invalid or missing start_mode in paper.yaml"
        }
    }
}

$rootTemp = @(Get-ChildItem -LiteralPath $root -File -Force |
    Where-Object { $_.Extension -in @('.tmp', '.bak') -or $_.Name -match '^(temp|tmp)[-_]' })
foreach ($file in $rootTemp) {
    $errors += "Temporary file found in repository root: $($file.Name)"
}

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output "Preflight passed: $($paperDirs.Count) paper workspaces are structurally complete."
