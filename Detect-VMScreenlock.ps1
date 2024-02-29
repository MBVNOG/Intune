# Detect_Instelling_Schermvergrendeling.ps1
$LockScreenTimeout = Get-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaveActive" -ErrorAction SilentlyContinue
if ($LockScreenTimeout) {
    Write-Host "Schermvergrendeling is ingesteld."
    exit 1
} else {
    Write-Host "Schermvergrendeling is niet ingesteld."
    exit 0
}
