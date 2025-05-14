@echo off
echo [TT2 SETUP] Creating virtual environment with Python 3.10...
py -3.10 -m venv .venv

if errorlevel 1 (
    echo ❌ Python 3.10 is not installed or not registered with the launcher.
    echo Please install Python 3.10 from: https://www.python.org/downloads/release/python-3100/
    pause
    exit /b
)

echo [TT2 SETUP] Activating...
call .venv\Scripts\activate

echo [TT2 SETUP] Installing dependencies...
pip install --upgrade pip setuptools wheel
pip install -r requirements.txt

echo.
echo ✅ TT2 environment is ready.
echo Press any key to close this window...
pause > nul
