[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$agentsDir = Join-Path $projectRoot '.agents'
$skillsTargetDir = Join-Path $agentsDir 'skills'

if (!(Test-Path $skillsTargetDir)) {
    New-Item -ItemType Directory -Force -Path $skillsTargetDir | Out-Null
    Write-Host "[OK] Created directory: $skillsTargetDir"
}

# 1. Link project-specific skills (skills/*)
$projectSkillsDir = Join-Path $projectRoot 'skills'
if (Test-Path $projectSkillsDir) {
    $projectSkills = Get-ChildItem -Path $projectSkillsDir -Directory
    foreach ($item in $projectSkills) {
        $destPath = Join-Path $skillsTargetDir $item.Name
        if (Test-Path $destPath) {
            Remove-Item -Force -Recurse $destPath
        }
        New-Item -ItemType Junction -Path $destPath -Target $item.FullName | Out-Null
        Write-Host "[Link] Project skill: $($item.Name) -> $($item.FullName)"
    }
}

# 2. Link global Nature skills from ~/.codex/skills/
$codexSkillsDir = Join-Path $env:USERPROFILE '.codex\skills'
if (Test-Path $codexSkillsDir) {
    $natureSkills = Get-ChildItem -Path $codexSkillsDir -Directory | Where-Object { $_.Name -like 'nature-*' }
    foreach ($item in $natureSkills) {
        $destPath = Join-Path $skillsTargetDir $item.Name
        if (Test-Path $destPath) {
            Remove-Item -Force -Recurse $destPath
        }
        New-Item -ItemType Junction -Path $destPath -Target $item.FullName | Out-Null
        Write-Host "[Link] Nature skill: $($item.Name) -> $($item.FullName)"
    }
}

# 3. Create .agents/mcp_config.json
$mcpConfigFile = Join-Path $agentsDir 'mcp_config.json'
$mcpContent = @{
    mcpServers = @{
        academic_search = @{
            command = "E:\pythonProjects\SCI_GO\.codex\mcp\academic-search\.venv\Scripts\python.exe"
            args = @("academic_search_server.py")
            cwd = "C:\Users\XuJianhao\.codex\skills\nature-academic-search\mcp-server"
            env = @{
                PUBMED_EMAIL = "cxujianhao@gmail.com"
            }
        }
    }
} | ConvertTo-Json -Depth 5

Set-Content -Path $mcpConfigFile -Value $mcpContent -Encoding utf8
Write-Host "[OK] Created MCP configuration: $mcpConfigFile"

Write-Host "`nAntigravity skills and MCP setup completed successfully!"
