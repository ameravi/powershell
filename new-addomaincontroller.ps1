$DomainName = 'local.meravi.us'

## Upgrade the server to a domain controller

Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

## Configure the server as a domain controller.  This command will prompt for a dsrm password and ask to confirm the install, then reboot

Install-ADDSDomainController -InstallDns -DomainName $DomainName -SafeModeAdministratorPassword
