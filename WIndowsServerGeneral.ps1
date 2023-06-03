##This file just stores commands to setup a new windows server

## Change timezone of server

Set-TimeZone -id "Eastern Standard Time"

#To set a new static ip address on an adapter, you need to get the interface index of the adapter - see commands below.
#This assumes there is one network adapter on a 192.168.x.x /24 network and the subnet it's on has dhcp

$IP = Get-NetIpAddress | where { $_.IPAddress -like "192.168.*" }
$Index = $ip.InterfaceIndex

## Setting a new static address when setting up a windows vm
New-NetIPAddress -InterfaceIndex $Index -IPAddress 192.168.40.208 -PrefixLength 24 -DefaultGateway 192.168.40.1

## Set DNS Address of Adapater

Set-DnsClientServerAddress -InterfaceIndex $index -ServerAddresses <ServerAddress or Addresses in paranthessis, comma separated>

## Rename Windows Server

rename-computer -newname <computername>

## Install VMWare Tools on a vm where the cd drive is D.  Will install and automatically reboot the vm

d:\setup64.exe /S /v "/qn"

## Join system to domain

add-computer -domainname local.meravi.us -credential <DOMAIN\User.

##Enable Remote Desktop on the system

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

## Upgrade the server to a domain controller

Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

## Configure the server as a domain controller.  This command will prompt for a dsrm password and ask to confirm the install, then reboot

Install-ADDSDomainController -InstallDns -DomainName "local.meravi.us" -SafeModeAdministratorPassword

## Move FSMO Roles if needed 

##Role #'s 
# 0 = PDCEmulator
# 1 = RIDMaster
# 2 = InfrastructureMaster
# 3 = SchemaMaster
# 4 = DomainNamingMaster


Move-ADDirectoryServerOperationMasterRole $server 0,1,2,3,4 


 




