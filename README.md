# Intune_Winget-Install
> This script is used as a dependency for Intune.
> Using winget for installing apps on windows can be a bit complicated. 
> After you install a fresh copy of windows, winget is only available after a specific update of the microsoft store. 
> To have winget available on time, this package simply installs winget again.
> As winget is not nativly compatible with the windows system user, the script runs winget.exe directly from the directory. 

## Compile package
> To create the needed .intunewin file, run `run.bat`.

## Why is there so much in the detect.ps1 file?
> When choosing the custom detection script method in intune, intune first runs the detection script and proceeds on its status code.
> To make it more reliable, you can either just put your whole script in there (like I did) or call the needed files after a self-check.

## Install:
> powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File install.ps1 

## Uninstall:
> powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File uninstall.ps1

## Detection Rule: 
> Custom Detection Script (The Script itself validates the install)