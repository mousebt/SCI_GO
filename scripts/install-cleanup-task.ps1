param(
    [string]$TaskName = 'SCI_GO Weekly Cleanup',
    [string]$DayOfWeek = 'Sunday',
    [string]$At = '03:00'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$cleanup = Join-Path $PSScriptRoot 'cleanup.ps1'
$argument = "-NoProfile -ExecutionPolicy Bypass -File `"$cleanup`" -Apply"
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument $argument
$trigger = New-ScheduledTaskTrigger -Weekly -WeeksInterval 1 -DaysOfWeek $DayOfWeek -At $At
$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable

Register-ScheduledTask -TaskName $TaskName -Action $action -Trigger $trigger -Settings $settings -Description 'Delete expired temporary files in SCI_GO paper workspaces.' -Force | Out-Null
Write-Output "Registered weekly cleanup task: $TaskName ($DayOfWeek $At)"
