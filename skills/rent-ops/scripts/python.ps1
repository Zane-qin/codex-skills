$SkillDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$VenvPython = Join-Path $SkillDir ".venv\Scripts\python.exe"

if (Test-Path -LiteralPath $VenvPython) {
    & $VenvPython @args
    exit $LASTEXITCODE
}

Write-Error "rent-ops 环境未安装。请运行: python -m venv `"$SkillDir\.venv`" 后安装 requirements.txt"
exit 1
