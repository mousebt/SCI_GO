param(
    [Parameter(Mandatory = $true)][string]$Title,
    [Parameter(Mandatory = $true)][string]$Context,
    [Parameter(Mandatory = $true)][string]$Facts,
    [Parameter(Mandatory = $true)][string]$Assumptions,
    [Parameter(Mandatory = $true)][string]$Options,
    [Parameter(Mandatory = $true)][string]$Proposal,
    [Parameter(Mandatory = $true)][string]$Impact,
    [Parameter(Mandatory = $true)][string]$ApprovalQuestion,
    [ValidateSet('global','paper')][string]$Scope = 'global',
    [string]$PaperId = '',
    [ValidateSet('low','medium','high')][string]$Risk = 'medium'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

if ($Scope -eq 'paper' -and [string]::IsNullOrWhiteSpace($PaperId)) {
    throw 'PaperId is required when Scope is paper.'
}

$root = Split-Path -Parent $PSScriptRoot
$now = [DateTimeOffset]::Now
$stamp = $now.ToString('yyyyMMdd-HHmmss')
$suffix = [Guid]::NewGuid().ToString('N').Substring(0, 6)
$id = "APR-$stamp-$suffix"
$createdAt = $now.ToString('yyyy-MM-ddTHH:mm:sszzz')
$folder = Join-Path $root ("logs\approvals\{0}\{1}" -f $now.ToString('yyyy'), $now.ToString('MM'))
New-Item -ItemType Directory -Force -Path $folder | Out-Null

$safeTitle = ($Title.ToLowerInvariant() -replace '[^a-z0-9]+','-').Trim('-')
if ([string]::IsNullOrWhiteSpace($safeTitle)) { $safeTitle = 'approval-plan' }
$relativePath = "logs/approvals/$($now.ToString('yyyy'))/$($now.ToString('MM'))/$id-$safeTitle.md"
$outputPath = Join-Path $root ($relativePath -replace '/', '\')
$templatePath = Join-Path $root 'templates\approval-plan.md'
$content = Get-Content -Raw -Encoding UTF8 -LiteralPath $templatePath

$replacements = @{
    '__ID__' = $id
    '__CREATED_AT__' = $createdAt
    '__SCOPE__' = $Scope
    '__PAPER_ID__' = $PaperId
    '__RISK__' = $Risk
    '__TITLE__' = $Title
    '__CONTEXT__' = $Context
    '__FACTS__' = $Facts
    '__ASSUMPTIONS__' = $Assumptions
    '__OPTIONS__' = $Options
    '__PROPOSAL__' = $Proposal
    '__IMPACT__' = $Impact
    '__APPROVAL_QUESTION__' = $ApprovalQuestion
}
foreach ($key in $replacements.Keys) {
    $content = $content.Replace($key, $replacements[$key])
}
Set-Content -LiteralPath $outputPath -Value $content -Encoding UTF8

$indexPath = Join-Path $root 'logs\approval-index.csv'
$rows = @(Import-Csv -Encoding UTF8 -LiteralPath $indexPath)
$rows += [pscustomobject]@{
    id = $id
    created_at = $createdAt
    updated_at = $createdAt
    scope = $Scope
    paper_id = $PaperId
    title = $Title
    risk = $Risk
    status = 'pending'
    path = $relativePath
    git_commit = ''
}
$rows | Export-Csv -LiteralPath $indexPath -NoTypeInformation -Encoding UTF8

if ($Scope -eq 'paper') {
    $linksPath = Join-Path $root "papers\$PaperId\00_admin\approval-log-links.md"
    if (Test-Path -LiteralPath $linksPath) {
        Add-Content -LiteralPath $linksPath -Encoding UTF8 -Value ("| {0} | {1} | {2} | pending | `{3}` |" -f $id, $now.ToString('yyyy-MM-dd'), $Title, $relativePath)
    }
}

Write-Output "Approval log created: $id"
Write-Output $outputPath
