$hostname = 'dc1'

##Role #'s 

# 0 = PDCEmulator
# 1 = RIDMaster
# 2 = InfrastructureMaster
# 3 = SchemaMaster
# 4 = DomainNamingMaster


Move-ADDirectoryServerOperationMasterRole $hostname 0,1,2,3,4 





