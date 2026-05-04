$path = 'c:\Users\agusjayateknik\Desktop\Fotomu\Fotomu.html'
$text = Get-Content -Raw -Path $path
$pattern = "\n\s*function bukaCheckout\(\) \{[\s\S]*?\n\s*}\n\n\s*async function kirimEmail\(email\) \{[\s\S]*?\n\s*}\n\n\s*// ===== SELL - UPLOAD ====="
$new = [regex]::Replace($text, $pattern, "\n    // ===== SELL - UPLOAD =====")
if ($new -eq $text) {
    Write-Output 'pattern not found'
} else {
    Set-Content -Path $path -Value $new
    Write-Output 'removed duplicate checkout block'
}
