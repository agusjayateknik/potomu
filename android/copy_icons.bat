@echo off
echo 🎨 Copying FOTOMU Icons to Android Project

set "sourceDir=..\resources\android"
set "androidResDir=app\src\main\res"

REM Create directories if they don't exist
if not exist "%androidResDir%\mipmap-mdpi" mkdir "%androidResDir%\mipmap-mdpi" 2>nul
if not exist "%androidResDir%\mipmap-hdpi" mkdir "%androidResDir%\mipmap-hdpi" 2>nul
if not exist "%androidResDir%\mipmap-xhdpi" mkdir "%androidResDir%\mipmap-xhdpi" 2>nul
if not exist "%androidResDir%\mipmap-xxhdpi" mkdir "%androidResDir%\mipmap-xxhdpi" 2>nul
if not exist "%androidResDir%\mipmap-xxxhdpi" mkdir "%androidResDir%\mipmap-xxxhdpi" 2>nul

REM Copy icons (using placeholder files for now)
if exist "%sourceDir%\mipmap-mdpi\ic_launcher.txt" (
    copy "%sourceDir%\mipmap-mdpi\ic_launcher.txt" "%androidResDir%\mipmap-mdpi\ic_launcher.png" >nul 2>&1
    echo ✅ Copied mdpi icon
)
if exist "%sourceDir%\mipmap-hdpi\ic_launcher.txt" (
    copy "%sourceDir%\mipmap-hdpi\ic_launcher.txt" "%androidResDir%\mipmap-hdpi\ic_launcher.png" >nul 2>&1
    echo ✅ Copied hdpi icon
)
if exist "%sourceDir%\mipmap-xhdpi\ic_launcher.txt" (
    copy "%sourceDir%\mipmap-xhdpi\ic_launcher.txt" "%androidResDir%\mipmap-xhdpi\ic_launcher.png" >nul 2>&1
    echo ✅ Copied xhdpi icon
)
if exist "%sourceDir%\mipmap-xxhdpi\ic_launcher.txt" (
    copy "%sourceDir%\mipmap-xxhdpi\ic_launcher.txt" "%androidResDir%\mipmap-xxhdpi\ic_launcher.png" >nul 2>&1
    echo ✅ Copied xxhdpi icon
)
if exist "%sourceDir%\mipmap-xxxhdpi\ic_launcher.txt" (
    copy "%sourceDir%\mipmap-xxxhdpi\ic_launcher.txt" "%androidResDir%\mipmap-xxxhdpi\ic_launcher.png" >nul 2>&1
    echo ✅ Copied xxxhdpi icon
)

echo 🎨 Icon copying completed!
echo 📝 Note: Replace .txt files with actual PNG icons for production