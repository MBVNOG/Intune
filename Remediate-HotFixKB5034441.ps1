#=============================================================================================================================
#
# Script Name:     Remediate-HotFixKB5034441.ps1
# Description:     Purpose of this script is to Fix issue with HotFix KB5034441 to get it installed afterwards
# Creator:         Marcel Boom - m.boom@vnog.nl
#
#=============================================================================================================================
# Main script

# Variabeles
#$scriptName = "PatchWinREScript_2004plus.ps1" # Use this one for newer windows versions 10 2004 + and 11
$ScriptName = "PatchWinREScript_General.ps1" # If the above doesn't work or you have older Windows 10 1909 and beyond, use this one
$ScriptUrl = "https://github.com/MBVNOG/Intune/raw/Remediation/$ScriptName"
$updateUrl = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/crup/2024/01/windows10.0-kb5034232-x64_ff4651e9e031bad04f7fa645dc3dee1fe1435f38.cab"

$downloadPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Remediation\HotFixKB5034441"

$logFile = "$downloadPath\Remediate-HotFixKB5034441.txt"

# Function to check connection
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

# Function to download script and .cab file
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
            Add-Content -Path $logFile -Value "Download succeeded: $Url"
            break
        }
        catch {
            if ($i -eq $maxAttempts) {
                Add-Content -Path $logFile -Value "Download failed after $maxAttempts attempts: $Url"
                throw
            }
            if (!(Test-ConnectionToUrl -Url $Url)) {
                Add-Content -Path $logFile -Value "Connection failed, please retry..."
                Start-Sleep -Seconds 5
            }
            else {throw}
        }
    }
}

# Create downloadfolder if it doesn't exist
if (!(Test-Path -Path $downloadPath)) {
    New-Item -ItemType Directory -Path $downloadPath | Out-Null
    Add-Content -Path $logFile -Value "Downloadfolder created: $downloadPath"
}

# Download script and update
Get-File -Url $scriptUrl -OutputPath "$downloadPath\$scriptName"
Get-File -Url $updateUrl -OutputPath "$downloadPath\update.cab"

# Execute script with path to .cab file and working dir
Set-Location $downloadPath
& ".\$scriptName" -packagePath ".\update.cab" -WorkDir $downloadPath
