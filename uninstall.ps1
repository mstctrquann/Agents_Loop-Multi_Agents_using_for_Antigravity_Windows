<#
.SYNOPSIS
    Gỡ bỏ cài đặt Antigravity Multi-Agent Loop trên Windows.
#>

$UserHome = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::UserProfile)
$GlobalAgentsDir = Join-Path $UserHome ".gemini\agents"
$PluginsRulesDir = Join-Path $UserHome ".gemini\config\plugins\agent-skills\rules"
$ConfigTargetDir = Join-Path $UserHome ".gemini\config\agent-loop"

Write-Host "Đang gỡ bỏ Multi-Agent Loop..." -ForegroundColor Yellow

@("code-worker.json", "architect-reviewer.json", "architect-lead.json") | ForEach-Object {
    $f = Join-Path $GlobalAgentsDir $_
    if (Test-Path $f) { Remove-Item $f -Force; Write-Host "Đã xóa: $_" -ForegroundColor Gray }
}

$workflow = Join-Path $PluginsRulesDir "workflow.md"
if (Test-Path $workflow) { Remove-Item $workflow -Force; Write-Host "Đã xóa: workflow.md" -ForegroundColor Gray }

$agentsMd = Join-Path $UserHome "AGENTS.md"
if (Test-Path $agentsMd) { Remove-Item $agentsMd -Force; Write-Host "Đã xóa: AGENTS.md" -ForegroundColor Gray }

if (Test-Path $ConfigTargetDir) {
    Remove-Item $ConfigTargetDir -Recurse -Force
    Write-Host "Đã xóa cấu hình model tiers." -ForegroundColor Gray
}

Write-Host "Đã gỡ cài đặt hoàn tất!" -ForegroundColor Green
