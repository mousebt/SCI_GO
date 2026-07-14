param(
    [Parameter(Mandatory = $true)][string]$Name,
    [Parameter(Mandatory = $true)][string]$Slug,
    [string]$Publisher = '',
    [string]$OfficialAuthorUrl = '',
    [string]$OfficialApcUrl = ''
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

if ($Slug -notmatch '^[a-z0-9]+(?:-[a-z0-9]+)*$') {
    throw 'Slug must contain lowercase letters, digits, and single hyphens only.'
}

$root = Split-Path -Parent $PSScriptRoot
$journals = Join-Path $root 'journals'
$profiles = Join-Path $journals 'profiles'
$requirements = Join-Path $journals 'requirements'
$rawDir = Join-Path $journals "raw_pages\$Slug"

New-Item -ItemType Directory -Force -Path $profiles, $requirements, $rawDir | Out-Null

$profilePath = Join-Path $profiles "$Slug.md"
$requirementPath = Join-Path $requirements "$Slug.md"

if (-not (Test-Path -LiteralPath $profilePath)) {
    $content = Get-Content -Raw -Encoding UTF8 -LiteralPath (Join-Path $profiles '_template.md')
    $content = $content.Replace('<Journal name>', $Name).Replace('<journal-slug>', $Slug)
    Set-Content -LiteralPath $profilePath -Value $content -Encoding UTF8
}

if (-not (Test-Path -LiteralPath $requirementPath)) {
    $content = Get-Content -Raw -Encoding UTF8 -LiteralPath (Join-Path $requirements '_template.md')
    $content = $content.Replace('<Journal name>', $Name).Replace('<journal-slug>', $Slug)
    Set-Content -LiteralPath $requirementPath -Value $content -Encoding UTF8
}

$indexPath = Join-Path $journals 'journal-index.csv'
$rows = @(Import-Csv -Encoding UTF8 -LiteralPath $indexPath)
if (-not ($rows | Where-Object { $_.slug -eq $Slug })) {
    $rows += [pscustomobject]@{
        slug = $Slug
        journal_name = $Name
        issn = ''
        eissn = ''
        publisher = $Publisher
        field_scope = ''
        sci_status = 'to verify'
        jif_year = ''
        jif = ''
        apc_amount = ''
        apc_currency = ''
        publication_model = ''
        subscription_no_fee = ''
        official_author_url = $OfficialAuthorUrl
        official_apc_url = $OfficialApcUrl
        raw_pages_dir = "journals/raw_pages/$Slug"
        requirements_doc = "journals/requirements/$Slug.md"
        difficulty_score_1_easy_5_hard = ''
        acceptance_rate = ''
        fit_notes = ''
        last_checked = (Get-Date -Format 'yyyy-MM-dd')
        next_review = (Get-Date).AddMonths(3).ToString('yyyy-MM-dd')
        status = 'draft'
    }
    $rows | Export-Csv -LiteralPath $indexPath -NoTypeInformation -Encoding UTF8
}

Write-Output "Journal entry ready: journals/profiles/$Slug.md"
Write-Output "Requirements file ready: journals/requirements/$Slug.md"
Write-Output "Raw page directory ready: journals/raw_pages/$Slug"

