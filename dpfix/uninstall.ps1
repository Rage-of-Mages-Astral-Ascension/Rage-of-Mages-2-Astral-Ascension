# Restores the original smackw32.dll. Usage: powershell -ExecutionPolicy Bypass -File uninstall.ps1 -GameDir "D:\Games\Rage of Mages II"
param([Parameter(Mandatory)][string]$GameDir)

$ErrorActionPreference = 'Stop'
if (Get-Process allods2 -ErrorAction SilentlyContinue) { throw "Close Rage of Mages 2 (allods2.exe) first." }
$target = Join-Path $GameDir 'smackw32.dll'
$real   = Join-Path $GameDir 'smackw32_real.dll'
if (-not (Test-Path $real)) { throw "smackw32_real.dll not found; nothing to restore." }
Remove-Item $target -Force -ErrorAction SilentlyContinue
Move-Item $real $target
Remove-Item (Join-Path $GameDir 'dpfix.ini') -Force -ErrorAction SilentlyContinue
Write-Host "Original smackw32.dll restored."
