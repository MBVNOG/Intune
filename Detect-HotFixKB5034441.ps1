#=============================================================================================================================
#
# Script Name:     Detect-HotFixKB5034441.ps1
# Description:     Purpose of this script is to detect if HotFix KB5034441 is not installed
#
#=============================================================================================================================
# Main script

if (Test-Path HKLM:\Software\Microsoft\PushButtonReset)
{
    $values = Get-ItemProperty -Path HKLM:\Software\Microsoft\PushButtonReset
    if (!(-not $values))
    {
        if (Get-Member -InputObject $values -Name WinREPathScriptSucceed)
        {
            $value = Get-ItemProperty -Path HKLM:\Software\Microsoft\PushButtonReset -Name WinREPathScriptSucceed
            if ($value.WinREPathScriptSucceed -eq 1)
            {
                LogMessage("This script was previously run successfully")
                exit 0
            }
        }
    }
}
# Detect if Hotfix KB5034441 is installed
$Update = Get-HotFix -Id KB5034441 -ErrorAction SilentlyContinue
if ($Update -eq $null) {
    Write-Host "The update is not installed."
    exit 1
}
else {
    Write-Host "The update is installed."
    exit 0
}
