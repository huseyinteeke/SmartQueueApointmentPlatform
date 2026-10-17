# One-time local setup: virtual environment, packages and .env
# Usage (PowerShell, in the project folder):  .\setup.ps1

Set-Location $PSScriptRoot

if (-not (Test-Path ".venv")) {
    Write-Host "Creating virtual environment (.venv)..." -ForegroundColor Cyan
    python -m venv .venv
    if ($LASTEXITCODE -ne 0) { Write-Host "Could not create .venv" -ForegroundColor Red; exit 1 }
}

$py = ".\.venv\Scripts\python.exe"

Write-Host "Upgrading pip..." -ForegroundColor Cyan
& $py -m pip install --upgrade pip --quiet
if ($LASTEXITCODE -ne 0) { Write-Host "pip upgrade failed" -ForegroundColor Red; exit 1 }

Write-Host "Installing requirements..." -ForegroundColor Cyan
& $py -m pip install -r requirements.txt --quiet
if ($LASTEXITCODE -ne 0) { Write-Host "pip install failed" -ForegroundColor Red; exit 1 }

if (-not (Test-Path ".env")) {
    Write-Host "Creating .env from .env.example..." -ForegroundColor Cyan
    $secret = (& $py -c "import secrets; print(secrets.token_hex(32))").Trim()
    $lines = Get-Content ".env.example" | ForEach-Object {
        if ($_ -like "SECRET_KEY=*") { "SECRET_KEY=$secret" } else { $_ }
    }
    [System.IO.File]::WriteAllLines((Join-Path $PSScriptRoot ".env"), $lines, (New-Object System.Text.UTF8Encoding($false)))
    Write-Host ".env created with a random SECRET_KEY" -ForegroundColor Green
} else {
    Write-Host ".env already exists, keeping it" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Setup finished. Next steps:" -ForegroundColor Green
Write-Host "  1. Create the database:  mysql -u root -p < sql/create_database.sql"
Write-Host "  2. Put the app user's password into .env as DB_PASSWORD"
Write-Host "  3. Activate the venv:    .\.venv\Scripts\Activate.ps1"
Write-Host "  4. Start the app:        flask run"
Write-Host "  5. Check the database:   http://127.0.0.1:5000/health"
