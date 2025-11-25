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

function Choose-PythonExecutable {
    # Allow overriding via environment variable
    if ($env:MINICONDA_PYTHON) {
        if (Test-Path $env:MINICONDA_PYTHON) { return $env:MINICONDA_PYTHON }
    }

    # Common user install locations
    $userProfile = [Environment]::GetFolderPath('UserProfile')
    $candidates = @(
        "$userProfile\Miniconda3\python.exe",
        "$userProfile\Anaconda3\python.exe",
        "$userProfile\AppData\Local\Programs\Python\Python39\python.exe",
        "$userProfile\AppData\Local\Programs\Python\Python310\python.exe"
    )

    foreach ($c in $candidates) {
        if (Test-Path $c) { return $c }
    }

    # Fall back to PATH 'python'
    $pyCmd = Get-Command python -ErrorAction SilentlyContinue
    if ($pyCmd) { return $pyCmd.Path }

    return $null
}

$pythonExe = Choose-PythonExecutable
if (-not $pythonExe) {
    Exit-WithMessage "No Python interpreter found. Install Python or set environment variable MINICONDA_PYTHON to your python.exe path."
}

Write-Host "Using Python executable: $pythonExe"

# Install pytest for current user
Write-Host "Ensuring pip is available and installing pytest for current user (if missing)..."
& "$pythonExe" -m ensurepip --upgrade | Out-Null
& "$pythonExe" -m pip install --upgrade pip setuptools wheel | Out-Null
& "$pythonExe" -m pip install --user pytest | Out-Null
if ($LASTEXITCODE -ne 0) {
    Exit-WithMessage "Failed to install pytest. Please run: `& $pythonExe -m pip install --user pytest`"
}

Write-Host "Running pytest (simulate test)..."
pushd $PSScriptRoot
& "$pythonExe" -m pytest -q tests/test_gpio_test.py
$rc = $LASTEXITCODE
popd

if ($rc -eq 0) {
    Write-Host "All tests passed." -ForegroundColor Green
} else {
    Write-Host "Some tests failed (exit code $rc)." -ForegroundColor Yellow
}

exit $rc
