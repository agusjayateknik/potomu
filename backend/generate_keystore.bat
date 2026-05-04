@echo off
echo 🔑 FOTOMU Keystore Generation Script
echo.

set KEYSTORE_PATH=..\keystore\fotomu.keystore
set STORE_PASSWORD=Fotomu2024!
set KEY_ALIAS=fotomu_key
set KEY_PASSWORD=Fotomu2024!

REM Create keystore directory if it doesn't exist
if not exist "..\keystore" mkdir "..\keystore"

REM Check if keystore already exists
if exist "%KEYSTORE_PATH%" (
    echo Keystore already exists at %KEYSTORE_PATH%
    echo To regenerate, delete the existing keystore first
    pause
    exit /b 0
)

echo Generating keystore...
keytool -genkeypair -v -keystore "%KEYSTORE_PATH%" -storepass %STORE_PASSWORD% -keypass %KEY_PASSWORD% -alias %KEY_ALIAS% -keyalg RSA -keysize 2048 -validity 10000 -dname "CN=FOTOMU App, OU=Development, O=SighDev, L=Jakarta, ST=DKI Jakarta, C=ID"

if %errorlevel% equ 0 (
    echo ✅ Keystore generated successfully at %KEYSTORE_PATH%
    echo Store Password: %STORE_PASSWORD%
    echo Key Alias: %KEY_ALIAS%
    echo Key Password: %KEY_PASSWORD%
) else (
    echo ❌ Failed to generate keystore
    echo Make sure Java JDK is installed and keytool is in PATH
    pause
    exit /b 1
)

echo.
pause