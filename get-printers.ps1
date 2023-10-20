#variables used for this script

#this script will show the printers that were installed on the workstations.  it can also be piped to remove-printer

$hostname = hostname
$logpath = ""
$path = ""
$logfile = "Printers.log"
$locallog = "c:\pltest\gpscript-ran.txt"
$localfile = "gpscript-ran.txt"
$localpath = "c:\pltest"


#the local log test will test to see if this has already been run

$locallogtest = test-path -path $locallog

If ($locallogtest) {
	
	Write-Output "Script already ran on computer.  Exiting the script"
	exit
	
} else {
	
	new-item -path "c:\" -Name "pltest" -ItemType Directory
	New-Item -Path $localpath -name $localfile -ItemType File 
}


#this other log test will see if the central log of printer information exists, if not it will create it

$logtest = Test-Path -Path $logpath 

If (!$logtest) {

		new-item -path $path -Name $logfile -ItemType File

} else {

Write-Output "The log file exists.  Moving on to list out printers installed on $hostname."	

}

# The $printers variable will collect information about printers that were added to the systems and then ouput the hostname
# and printer info to that central file

	$printers = get-printer | Where-Object { $_.DriverName -like "*IPP Class*" -or $_.DriverName -like "Fiery*" -or $_.PortName -like "IP_*" -or $_.PortName -like "192.168*" } | Select-Object Name,DriverName,PortName

    $hostname | Out-File -FilePath $logpath -append
    $printers | Out-File -FilePath $logpath -append
	
