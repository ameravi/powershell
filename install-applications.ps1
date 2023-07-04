## Google Chrome ###

$Path = $env:TEMP; $Installer = 'chrome_installer.exe'; Invoke-WebRequest -Uri 'http://dl.google.com/chrome/install/375.126/chrome_installer.exe' -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer -Args '/silent /install' -Verb RunAs -Wait; Remove-Item -Path $Path\$Installer
Write-Output "Google Chrome Enterprise is installed1"

### Notepad++ ###

$path = $env:TEMP
$NPPURI = 'https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.5.4/npp.8.5.4.Installer.x64.exe'
$NPPInstaller = npp.8.5.4.Installer.x64.exe

Invoke-WebRequest -Uri $NPPURI -Outfile $Path\$Installer
Start-Process -FilePath $Path\$NPPInstaller -Args '/S /NCRC'
Write-Output "Notepad ++ Is installed!"


