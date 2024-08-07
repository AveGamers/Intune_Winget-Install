# Intune_Winget-Install - install.ps1
# Version 1.0
# Date: 11_07_2024
# Author: Jonas Techand
# Description: Install winget.
# --------------------------------------------------------------------------
# ChangeLog: Script creation
# --------------------------------------------------------------------------
# Dependencies: winget
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

# Start-Transcript -Path "$env:TEMP\IntunePackage\$PackageName\Install.log" -NoClobber -Append
Start-Transcript -Path "C:\source\IntunePackage\$PackageName\Install.log" -NoClobber -Append
write-warning "The script has been started with administrative privileges."

# Make sure, winget is installed
#WebClient
$dc = New-Object net.webclient
$dc.UseDefaultCredentials = $true
$dc.Headers.Add("user-agent", "Inter Explorer")
$dc.Headers.Add("X-FORMS_BASED_AUTH_ACCEPTED", "f")

#temp folder
$InstallerFolder = $(Join-Path $env:ProgramData CustomScripts)
if (!(Test-Path $InstallerFolder))
{
New-Item -Path $InstallerFolder -ItemType Directory -Force -Confirm:$false
}
	#Check Winget Install
	Write-Host "Checking if Winget is installed" -ForegroundColor Yellow
	$TestWinget = Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq "Microsoft.DesktopAppInstaller"}
	If ([Version]$TestWinGet. Version -gt "2022.506.16.0") 
	{
		Write-Host "WinGet is Installed" -ForegroundColor Green
	}Else 
		{
		#Download WinGet MSIXBundle
		Write-Host "Not installed. Downloading WinGet..." 
		$WinGetURL = "https://aka.ms/getwinget"
		$dc.DownloadFile($WinGetURL, "$InstallerFolder\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle")
		
		#Install WinGet MSIXBundle 
		Try 	{
			Write-Host "Installing MSIXBundle for App Installer..." 
			Add-AppxProvisionedPackage -Online -PackagePath "$InstallerFolder\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -SkipLicense 
			Write-Host "Installed MSIXBundle for App Installer" -ForegroundColor Green
			}
		Catch {
			Write-Host "Failed to install MSIXBundle for App Installer..." -ForegroundColor Red
			} 
	
		#Remove WinGet MSIXBundle 
		#Remove-Item -Path "$InstallerFolder\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -Force -ErrorAction Continue
		}

function Get-WingetDirectory {
    $ResolveWingetPath = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe\winget.exe"
    if ($ResolveWingetPath){
           $WingetPath = $ResolveWingetPath[-1].Path
    }

    $Wingetpath = Split-Path -Path $WingetPath -Parent
    cd $wingetpath
}
Write-Host "-> Installation Steps completed successfully."

Stop-Transcript