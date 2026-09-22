# Installs the dpfix proxy into a Rage of Mages 2 game folder. Reversible with uninstall.ps1.
# Usage:  powershell -ExecutionPolicy Bypass -File install.ps1 -GameDir "D:\Games\Rage of Mages II"
param([Parameter(Mandatory)][string]$GameDir)

$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$exe  = Join-Path $GameDir 'allods2.exe'
if (-not (Test-Path $exe)) { throw "allods2.exe not found in $GameDir" }
if (Get-Process allods2 -ErrorAction SilentlyContinue) { throw "Close Rage of Mages 2 (allods2.exe) first." }

$target = Join-Path $GameDir 'smackw32.dll'
$real   = Join-Path $GameDir 'smackw32_real.dll'
$ours   = Join-Path $here 'smackw32.dll'
if (-not (Test-Path $ours)) { throw "smackw32.dll (the proxy) not found next to this script." }

if (-not (Test-Path $real)) {
    if (-not (Test-Path $target)) { throw "No original smackw32.dll in $GameDir to back up." }
    if ((Get-Item $target).Length -eq (Get-Item $ours).Length) { throw "The proxy already seems to be installed but smackw32_real.dll is missing. Aborting." }
    Move-Item $target $real
}
Copy-Item $ours $target -Force
$ini = Join-Path $GameDir 'dpfix.ini'
if (-not (Test-Path $ini)) { Copy-Item (Join-Path $here 'dpfix.ini') $ini }
Write-Host "Installed. Original kept as smackw32_real.dll. Edit dpfix.ini in the game folder if needed."
Write-Host "Log file after playing: $(Join-Path $GameDir 'dp_log.txt')"
