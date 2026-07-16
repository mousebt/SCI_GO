param(
    [Parameter(Mandatory = $true)][string]$Title,
    [string]$Slug = '',
    [string]$OriginalIdea = ''
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$root = Split-Path -Parent $PSScriptRoot
$date = Get-Date -Format 'yyyy-MM-dd'

function Convert-ToSlug([string]$Text) {
    $slug = $Text.ToLowerInvariant() -replace '[^a-z0-9\u4e00-\u9fa5]+','-'
    $slug = $slug.Trim('-')
    if ([string]::IsNullOrWhiteSpace($slug)) {
        $slug = "direction-" + (Get-Date -Format 'yyyyMMdd-HHmmss')
    }
    return $slug
}

if ([string]::IsNullOrWhiteSpace($Slug)) {
    $Slug = Convert-ToSlug $Title
}

$directionId = $Slug
$directionRoot = Join-Path $root "research_directions\active\$directionId"
if (Test-Path -LiteralPath $directionRoot) {
    throw "Research direction already exists: $directionRoot"
}

$dirs = @(
    '',
    '00_brief',
    '01_landscape',
    '02_feasibility',
    '03_idea-bank',
    '04_decisions',
    '05_outputs',
    'tmp'
)

foreach ($dir in $dirs) {
    New-Item -ItemType Directory -Force -Path (Join-Path $directionRoot $dir) | Out-Null
}

$templateRoot = Join-Path $root 'research_directions\templates'

function Expand-Template([string]$TemplateName, [string]$OutputRelativePath) {
    $templatePath = Join-Path $templateRoot $TemplateName
    $outputPath = Join-Path $directionRoot $OutputRelativePath
    $content = Get-Content -Raw -Encoding UTF8 -LiteralPath $templatePath
    $content = $content.Replace('__DIRECTION_ID__', $directionId)
    $content = $content.Replace('__TITLE__', $Title)
    $content = $content.Replace('__CREATED_DATE__', $date)
    $content = $content.Replace('__ORIGINAL_IDEA__', $OriginalIdea)
    Set-Content -LiteralPath $outputPath -Value $content -Encoding UTF8
}

Expand-Template 'direction.yaml' 'direction.yaml'
Expand-Template 'user-notes.md' '00_brief\user-notes.md'
Expand-Template 'initial-question.md' '00_brief\initial-question.md'
Expand-Template 'feasibility-scorecard.md' '02_feasibility\feasibility-scorecard.md'
Expand-Template 'research-direction-report.md' '05_outputs\research-direction-report.md'
Expand-Template 'next-action-plan.md' '05_outputs\next-action-plan.md'
Expand-Template 'direction-decision.md' '04_decisions\direction-decision.md'

Set-Content -LiteralPath (Join-Path $directionRoot '01_landscape\field-map.md') -Encoding UTF8 -Value "# Field map`r`n`r`nDirection ID: $directionId`r`n`r`n"
Set-Content -LiteralPath (Join-Path $directionRoot '01_landscape\key-literature.md') -Encoding UTF8 -Value "# Key literature`r`n`r`nDo not add unchecked citations.`r`n"
Set-Content -LiteralPath (Join-Path $directionRoot '01_landscape\competing-ideas.md') -Encoding UTF8 -Value "# Competing ideas`r`n`r`n"
Set-Content -LiteralPath (Join-Path $directionRoot '02_feasibility\data-availability.md') -Encoding UTF8 -Value "# Data availability`r`n`r`n"
Set-Content -LiteralPath (Join-Path $directionRoot '02_feasibility\method-feasibility.md') -Encoding UTF8 -Value "# Method feasibility`r`n`r`n"
Set-Content -LiteralPath (Join-Path $directionRoot '02_feasibility\ethics-risk.md') -Encoding UTF8 -Value "# Ethics and governance risk`r`n`r`n"
Set-Content -LiteralPath (Join-Path $directionRoot '02_feasibility\journal-fit.md') -Encoding UTF8 -Value "# Journal fit`r`n`r`n"
Set-Content -LiteralPath (Join-Path $directionRoot '03_idea-bank\candidate-questions.md') -Encoding UTF8 -Value "# Candidate questions`r`n`r`n"
Set-Content -LiteralPath (Join-Path $directionRoot '03_idea-bank\hypothesis-options.md') -Encoding UTF8 -Value "# Hypothesis/options`r`n`r`n"
Set-Content -LiteralPath (Join-Path $directionRoot '03_idea-bank\paperable-units.md') -Encoding UTF8 -Value "# Paperable units`r`n`r`n"
Set-Content -LiteralPath (Join-Path $directionRoot '04_decisions\approval-log-links.md') -Encoding UTF8 -Value "# Approval log links`r`n`r`n| ID | Date | Decision | Status | Path |`r`n|---|---|---|---|---|`r`n"
Set-Content -LiteralPath (Join-Path $directionRoot 'tmp\README.md') -Encoding UTF8 -Value "# Temporary files`r`n`r`nFiles here may be deleted by cleanup routines.`r`n"

Write-Output "Research direction created: $directionId"
Write-Output $directionRoot
