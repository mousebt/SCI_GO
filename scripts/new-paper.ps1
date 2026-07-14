param(
    [Parameter(Mandatory = $true)][string]$Slug,
    [Parameter(Mandatory = $true)][string]$Title,
    [ValidateSet('auto','existing_zh_manuscript','materials_from_scratch')][string]$StartMode = 'auto',
    [switch]$SkipKnowledgeSync
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

if ($Slug -notmatch '^[a-z0-9]+(?:-[a-z0-9]+)*$') {
    throw 'Slug must contain lowercase letters, digits, and single hyphens only.'
}

$root = Split-Path -Parent $PSScriptRoot
$template = Join-Path $root 'templates\paper'
$papers = Join-Path $root 'papers'
$destination = Join-Path $papers $Slug

if (Test-Path -LiteralPath $destination) {
    throw "Paper directory already exists: $destination"
}

if (-not $SkipKnowledgeSync) {
    & (Join-Path $PSScriptRoot 'sync-knowledge.ps1') -Apply
}

New-Item -ItemType Directory -Force -Path $papers | Out-Null
New-Item -ItemType Directory -Path $destination | Out-Null
Get-ChildItem -LiteralPath $template -Force | ForEach-Object {
    Copy-Item -LiteralPath $_.FullName -Destination $destination -Recurse -Force
}

$emptyStructure = @(
    '03_manuscript\sections',
    '04_figures\source',
    '04_figures\final',
    'tmp'
)
foreach ($relative in $emptyStructure) {
    New-Item -ItemType Directory -Force -Path (Join-Path $destination $relative) | Out-Null
}

$date = Get-Date -Format 'yyyy-MM-dd'
$tokenFiles = @(
    (Join-Path $destination 'paper.yaml'),
    (Join-Path $destination '03_manuscript\main.md')
)

foreach ($file in $tokenFiles) {
    $content = Get-Content -Raw -Encoding UTF8 -LiteralPath $file
    $content = $content.Replace('__SLUG__', $Slug).Replace('__TITLE__', $Title).Replace('__DATE__', $date).Replace('__START_MODE__', $StartMode)
    Set-Content -LiteralPath $file -Value $content -Encoding UTF8
}

Write-Output "Created paper workspace: $destination"
Write-Output "Startup mode: $StartMode"
Write-Output 'Next: complete 01_planning/research-brief.md, claim-evidence.csv, and terminology.csv.'
