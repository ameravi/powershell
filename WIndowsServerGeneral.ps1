
## Variables used for initial server deployment.  
## Fill these out with pertinent info

$credential = get-credential 
$hostname = 'dc1'
$TimeZone = 'Eastern Standard Time'
$domainsuffix = "meravi.us"
$localip = '192.168.40.209'
$gateway = '192.168.40.1'
$IpPrefixLength = '24'
$DNSServers = '192.168.40.208,192.168.40.209'
$VMWare = Read-Host 'Does VMware Tools need to be installed?  Type Y for Yes, N for No'

#
#This file just stores commands to setup a new windows server

## Change timezone of server

Set-TimeZone -id $TimeZone

#To set a new static ip address on an adapter, you need to get the interface index of the adapter - see commands below.
#This assumes there is one network adapter on a 192.168.x.x /24 network and the subnet it's on has dhcp

$IP = Get-NetIpAddress | where { $_.IPAddress -like "192.168.*" }
$Index = $ip.InterfaceIndex

## Setting a new static address when setting up a windows vm
New-NetIPAddress -InterfaceIndex $Index -IPAddress $localip -PrefixLength $IPPrefixLength -DefaultGateway $gateway

## Set DNS Address of Adapater

Set-DnsClientServerAddress -InterfaceIndex $index -ServerAddresses $DNSServers

## Rename Windows Server

rename-computer -newname $hostname  

restart-computer 

if ($Vmware -eq 'yes') {

## Install VMWare Tools on a vm where the cd drive is D.  Will install and automatically reboot the vm

d:\setup64.exe /S /v "/qn"

}
elseif {

write-output "Skipping VMWare Tools Installation" 

}

## Join system to domain

add-computer -domainname local.meravi.us -credential $credential

##Enable Remote Desktop on the system

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

## Upgrade the server to a domain controller

Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

## Configure the server as a domain controller.  This command will prompt for a dsrm password and ask to confirm the install, then reboot

Install-ADDSDomainController -InstallDns -DomainName "local.meravi.us" -SafeModeAdministratorPassword

## Add UPN Suffixes to Domain if needed.  
## Get Current UPN SUffixes
## Add Domain(s) as UPN SUffix
Get-ADForest | Set-ADForest -UPNSuffixes @{add="$domainsuffix"}
Get-ADForest | Format-List UPNSuffixes

## Move FSMO Roles if needed 

##Role #'s 
# 0 = PDCEmulator
# 1 = RIDMaster
# 2 = InfrastructureMaster
# 3 = SchemaMaster
# 4 = DomainNamingMaster


Move-ADDirectoryServerOperationMasterRole $server 0,1,2,3,4 


Enable-ADOptionalFeature 'Recycle Bin Feature' -Scope ForestOrConfigurationSet -Target local.meravi.us


Get-ADOptionalFeature -filter *

 





 




