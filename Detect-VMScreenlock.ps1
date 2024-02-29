# Detect_Instelling_Schermvergrendeling.ps1
$LockScreenTimeout = Get-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaveTimeOut"
if ($LockScreenTimeout.ScreenSaveTimeOut -gt 0) {
    Write-Host "Schermvergrendeling is ingesteld."
    Exit 1
} else {
    Write-Host "Schermvergrendeling is niet ingesteld."
    Exit 0
}
