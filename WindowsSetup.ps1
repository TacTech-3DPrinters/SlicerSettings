
# We first need to check if we are running in an administrator console
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "You are not currently running in an administrator shell. Exiting the script."
    Start-Process powershell.exe "-File",($MyInvocation.MyCommand.Definition) -Verb RunAs
    exit
}

# Function to symlink the configs
function Create-Symlink {
    param (
        [string]$originalFolder,
        [string]$symlinkFolder
    )
    New-Item -ItemType SymbolicLink -Path $symlinkFolder -Target $originalFolder
}

# OrcaSlicer Configs
Create-Symlink -symlinkFolder "$home\AppData\Roaming\OrcaSlicer" -originalFolder ".\OrcaSlicer"