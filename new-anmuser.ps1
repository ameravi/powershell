#Manual Onboarding 

$SecurePassword = (Read-Host -As SecureString)

$Suffix = '@meravi.us'
$SamAccountName = 'rmeravi'
$Name = 'Ryan Meravi'
$FirstName = 'Ryan'
$LastName = 'Meravi'
$UserPrincipalName = ($SamAccountName +$Suffix)
$Title = 'Second Dude'
$Mail = $UserPrincipalName

New-ADUser -samaccountname $SamAccountName `
-UserPrincipalName $UserPrincipalname `
-Name $Name `
-AccountPassword $SecurePassword `
-Path "OU=Meravi Users,OU=Meravi,DC=LOCAL,DC=MERAVI,DC=US" `
-Enabled $true



	

