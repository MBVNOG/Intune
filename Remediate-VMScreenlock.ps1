# Remedie_Schermvergrendeling.ps1
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaveTimeOut" -Value 0
Write-Host "Schermvergrendeling is verwijderd."
exit 0
