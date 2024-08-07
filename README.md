# Intune_Winget-Install
> This script is used as a dependency for Intune.
> Using winget for installing apps on windows can be a bit complicated. 
> After you install a fresh copy of windows, winget is only available after a specific update of the microsoft store. 
> To have winget available on time, this package simply installs winget again.
> As winget is not nativly compatible with the windows system user, the script runs winget.exe directly from the directory. 

## Compile package
> To create the needed .intunewin file, run `run.bat`.

## Install:
> powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File install.ps1 

## Uninstall:
> powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File uninstall.ps1

## Detection Rule: 
> Customt Detection Script (The Script itself validates the install)