*******************Set RD Collection to use Farm name when publishing RemoteApps******************************
Set-RDSessionCollectionConfiguration –CollectionName "RDC1" -CustomRdpProperty "full address:s:rds.bizco.com `nalternate full address:s:rds.bizco.com"
 
#****************************RDS Session Host Cert***********************************
$Thumbprint="1e4f65cc1c1c69f8a66b2ff0c6136c8b7de786f4"
$PATH = (Get-WmiObject -class "Win32_TSGeneralSetting" -Namespace root\cimv2\terminalservices)
Set-WmiInstance -Path $PATH -argument @{SSLCertificateSHA1Hash=$Thumbprint}
 
#********************* Set RDS Certs *****************************************
$CertPassword = "Password"
$PFXPath = "C:\Certificates\Wildcard.pfx"
$RDConnectionBroker = "Server.FQDN.local"
 
$Password = ConvertTo-SecureString -String $CertPassword -AsPlainText -Force
Set-RDCertificate -Role RDGateway -ImportPath $PFXPath -Password $Password -ConnectionBroker $RDConnectionBroker
Set-RDCertificate -Role RDWebAccess -ImportPath $PFXPath -Password $Password -ConnectionBroker $RDConnectionBroker
Set-RDCertificate -Role RDRedirector -ImportPath $PFXPath -Password $Password -ConnectionBroker $RDConnectionBroker
Set-RDCertificate -Role RDPublishing -ImportPath $PFXPath -Password $Password -ConnectionBroker $RDConnectionBroke
