# FOTOMU APK Build Script
# Complete build process for Android APK generation

param(
    [string]$BuildType = "debug",
    [switch]$Clean,
    [switch]$Help
)

if ($Help) {
    Write-Host "FOTOMU APK Build Script"
    Write-Host "Usage: .\build_apk.ps1 [-BuildType debug|release] [-Clean] [-Help]"
    Write-Host ""
    Write-Host "Parameters:"
    Write-Host "  -BuildType: Build type (debug/release). Default: debug"
    Write-Host "  -Clean: Clean build artifacts before building"
    Write-Host "  -Help: Show this help message"
    exit
}

Write-Host "🚀 Building FOTOMU APK ($BuildType)"

# Check prerequisites
Write-Host "📋 Checking prerequisites..."
$javaAvailable = $false
try {
    $javaVersion = & java -version 2>&1 | Select-String "version"
    if ($javaVersion) {
        Write-Host "✅ Java found: $javaVersion"
        $javaAvailable = $true
    }
} catch {
    Write-Host "❌ Java JDK not found. Please install Java JDK 11+"
    Write-Host "   Download: https://adoptium.net/temurin/releases/"
    exit 1
}

# Check keystore
$keystorePath = "..\keystore\fotomu.keystore"
if (!(Test-Path $keystorePath)) {
    Write-Host "⚠️ Keystore not found. Generating keystore..."
    Push-Location "..\backend"
    try {
        & ".\generate_keystore.ps1"
        if ($LASTEXITCODE -ne 0) {
            Write-Host "❌ Failed to generate keystore"
            exit 1
        }
    } finally {
        Pop-Location
    }
} else {
    Write-Host "✅ Keystore found at $keystorePath"
}

# Clean if requested
if ($Clean) {
    Write-Host "🧹 Cleaning previous builds..."
    if (Test-Path "app\build") {
        Remove-Item "app\build" -Recurse -Force
    }
    if (Test-Path ".gradle") {
        Remove-Item ".gradle" -Recurse -Force
    }
}

# Copy web assets
Write-Host "📋 Copying web assets..."
$webAssetsDir = "app\src\main\assets\public"
if (!(Test-Path $webAssetsDir)) {
    New-Item -ItemType Directory -Path $webAssetsDir -Force
}

# Copy main HTML file and assets
Copy-Item "..\Fotomu.html" "$webAssetsDir\index.html" -Force
Copy-Item "..\manifest.json" "$webAssetsDir\" -Force

# Copy icons
Write-Host "🎨 Copying icons..."
try {
    & ".\copy_icons.ps1" 2>$null
} catch {
    Write-Host "⚠️ Icon copying completed with warnings"
}

# Build APK
Write-Host "🏗️ Building APK..."
$buildSuccess = $false

# Method 1: Try gradlew (if wrapper exists)
if (Test-Path "gradlew.bat" -and (Test-Path "gradle\wrapper\gradle-wrapper.jar")) {
    Write-Host "📦 Using Gradle wrapper..."
    if ($BuildType -eq "release") {
        $gradleCmd = ".\gradlew.bat assembleRelease"
        $outputPath = "app\build\outputs\apk\release\app-release.apk"
    } else {
        $gradleCmd = ".\gradlew.bat assembleDebug"
        $outputPath = "app\build\outputs\apk\debug\app-debug.apk"
    }

    try {
        Invoke-Expression $gradleCmd
        if ($LASTEXITCODE -eq 0 -and (Test-Path $outputPath)) {
            $buildSuccess = $true
        }
    } catch {
        Write-Host "⚠️ Gradle wrapper failed, trying alternative method..."
    }
} else {
    Write-Host "⚠️ Gradle wrapper not available, trying direct gradle..."
}

# Method 2: Try direct gradle command
if (!$buildSuccess) {
    Write-Host "📦 Trying direct Gradle build..."
    try {
        # Check if gradle is available
        $gradleAvailable = Get-Command gradle -ErrorAction SilentlyContinue
        if ($gradleAvailable) {
            if ($BuildType -eq "release") {
                $gradleCmd = "gradle assembleRelease"
                $outputPath = "app\build\outputs\apk\release\app-release.apk"
            } else {
                $gradleCmd = "gradle assembleDebug"
                $outputPath = "app\build\outputs\apk\debug\app-debug.apk"
            }

            Invoke-Expression $gradleCmd
            if ($LASTEXITCODE -eq 0 -and (Test-Path $outputPath)) {
                $buildSuccess = $true
            }
        } else {
            Write-Host "❌ Gradle not found in PATH"
            Write-Host "   Please install Gradle or Android Studio"
            Write-Host "   Alternative: Use Android Studio to open this project"
        }
    } catch {
        Write-Host "⚠️ Direct Gradle also failed: $_"
    }
}

# Method 3: Provide manual instructions
if (!$buildSuccess) {
    Write-Host ""
    Write-Host "🔧 Manual Build Instructions:"
    Write-Host "  1. Install Android Studio: https://developer.android.com/studio"
    Write-Host "  2. Open Android Studio"
    Write-Host "  3. File → Open → Select this 'android' folder"
    Write-Host "  4. Wait for Gradle sync to complete"
    Write-Host "  5. Build → Make Project (or Build APK)"
    Write-Host "  6. Locate APK in app/build/outputs/apk/"
    Write-Host ""
    Write-Host "📋 Prerequisites for manual build:"
    Write-Host "  - Android Studio Arctic Fox or later"
    Write-Host "  - Android SDK API 34"
    Write-Host "  - Build Tools 34.0.0+"
    exit 1
}

Write-Host ""
Write-Host "🎉 FOTOMU APK build completed!"
Write-Host ""
Write-Host "📋 Next steps:"
if ($BuildType -eq "release") {
    Write-Host "  1. Test the APK on devices"
    Write-Host "  2. Upload to Google Play Console"
    Write-Host "  3. Configure store listing with playstore-icon.png"
} else {
    Write-Host "  1. Install APK on test device: adb install $outputPath"
    Write-Host "  2. Test all features thoroughly"
    Write-Host "  3. Run release build when ready"
}