param(
    [Parameter(Mandatory = $true)][string]$Slug,
    [Parameter(Mandatory = $true)][string]$Url,
    [Parameter(Mandatory = $true)][string]$FilePath,
    [string]$SourceLabel = 'manual-official'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

if ($Slug -notmatch '^[a-z0-9]+(?:-[a-z0-9]+)*$') {
    throw 'Slug must contain lowercase letters, digits, and single hyphens only.'
}

$root = Split-Path -Parent $PSScriptRoot
$source = Resolve-Path -LiteralPath $FilePath
$rawDir = Join-Path $root "journals\raw_pages\$Slug"
$logPath = Join-Path $root 'journals\official-source-log.csv'
New-Item -ItemType Directory -Force -Path $rawDir | Out-Null

$extension = [IO.Path]::GetExtension($source.Path)
if ([string]::IsNullOrWhiteSpace($extension)) {
    $extension = '.html'
}

$safe = ($Url -replace '^https?://','' -replace '[^a-zA-Z0-9]+','-').Trim('-')
if ($safe.Length -gt 80) { $safe = $safe.Substring(0, 80).Trim('-') }

$fileName = '{0}_{1}_{2}{3}' -f (Get-Date -Format 'yyyyMMdd-HHmmss'), $SourceLabel, $safe, $extension
$destination = Join-Path $rawDir $fileName
Copy-Item -LiteralPath $source.Path -Destination $destination -Force

$rows = @(Import-Csv -Encoding UTF8 -LiteralPath $logPath)
$capturedAt = [DateTimeOffset]::Now.ToString('yyyy-MM-ddTHH:mm:sszzz')
$rows += [pscustomobject]@{
    captured_at = $capturedAt
    slug = $Slug
    source_label = $SourceLabel
    url = $Url
    raw_file = ($destination.Substring($root.Length + 1) -replace '\\','/')
    status = 'manual_ok'
    http_status = 'manual'
    notes = 'Official page manually saved through an interactive browser and imported into the journal library.'
}
$rows | Export-Csv -LiteralPath $logPath -NoTypeInformation -Encoding UTF8

Write-Output "Manual official page imported: $($destination.Substring($root.Length + 1) -replace '\\','/')"
