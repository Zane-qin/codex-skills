$ErrorActionPreference = "Continue"
$SkillDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$VenvPython = Join-Path $SkillDir ".venv\Scripts\python.exe"
$Checks = @()

function Add-Check($Name, $Ok, $Detail) {
    $script:Checks += [pscustomobject]@{
        Name = $Name
        Ok = [bool]$Ok
        Detail = $Detail
    }
}

Add-Check "Git" ([bool](Get-Command git -ErrorAction SilentlyContinue)) ((Get-Command git -ErrorAction SilentlyContinue).Source)
Add-Check "Bash" ([bool](Get-Command bash -ErrorAction SilentlyContinue)) ((Get-Command bash -ErrorAction SilentlyContinue).Source)
Add-Check "venv Python" (Test-Path -LiteralPath $VenvPython) $VenvPython

if (Test-Path -LiteralPath $VenvPython) {
    $importCheck = & $VenvPython -c "import playwright, yaml; from playwright_stealth import Stealth; print('ok')" 2>&1
    Add-Check "Python packages" ($LASTEXITCODE -eq 0 -and ($importCheck -join '') -match 'ok') ($importCheck -join "`n")

    $Chromium = Get-ChildItem -Recurse -Filter chrome.exe -ErrorAction SilentlyContinue "$env:LOCALAPPDATA\ms-playwright\chromium-*" | Select-Object -First 1
    if ($Chromium) {
        $browserCheck = & $VenvPython -c "from playwright.sync_api import sync_playwright; p=sync_playwright().start(); b=p.chromium.launch(headless=True, executable_path=r'$($Chromium.FullName)'); b.close(); p.stop(); print('ok')" 2>&1
    } else {
        $browserCheck = & $VenvPython -c "from playwright.sync_api import sync_playwright; p=sync_playwright().start(); b=p.chromium.launch(headless=True); b.close(); p.stop(); print('ok')" 2>&1
    }
    Add-Check "Playwright Chromium" ($LASTEXITCODE -eq 0 -and ($browserCheck -join '') -match 'ok') ($browserCheck -join "`n")
}

$Checks | Format-Table -AutoSize
if ($Checks.Ok -contains $false) {
    exit 1
}
