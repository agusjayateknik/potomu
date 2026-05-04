@echo off
echo 🔍 FOTOMU APK Build Requirements Checker
echo.

set "all_good=1"

echo 📋 Checking Java...
java -version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Java JDK found
    java -version 2>&1 | findstr /r "version"
) else (
    echo ❌ Java JDK not found
    echo    Download: https://adoptium.net/temurin/releases/
    set "all_good=0"
)

echo.
echo 📋 Checking Android SDK...
if defined ANDROID_HOME (
    echo ✅ ANDROID_HOME set: %ANDROID_HOME%
    if exist "%ANDROID_HOME%\platform-tools\adb.exe" (
        echo ✅ Android SDK platform-tools found
    ) else (
        echo ⚠️ Android SDK platform-tools not found
        echo   Install via Android Studio SDK Manager
    )
) else (
    echo ❌ ANDROID_HOME not set
    echo    Set in environment variables or Android Studio
    set "all_good=0"
)

echo.
echo 📋 Checking Gradle...
gradle --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Gradle found
    gradle --version 2>&1 | findstr /r "Gradle"
) else (
    echo ⚠️ Gradle not found in PATH
    echo   Install via: https://gradle.org/install/
    echo   Or use Android Studio's built-in Gradle
)

echo.
echo 📋 Checking Keystore...
if exist "..\keystore\fotomu.keystore" (
    echo ✅ Keystore found
) else (
    echo ⚠️ Keystore not found
    echo   Will be generated automatically on first build
)

echo.
echo 📋 Checking Project Files...
if exist "app\build.gradle" (
    echo ✅ App build.gradle found
) else (
    echo ❌ App build.gradle missing
    set "all_good=0"
)

if exist "build.gradle" (
    echo ✅ Root build.gradle found
) else (
    echo ❌ Root build.gradle missing
    set "all_good=0"
)

if exist "app\src\main\AndroidManifest.xml" (
    echo ✅ AndroidManifest.xml found
) else (
    echo ❌ AndroidManifest.xml missing
    set "all_good=0"
)

echo.
if %all_good% equ 1 (
    echo 🎉 All requirements satisfied!
    echo 🚀 Ready to build APK
    echo.
    echo Run: .\build_apk.bat          (for debug APK)
    echo Run: .\build_apk.bat release  (for release APK)
) else (
    echo ⚠️ Some requirements not met
    echo 🔧 Please fix the issues above before building
)

echo.
pause