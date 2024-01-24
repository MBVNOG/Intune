#=============================================================================================================================
#
# Script Name:     Remediate-HotFixKB5034441.ps1
# Description:     Purpose of this script is to Fix issue with HotFix KB5034441 to get it installed afterwards
# Creator:         Marcel Boom - m.boom@vnog.nl
#
#=============================================================================================================================
# Main script

# Variabelen
$scriptName = "PatchWinREScript_2004plus.ps1"
$ScriptUrl = "https://github.com/MBVNOG/Intune/raw/Remediation/PatchWinREScript_2004plus.ps1"
$updateUrl = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/crup/2024/01/windows10.0-kb5034232-x64_ff4651e9e031bad04f7fa645dc3dee1fe1435f38.cab"

$downloadPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Remediation\HotFixKB5034441"

$logFile = "$downloadPath\log.txt"

# Functie om de verbinding te controleren
function Test-ConnectionToUrl {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Url
    )
    try {
        $request = [Net.WebRequest]::Create($Url)
        $response = $request.GetResponse()
        $response.Close()
        return $true
    }
    catch {
        return $false
    }
}

# Functie om het script en de update te downloaden
function Get-File {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Url,
        [Parameter(Mandatory=$true)]
        [string]$OutputPath
    )
    $maxAttempts = 3
    for ($i = 1; $i -le $maxAttempts; $i++) {
        try {
            Invoke-WebRequest -Uri $Url -OutFile $OutputPath
            Add-Content -Path $logFile -Value "Download geslaagd: $Url"
            break
        }
        catch {
            if ($i -eq $maxAttempts) {
                Add-Content -Path $logFile -Value "Download mislukt na $maxAttempts pogingen: $Url"
                throw
            }
            if (!(Test-ConnectionToUrl -Url $Url)) {
                Add-Content -Path $logFile -Value "Verbinding mislukt, probeer het opnieuw..."
                Start-Sleep -Seconds 5
            }
            else {
                throw
            }
        }
    }
}

# Maak de downloadmap aan als deze niet bestaat
if (!(Test-Path -Path $downloadPath)) {
    New-Item -ItemType Directory -Path $downloadPath | Out-Null
    Add-Content -Path $logFile -Value "Downloadmap aangemaakt: $downloadPath"
}

# Download het script en de update
Get-File -Url $scriptUrl -OutputPath "$downloadPath\$scriptName"
Get-File -Url $updateUrl -OutputPath "$downloadPath\update.cab"

# Voer het script uit met het pad naar het gedownloade .cab bestand
Set-Location $downloadPath
& ".\$scriptName" -packagePath ".\update.cab"
