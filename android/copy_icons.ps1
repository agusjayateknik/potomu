# Copy FOTOMU Icons to Android Project
# This script copies the app icons to the correct Android resource directories

$sourceDir = "..\resources\android"
$androidResDir = "app\src\main\res"

# Icon sizes mapping
$iconSizes = @(
    @{Name="mipmap-mdpi"; Size=48},
    @{Name="mipmap-hdpi"; Size=72},
    @{Name="mipmap-xhdpi"; Size=96},
    @{Name="mipmap-xxhdpi"; Size=144},
    @{Name="mipmap-xxxhdpi"; Size=192}
)

Write-Host "Copying FOTOMU icons to Android project..."

foreach ($size in $iconSizes) {
    $folder = $size.Name
    $sourcePath = "$sourceDir\$folder\ic_launcher.txt"
    $destPath = "$androidResDir\$folder\ic_launcher.png"

    if (Test-Path $sourcePath) {
        # For now, create a placeholder. In production, replace with actual PNG
        Copy-Item $sourcePath $destPath -Force
        Write-Host "Copied $folder icon"
    } else {
        Write-Host "Warning: $sourcePath not found"
    }
}

# Copy playstore icon if exists
$playstoreSource = "$sourceDir\playstore-icon.png"
$playstoreDest = "playstore-icon.png"
if (Test-Path $playstoreSource) {
    Copy-Item $playstoreSource $playstoreDest -Force
    Write-Host "Copied playstore icon"
}

Write-Host "Icon copying completed!"
Write-Host "Note: Replace .txt files with actual PNG icons for production builds"