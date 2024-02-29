# Remedie_Schermvergrendeling.ps1
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaveActive" -Value 0
Write-Host "Schermvergrendeling is verwijderd."
exit 0
