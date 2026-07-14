param(
    [Parameter(Mandatory = $true)][string]$Slug,
    [ValidateSet('accepted','closed')][string]$Status = 'closed'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$root = Split-Path -Parent $PSScriptRoot
$paperFile = Join-Path $root "papers\$Slug\paper.yaml"
if (-not (Test-Path -LiteralPath $paperFile)) { throw "Paper not found: $Slug" }

& (Join-Path $PSScriptRoot 'preflight.ps1') -Slug $Slug
$content = Get-Content -Raw -Encoding UTF8 -LiteralPath $paperFile
$content = [regex]::Replace($content, '(?m)^status:\s*.*$', "status: $Status")
Set-Content -LiteralPath $paperFile -Value $content -Encoding UTF8
& (Join-Path $PSScriptRoot 'sync-knowledge.ps1') -Apply

Write-Output "Paper $Slug is now $Status; eligible lessons were synchronized."
Write-Output 'Review the change log, then create a Git milestone commit and tag.'
