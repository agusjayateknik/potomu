@echo off
echo 🚀 FOTOMU APK Build Script (Batch Version)
echo.

echo 📋 Checking prerequisites...

java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Java JDK not found. Please install Java JDK 11+
    echo    Download: https://adoptium.net/temurin/releases/
    pause
    exit /b 1
)
echo ✅ Java found

if not exist "..\keystore\fotomu.keystore" (
    echo ⚠️ Keystore not found. Generating...
    cd ..\backend
    call generate_keystore.bat 2>nul
    if not exist "..\keystore\fotomu.keystore" (
        echo ❌ Failed to generate keystore
        cd ..\android
        pause
        exit /b 1
    )
    cd ..\android
)
echo ✅ Keystore ready

echo 📋 Copying web assets...
if not exist "app\src\main\assets\public" mkdir "app\src\main\assets\public" 2>nul
copy "..\Fotomu.html" "app\src\main\assets\public\index.html" >nul 2>&1
copy "..\manifest.json" "app\src\main\assets\public\" >nul 2>&1

echo 🎨 Copying icons...
call copy_icons.bat 2>nul

echo 🏗️ Building APK...

REM Try gradlew first
if exist "gradlew.bat" (
    echo 📦 Using Gradle wrapper...
    if "%1"=="release" (
        call gradlew.bat assembleRelease
        set "outputPath=app\build\outputs\apk\release\app-release.apk"
    ) else (
        call gradlew.bat assembleDebug
        set "outputPath=app\build\outputs\apk\debug\app-debug.apk"
    )
) else (
    REM Try direct gradle
    gradle --version >nul 2>&1
    if %errorlevel% equ 0 (
        echo 📦 Using direct Gradle...
        if "%1"=="release" (
            call gradle assembleRelease
            set "outputPath=app\build\outputs\apk\release\app-release.apk"
        ) else (
            call gradle assembleDebug
            set "outputPath=app\build\outputs\apk\debug\app-debug.apk"
        )
    ) else (
        goto manual_instructions
    )
)

REM Check if build succeeded
if exist "%outputPath%" (
    for %%A in ("%outputPath%") do set "apkSize=%%~zA"
    set /a "apkSize=%apkSize%/1048576"
    echo ✅ APK built successfully!
    echo 📱 APK Location: %outputPath%
    echo 📏 Size: %apkSize% MB
    if "%1"=="release" (
        echo 🔐 APK is signed and ready for distribution
        echo 📤 Ready to upload to Google Play Store
    )
    echo.
    echo 📋 Next steps:
    if "%1"=="release" (
        echo   1. Test the APK on devices
        echo   2. Upload to Google Play Console
        echo   3. Configure store listing
    ) else (
        echo   1. Install APK: adb install %outputPath%
        echo   2. Test all features
        echo   3. Run release build when ready
    )
) else (
    echo ❌ Build failed or APK not found
    goto manual_instructions
)

goto end

:manual_instructions
echo.
echo 🔧 Manual Build Required:
echo   1. Install Android Studio: https://developer.android.com/studio
echo   2. Open this 'android' folder in Android Studio
echo   3. Wait for Gradle sync
echo   4. Build → Make Project or Build APK
echo   5. Find APK in app/build/outputs/apk/
echo.
echo 📋 Prerequisites:
echo   - Android Studio Arctic Fox or later
echo   - Android SDK API 34
echo   - Build Tools 34.0.0+

:end
pause