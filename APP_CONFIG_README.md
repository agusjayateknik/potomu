# FOTOMU App Configuration & Build Setup

## 📱 App Information
- **Package Name**: `com.sighdev.fotomu.app`
- **App Name**: FOTOMU
- **Version**: 1.0.0
- **Platform**: Capacitor (Web → Mobile)

## 🎨 Icons Configuration

### Web/PWA Icons
- Favicon: 16x16, 32x32
- Apple Touch Icon: 180x180
- PWA Icons: 192x192, 512x512
- Source: Photographic camera icon from Unsplash

### Android Icons (Resources)
Located in `resources/android/`:
- mipmap-mdpi: 48x48 (ic_launcher.png)
- mipmap-hdpi: 72x72 (ic_launcher.png)
- mipmap-xhdpi: 96x96 (ic_launcher.png)
- mipmap-xxhdpi: 144x144 (ic_launcher.png)
- mipmap-xxxhdpi: 192x192 (ic_launcher.png)
- playstore-icon.png: 512x512

## 🔐 Keystore Configuration

### Keystore Details
- **File**: `keystore/fotomu.keystore`
- **Password**: `Fotomu2024!`
- **Key Alias**: `fotomu_key`
- **Key Password**: `Fotomu2024!`

### Security Notes
- For production, use a strong unique password
- Never commit keystore files to version control
- Store keystore.properties securely
- Use different keystores for debug/release

## 🏗️ Build Instructions

### Prerequisites
1. Node.js & npm
2. Capacitor CLI: `npm install -g @capacitor/cli`
3. Android Studio (for Android builds)
4. Java JDK 11+

### Build Steps
1. Install dependencies: `npm install`
2. Add platforms: `npx cap add android` & `npx cap add ios`
3. Copy resources: `npx cap copy`
4. Generate keystore (if needed): Run `generate_keystore.ps1`
5. Build web assets: `npm run build` (if using build process)
6. Sync: `npx cap sync`
7. Open in IDE: `npx cap open android`

### Android Build
```bash
# Debug build
npx cap build android

# Release build (signed)
npx cap build android --prod
```

## 📋 File Structure
```
Fotomu/
├── Fotomu.html          # Main web app
├── manifest.json        # PWA manifest
├── backend/
│   ├── capacitor.config.ts
│   ├── keystore.properties
│   ├── android-build.gradle
│   └── generate_keystore.ps1
├── resources/
│   ├── icon/            # Web icons
│   ├── android/         # Android icons
│   └── ios/             # iOS icons
└── keystore/            # Signing keys
```

## 🔧 Configuration Files

### capacitor.config.ts
- App ID: com.sighdev.fotomu.app
- Web directory: ../
- Splash screen configuration

### keystore.properties
- Keystore file path and passwords
- Used by Android build process

### android-build.gradle
- Build configuration template
- Signing configs for release builds

## 🚀 Deployment

### Google Play Store
1. Build release APK/AAB
2. Sign with keystore
3. Upload to Play Console
4. Use 512x512 icon for store listing

### TestFlight (iOS)
1. Build for iOS
2. Archive in Xcode
3. Upload to App Store Connect
4. Configure TestFlight

## ⚠️ Important Notes

- Keep keystore passwords secure
- Use different keystores for different environments
- Update version codes for each release
- Test on multiple devices/screen sizes
- Validate icons display correctly on all platforms