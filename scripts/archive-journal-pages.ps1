param(
    [Parameter(Mandatory = $true)][string]$Slug,
    [Parameter(Mandatory = $true)][string[]]$Urls,
    [string]$SourceLabel = 'official'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

if ($Slug -notmatch '^[a-z0-9]+(?:-[a-z0-9]+)*$') {
    throw 'Slug must contain lowercase letters, digits, and single hyphens only.'
}

$root = Split-Path -Parent $PSScriptRoot
$rawDir = Join-Path $root "journals\raw_pages\$Slug"
$logPath = Join-Path $root 'journals\official-source-log.csv'
$userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0 Safari/537.36'
New-Item -ItemType Directory -Force -Path $rawDir | Out-Null

$normalizedUrls = @()
foreach ($item in $Urls) {
    foreach ($url in ($item -split ',')) {
        $clean = $url.Trim()
        if (-not [string]::IsNullOrWhiteSpace($clean)) {
            $normalizedUrls += $clean
        }
    }
}

$rows = @(Import-Csv -Encoding UTF8 -LiteralPath $logPath)
$capturedAt = [DateTimeOffset]::Now.ToString('yyyy-MM-ddTHH:mm:sszzz')
$i = 0

foreach ($url in $normalizedUrls) {
    $i += 1
    $safe = ($url -replace '^https?://','' -replace '[^a-zA-Z0-9]+','-').Trim('-')
    if ($safe.Length -gt 80) { $safe = $safe.Substring(0, 80).Trim('-') }
    $fileName = '{0}_{1:D2}_{2}_{3}.html' -f (Get-Date -Format 'yyyyMMdd-HHmmss'), $i, $SourceLabel, $safe
    $outFile = Join-Path $rawDir $fileName
    $status = 'ok'
    $httpStatus = ''
    $notes = ''

    try {
        $response = Invoke-WebRequest -Uri $url -OutFile $outFile -MaximumRedirection 5 -Headers @{ 'User-Agent' = $userAgent } -PassThru
        $httpStatus = [string]$response.StatusCode
    }
    catch {
        $firstError = $_.Exception.Message
        $curl = Get-Command curl.exe -ErrorAction SilentlyContinue
        if ($curl) {
            $curlStatus = & $curl.Source -sS -L -A $userAgent --max-time 45 -w '%{http_code}' -o $outFile $url 2>$null
            if ($LASTEXITCODE -eq 0 -and (Test-Path -LiteralPath $outFile) -and ((Get-Item -LiteralPath $outFile).Length -gt 0)) {
                $httpStatus = [string]$curlStatus
                if ($httpStatus -match '^[23]\d\d$') {
                    $status = 'ok'
                    $notes = 'Captured with curl fallback after Invoke-WebRequest failed: ' + $firstError
                }
                else {
                    $status = 'blocked_http'
                    $notes = 'Raw HTTP response saved, but server returned non-success status after Invoke-WebRequest failed: ' + $firstError
                }
            }
            else {
                $status = 'failed'
                $notes = $firstError
                if (Test-Path -LiteralPath $outFile) {
                    Remove-Item -LiteralPath $outFile -Force
                }
                $outFile = ''
            }
        }
        else {
            $status = 'failed'
            $notes = $firstError
            if (Test-Path -LiteralPath $outFile) {
                Remove-Item -LiteralPath $outFile -Force
            }
            $outFile = ''
        }
    }

    $rows += [pscustomobject]@{
        captured_at = $capturedAt
        slug = $Slug
        source_label = $SourceLabel
        url = $url
        raw_file = if ($outFile) { ($outFile.Substring($root.Length + 1) -replace '\\','/') } else { '' }
        status = $status
        http_status = $httpStatus
        notes = $notes
    }
}

$rows | Export-Csv -LiteralPath $logPath -NoTypeInformation -Encoding UTF8
Write-Output "Archived source pages for $Slug. See journals/official-source-log.csv."
