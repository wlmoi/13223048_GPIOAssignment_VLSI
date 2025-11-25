<#
Run tests for the PYNQ GPIO project in simulate mode.

This script will:
- Verify `python` is available in PATH.
- Install `pytest` for the current user if missing.
- Run the simulate unit test `tests/test_gpio_test.py`.

Usage (PowerShell):
    .\run_tests.ps1

Notes:
- If `python` is not on PATH, install Python and enable the 'App execution aliases' or add its install location to PATH.
#>

Write-Host "Running tests for PYNQ GPIO project (simulate mode)"

function Exit-WithMessage($msg, $code=1) {
    Write-Host $msg -ForegroundColor Red
    exit $code
}

# Check python availability
$py = Get-Command python -ErrorAction SilentlyContinue
if (-not $py) {
    Exit-WithMessage "Python was not found in PATH. Please install Python 3 and retry."
}

Write-Host "Python found: $($py.Path)"

# Install pytest for current user
Write-Host "Installing pytest for current user (if missing)..."
& python -m pip install --user pytest | Out-Null
if ($LASTEXITCODE -ne 0) {
    Exit-WithMessage "Failed to install pytest. Please run: python -m pip install --user pytest"
}

Write-Host "Running pytest (simulate test)..."
pushd $PSScriptRoot
& pytest -q tests/test_gpio_test.py
$rc = $LASTEXITCODE
popd

if ($rc -eq 0) {
    Write-Host "All tests passed." -ForegroundColor Green
} else {
    Write-Host "Some tests failed (exit code $rc)." -ForegroundColor Yellow
}

exit $rc
