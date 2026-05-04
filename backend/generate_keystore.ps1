# Generate Android Keystore for FOTOMU App
# Run this script to create the signing keystore

$keystorePath = "..\keystore\fotomu.keystore"
$storePassword = "Fotomu2024!"
$keyAlias = "fotomu_key"
$keyPassword = "Fotomu2024!"

# Check if keystore already exists
if (Test-Path $keystorePath) {
    Write-Host "Keystore already exists at $keystorePath"
    Write-Host "To regenerate, delete the existing keystore first"
    exit
}

# Generate keystore using keytool
$keytoolCmd = "keytool -genkeypair -v -keystore $keystorePath -storepass $storePassword -keypass $keyPassword -alias $keyAlias -keyalg RSA -keysize 2048 -validity 10000 -dname 'CN=FOTOMU App, OU=Development, O=SighDev, L=Jakarta, ST=DKI Jakarta, C=ID'"

try {
    Invoke-Expression $keytoolCmd
    Write-Host "Keystore generated successfully at $keystorePath"
    Write-Host "Store Password: $storePassword"
    Write-Host "Key Alias: $keyAlias"
    Write-Host "Key Password: $keyPassword"
} catch {
    Write-Host "Failed to generate keystore: $_"
    Write-Host "Make sure Java JDK is installed and keytool is in PATH"
}