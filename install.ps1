<#
.SYNOPSIS
    Installer for Antigravity Multi-Agent Refinement Loop on Windows.
.DESCRIPTION
    Tự động cài đặt Agents, Rules, và cấu hình Model Tiers cho môi trường Windows.
.PARAMETER Tier
    Tùy chọn gói model: auto (mặc định), starter, pro, frontier_elite
.PARAMETER Force
    Ghi đè cấu hình cũ không cần hỏi lại
#>

[CmdletBinding()]
param (
    [ValidateSet("auto", "starter", "pro", "frontier_elite")]
    [string]$Tier = "auto",
    [switch]$Force
)

$ErrorActionPreference = "Stop"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  ANTIGRAVITY MULTI-AGENT LOOP - WINDOWS INSTALLER        " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$CurrentDir = $PSScriptRoot
$UserHome = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::UserProfile)
$GeminiDir = Join-Path $UserHome ".gemini"
$GlobalAgentsDir = Join-Path $GeminiDir "agents"
$PluginsRulesDir = Join-Path $GeminiDir "config\plugins\agent-skills\rules"
$ConfigTargetDir = Join-Path $GeminiDir "config\agent-loop"

Write-Host "[1/5] Kiểm tra thư mục đích..." -ForegroundColor Yellow
@($GlobalAgentsDir, $PluginsRulesDir, $ConfigTargetDir) | ForEach-Object {
    if (-not (Test-Path $_)) {
        New-Item -ItemType Directory -Path $_ -Force | Out-Null
        Write-Host "  + Tạo mới thư mục: $_" -ForegroundColor Green
    }
}

# 1. Cài đặt Agents definition
Write-Host "`n[2/5] Cài đặt định nghĩa Subagents..." -ForegroundColor Yellow
$AgentFiles = Get-ChildItem -Path (Join-Path $CurrentDir "agents") -Filter "*.json"
foreach ($agent in $AgentFiles) {
    $targetPath = Join-Path $GlobalAgentsDir $agent.Name
    Copy-Item -Path $agent.FullName -Destination $targetPath -Force
    Write-Host "  -> Đã cập nhật subagent: $($agent.Name)" -ForegroundColor Green
}

# 2. Cài đặt Workflow Rules
Write-Host "`n[3/5] Cài đặt Quy tắc điều phối (Workflow Rules)..." -ForegroundColor Yellow
$WorkflowSrc = Join-Path $CurrentDir "rules\workflow.md"
$AgentsSrc = Join-Path $CurrentDir "rules\AGENTS.md"

if (Test-Path $WorkflowSrc) {
    Copy-Item -Path $WorkflowSrc -Destination (Join-Path $PluginsRulesDir "workflow.md") -Force
    Write-Host "  -> Đã cài đặt rules: workflow.md" -ForegroundColor Green
}

# Copy AGENTS.md ra thư mục User Home
Copy-Item -Path $AgentsSrc -Destination (Join-Path $UserHome "AGENTS.md") -Force
Write-Host "  -> Đã cài đặt rules: AGENTS.md tại $UserHome" -ForegroundColor Green

# 3. Cấu hình Model Tier
Write-Host "`n[4/5] Cấu hình Model Tier (Chế độ: $Tier)..." -ForegroundColor Yellow
$ModelConfigFile = Join-Path $CurrentDir "config\model_tiers.json"
$ConfigContent = Get-Content -Path $ModelConfigFile -Raw | ConvertFrom-Json
$ConfigContent.active_tier = $Tier

$TargetConfigFile = Join-Path $ConfigTargetDir "model_tiers.json"
$ConfigContent | ConvertTo-Json -Depth 5 | Set-Content -Path $TargetConfigFile -Encoding UTF8
Write-Host "  -> Đã lưu cấu hình tier tại: $TargetConfigFile" -ForegroundColor Green
Write-Host "     * Model cho Worker: $($ConfigContent.tiers.$Tier.worker_model)" -ForegroundColor DarkCyan
Write-Host "     * Model cho Reviewer: $($ConfigContent.tiers.$Tier.reviewer_model)" -ForegroundColor DarkCyan
Write-Host "     * Model cho Lead: $($ConfigContent.tiers.$Tier.lead_model)" -ForegroundColor DarkCyan

# 4. Xác minh hoàn tất
Write-Host "`n[5/5] Hoàn tất cài đặt thành công!" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "Hệ thống sẵn sàng. Bạn có thể gõ /goal để kích hoạt chu trình!" -ForegroundColor White
Write-Host "Để đổi gói cấu hình sau này, chạy:" -ForegroundColor Gray
Write-Host "  .\install.ps1 -Tier pro" -ForegroundColor Gray
Write-Host "  .\install.ps1 -Tier frontier_elite" -ForegroundColor Gray
Write-Host "==========================================================" -ForegroundColor Cyan
