##Installs powershell 7

function install-powershell7 {
#This script installs Powershell 7.5.1 from a powershell 5.1 shell

$psuri = 'https://github.com/PowerShell/Powershell/releases/download/v7.5.1/Powershell-7.5.1-win-x64.msi'
$installer = 'Powershell-7.5.1-win-x64.msi'
$path = $env:TEMP
$ps7path = 'c:\program files\powershell\7\pwsh.exe'

invoke-webrequest -URI $psuri -OutFile $Path\$Installer
msiexec /i $path\$installer /qn
}

install-powershell7
