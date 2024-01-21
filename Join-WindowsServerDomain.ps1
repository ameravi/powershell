function set-windowsdomainconfig {
$domain = 'local.meravi.us'
$credential = get-credential

add-computer -domainname local.meravi.us -credential $credential

restart-computer

}
