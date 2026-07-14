param([switch]$Apply)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$root = Split-Path -Parent $PSScriptRoot
$targetPath = Join-Path $root 'knowledge\validated\techniques.csv'
$manualPath = Join-Path $root 'knowledge\inbox\manual-techniques.csv'
$sources = @($manualPath)
$sources += @(Get-ChildItem -Path (Join-Path $root 'papers') -Filter 'lessons.csv' -File -Recurse -ErrorAction SilentlyContinue | ForEach-Object FullName)

$existing = @()
if (Test-Path -LiteralPath $targetPath) {
    $existing = @(Import-Csv -Encoding UTF8 -LiteralPath $targetPath)
}
$knownIds = @{}
foreach ($row in $existing) {
    if ($row.id) { $knownIds[$row.id.Trim().ToLowerInvariant()] = $true }
}

$required = @('id','title','technique','scope','evidence','approved_by','date')
$accepted = @()
$rejected = @()

foreach ($source in ($sources | Sort-Object -Unique)) {
    if (-not (Test-Path -LiteralPath $source)) { continue }
    foreach ($row in @(Import-Csv -Encoding UTF8 -LiteralPath $source)) {
        if (-not $row.id) { continue }
        $eligible = ($row.status.Trim().ToLowerInvariant() -eq 'validated') -and
                    ($row.reusable.Trim().ToLowerInvariant() -eq 'yes') -and
                    ($row.approved.Trim().ToLowerInvariant() -eq 'yes')
        if (-not $eligible) { continue }

        $missing = @($required | Where-Object { -not $row.$_ -or [string]::IsNullOrWhiteSpace($row.$_) })
        $key = $row.id.Trim().ToLowerInvariant()
        if ($missing.Count -gt 0) {
            $rejected += "$($row.id): missing $($missing -join ', ')"
        } elseif ($knownIds.ContainsKey($key)) {
            $rejected += "$($row.id): ID already exists; existing knowledge was not overwritten"
        } else {
            $accepted += $row
            $knownIds[$key] = $true
        }
    }
}

foreach ($message in $rejected) { Write-Warning $message }

if ($accepted.Count -eq 0) {
    Write-Output 'No new knowledge entries meet the promotion criteria.'
    exit 0
}

Write-Output "Found $($accepted.Count) promotable knowledge entries:"
$accepted | ForEach-Object { Write-Output ("- {0}: {1}" -f $_.id, $_.title) }

if ($Apply) {
    @($existing + $accepted) | Export-Csv -LiteralPath $targetPath -NoTypeInformation -Encoding UTF8
    Write-Output "Updated: $targetPath"
} else {
    Write-Output 'Dry run only. Re-run with -Apply after review.'
}
