#Enabling Remote Desktop Connections on the system

#change registry setting to enable RDP
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0

#Enable the firewall rule to Allow RD connections
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
