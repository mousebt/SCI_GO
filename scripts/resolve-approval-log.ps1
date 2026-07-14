param(
    [Parameter(Mandatory = $true)][string]$Id,
    [Parameter(Mandatory = $true)][ValidateSet('approved','rejected','revised','withdrawn')][string]$Decision,
    [Parameter(Mandatory = $true)][string]$UserResponse,
    [Parameter(Mandatory = $true)][string]$Resolution,
    [string]$GitCommit = ''
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$root = Split-Path -Parent $PSScriptRoot
$indexPath = Join-Path $root 'logs\approval-index.csv'
$rows = @(Import-Csv -Encoding UTF8 -LiteralPath $indexPath)
$matches = @($rows | Where-Object { $_.id -eq $Id })
if ($matches.Count -ne 1) { throw "Expected exactly one approval log for ID: $Id" }

$row = $matches[0]
$logPath = Join-Path $root ($row.path -replace '/', '\')
if (-not (Test-Path -LiteralPath $logPath)) { throw "Approval log file not found: $logPath" }

$now = [DateTimeOffset]::Now.ToString('yyyy-MM-ddTHH:mm:sszzz')
$content = Get-Content -Raw -Encoding UTF8 -LiteralPath $logPath
$content = [regex]::Replace($content, '(?m)^updated_at:\s*.*$', "updated_at: `"$now`"")
$content = [regex]::Replace($content, '(?m)^status:\s*.*$', "status: $Decision")
if (-not [string]::IsNullOrWhiteSpace($GitCommit)) {
    $content = [regex]::Replace($content, '(?m)^git_commit:\s*.*$', "git_commit: `"$GitCommit`"")
}
$replacementCrLf = "<!-- APPROVAL_RESPONSE -->`r`n### User response (verbatim)`r`n`r`n$UserResponse`r`n`r`n### Decision and resolution`r`n`r`n- Decision: $Decision`r`n- Recorded at: $now`r`n- Resolution: $Resolution"
$replacementLf = "<!-- APPROVAL_RESPONSE -->`n### User response (verbatim)`n`n$UserResponse`n`n### Decision and resolution`n`n- Decision: $Decision`n- Recorded at: $now`n- Resolution: $Resolution"
$content = $content.Replace("<!-- APPROVAL_RESPONSE -->`r`nPending user response.", $replacementCrLf)
$content = $content.Replace("<!-- APPROVAL_RESPONSE -->`nPending user response.", $replacementLf)
Set-Content -LiteralPath $logPath -Value $content -Encoding UTF8

foreach ($item in $rows) {
    if ($item.id -eq $Id) {
        $item.updated_at = $now
        $item.status = $Decision
        $item.git_commit = $GitCommit
    }
}
$rows | Export-Csv -LiteralPath $indexPath -NoTypeInformation -Encoding UTF8

Write-Output "Approval log resolved: $Id -> $Decision"
