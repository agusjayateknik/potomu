# FOTOMU Android APK Build Guide

## 📱 Overview
This directory contains the complete Android project setup for building FOTOMU APK files. The project is configured for both debug and release builds with proper signing.

## 🏗️ Project Structure
```
android/
├── app/
│   ├── build.gradle              # App-level build configuration
│   └── src/main/
│       ├── AndroidManifest.xml   # App manifest with permissions
│       ├── java/com/sighdev/fotomu/app/
│       │   └── MainActivity.java # Main Capacitor activity
│       └── res/
│           ├── mipmap-*/         # App icons for different densities
│           └── values/
│               ├── colors.xml    # App color scheme
│               ├── strings.xml   # App strings
│               └── styles.xml    # App themes
├── build.gradle                  # Top-level build configuration
├── settings.gradle               # Project settings
├── gradle.properties            # Gradle properties
├── build_apk.ps1                # APK build script
└── copy_icons.ps1               # Icon copying script
```

## 🔧 Prerequisites

### Required Software
1. **Java JDK 11+** - Download from [Oracle](https://www.oracle.com/java/)
2. **Android SDK** - Install via Android Studio or standalone
3. **Gradle** - Included via wrapper (no separate installation needed)

### Environment Variables
Set these environment variables:
```bash
JAVA_HOME=C:\Program Files\Java\jdk-11
ANDROID_HOME=C:\Users\%USERNAME%\AppData\Local\Android\Sdk
PATH=%PATH%;%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\tools
```

## 🚀 Building APK

### Quick Build (Recommended)
```powershell
# Navigate to android directory
cd android

# Run the automated build script
.\build_apk.ps1 -BuildType debug    # For testing
.\build_apk.ps1 -BuildType release  # For distribution
```

### Manual Build Steps
```bash
# 1. Copy web assets
# (Handled automatically by build script)

# 2. Copy icons
.\copy_icons.ps1

# 3. Build APK
.\gradlew assembleDebug   # Debug build
.\gradlew assembleRelease # Release build
```

## 📦 Build Outputs

### Debug APK
- **Location**: `app/build/outputs/apk/debug/app-debug.apk`
- **Signing**: Uses release keystore (for easier testing)
- **Purpose**: Development and testing

### Release APK
- **Location**: `app/build/outputs/apk/release/app-release.apk`
- **Signing**: Properly signed with keystore
- **Purpose**: Distribution to Google Play Store

## 🔐 Signing Configuration

### Keystore Details
- **Location**: `../../keystore/fotomu.keystore`
- **Password**: `Fotomu2024!`
- **Key Alias**: `fotomu_key`
- **Key Password**: `Fotomu2024!`

### Generating Keystore
If keystore doesn't exist, run:
```powershell
..\backend\generate_keystore.ps1
```

## 📱 App Configuration

### Package Information
- **Package Name**: `com.sighdev.fotomu.app`
- **App Name**: FOTOMU
- **Version**: 1.0.0 (versionCode: 1)
- **Min SDK**: API 21 (Android 5.0)
- **Target SDK**: API 34 (Android 14)

### Permissions
- `INTERNET` - Web connectivity
- `CAMERA` - Photo capture
- `WRITE_EXTERNAL_STORAGE` - File saving
- `READ_EXTERNAL_STORAGE` - File access
- `READ_MEDIA_IMAGES` - Media access (Android 13+)

## 🎨 Icons & Assets

### App Icons
Icons are automatically copied from `../resources/android/` to the appropriate mipmap directories.

### Splash Screen
- **Background**: `#2b0a0a` (Dark red)
- **Duration**: 2000ms
- **Auto-hide**: Enabled

## 🧪 Testing APK

### Install on Device
```bash
# Connect device via USB with USB debugging enabled
adb devices

# Install APK
adb install app/build/outputs/apk/debug/app-debug.apk
```

### Test Checklist
- [ ] App launches successfully
- [ ] Splash screen displays correctly
- [ ] Camera permissions work
- [ ] Face detection functions
- [ ] Photo upload works
- [ ] Gallery displays correctly
- [ ] Shopping cart functions
- [ ] Offline functionality

## 📤 Distribution

### Google Play Store
1. **Build Release APK**: `.\build_apk.ps1 -BuildType release`
2. **Test APK**: Install and test thoroughly
3. **Create Store Listing**:
   - Use `playstore-icon.png` (512x512)
   - Screenshots from device
   - Feature graphic (1024x500)
4. **Upload to Console**: Use `app-release.apk`
5. **Publish**: Set up pricing, countries, etc.

### Alternative Distribution
- **Direct APK sharing**: For beta testing
- **Third-party stores**: Amazon Appstore, etc.
- **Enterprise distribution**: For internal use

## 🔧 Troubleshooting

### Common Issues

#### Build Fails
```bash
# Clean and rebuild
.\build_apk.ps1 -Clean -BuildType debug
```

#### Keystore Issues
```bash
# Regenerate keystore
..\backend\generate_keystore.ps1
```

#### Permission Denied
- Ensure write access to project directory
- Run PowerShell as Administrator if needed

#### Gradle Issues
```bash
# Clear Gradle cache
Remove-Item ~/.gradle -Recurse -Force
.\build_apk.ps1 -Clean
```

### Debug Commands
```bash
# Check device connection
adb devices

# View device logs
adb logcat

# Uninstall app
adb uninstall com.sighdev.fotomu.app
```

## 📞 Support

For build issues:
1. Check this README
2. Verify prerequisites are installed
3. Run with `-Clean` flag
4. Check device compatibility
5. Review error logs

## 📋 Version History

- **v1.0.0**: Initial release
  - Face recognition features
  - Photo marketplace
  - Social features
  - PWA capabilities