function install-googlechrome {

## Google Chrome Install ###

$Path = $env:TEMP; $Installer = 'chrome_installer.exe'; Invoke-WebRequest -Uri 'http://dl.google.com/chrome/install/375.126/chrome_installer.exe' -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer -Args '/silent /install' -Verb RunAs -Wait; Remove-Item -Path $Path\$Installer
Write-Output "Google Chrome Enterprise is installed!"

}

function install-adobereader {

### Adobe Reader Install ###

$CheckADCReg = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | where {$_.DisplayName -like "Adobe Acrobat Reader DC*"}
If ($CheckADCReg -eq $null) {
$Installdir = "c:\temp\install_adobe"
New-Item -Path $Installdir  -ItemType directory

$source = "ftp://ftp.adobe.com/pub/adobe/reader/win/AcrobatDC/2001320064/AcroRdrDC2001320064_en_US.exe"
$destination = "$Installdir\AcroRdrDC2001320064_en_US.exe"
Invoke-WebRequest $source -OutFile $destination


Start-Process -FilePath "$Installdir\AcroRdrDC2001320064_en_US.exe" -ArgumentList "/sAll /rs /rps /msi /norestart /quiet EULA_ACCEPT=YES"

Start-Sleep -s 240


rm -Force $Installdir\AcroRdrDC*
}
}



function install-notepadplusplus {

### Notepad++ Install###

$path = $env:TEMP
$NPPURI = 'https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.2/npp.8.6.2.Installer.x64.exe'
$NPPInstaller = 'npp.8.6.2.Installer.x64.exe'

Invoke-WebRequest -Uri $NPPURI -Outfile $Path\$NPPInstaller
Start-Process -FilePath $Path\$NPPInstaller -Args '/S /NCRC'
Write-Output "Notepad ++ Is installed!"
}

# Functions are below.  Comment out the functions that you do not want to run. 

#install-googlechrome
#install-adobereader
install-notepadplusplus
