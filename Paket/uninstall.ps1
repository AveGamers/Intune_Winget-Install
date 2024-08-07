# Intune_Winget-Install - uninstall.ps1
# Version 1.0
# Date: 11_07_2024
# Author: Jonas Techand
# Description: Removes winget.
# --------------------------------------------------------------------------
# ChangeLog: Script creation
# --------------------------------------------------------------------------
# Dependencies: NONE
# --------------------------------------------------------------------------
$PackageName = "Intune_Winget-Install"

# Check for running as admin
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

if (-not $currentPrincipal.IsInRole($adminRole)) {
    Write-Host "Restarting script with administrative privileges..."
    Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -WindowStyle Hidden -File `"$PSCommandPath`"" -Verb RunAs
    Start-Sleep 120
    exit
}

write-warning "The script has been started with administrative privileges."

# Start-Transcript -Path "$env:TEMP\IntunePackage\$PackageName\Install.log" -NoClobber -Append
Start-Transcript -Path "C:\source\IntunePackage\$PackageName\Uninstall.log" -NoClobber -Append

function Get-WingetDirectory {
    $ResolveWingetPath = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe\winget.exe"
    if ($ResolveWingetPath){
           $WingetPath = $ResolveWingetPath[-1].Path
    }

    $Wingetpath = Split-Path -Path $WingetPath -Parent
    cd $wingetpath
}

	Get-WingetDirectory
	Write-Warning "Winget cant be uninstalled. Jokes on you!"
	Write-Warning "Just kidding, I will remove the folder for you :D"
	Remove-Item -Type Directory -Path "$wingetpath" -Force -Recurse
	Write-Host "Winget has been removed. There should be an error following this message, which means, the folder can't be found. "
	Get-WingetDirectory
	Write-Host "$wingetpath"

Stop-Transcript