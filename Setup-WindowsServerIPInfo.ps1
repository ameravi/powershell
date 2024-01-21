
## Variables used for initial server deployment.  
## Fill these out with pertinent info

function Configure-ServerIpInfo {

$credential = get-credential 
$hostname = 'dc1'
$TimeZone = 'Eastern Standard Time'
$domainsuffix = "meravi.us"
$localip = '192.168.40.209'
$gateway = '192.168.40.1'
$IpPrefixLength = '24'
$DNSServers = '192.168.40.208,192.168.40.209'
#$VMWare = Read-Host 'Does VMware Tools need to be installed?  Type Y for Yes, N for No'

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

##Enable Remote Desktop on the system

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

## Rename Windows Server

rename-computer -newname $hostname  

restart-computer 

}


 





 




