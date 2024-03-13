az group list

az sql server create --name batata1 --resource-group learn-191a5344-5ad0-4abf-bb6f-d1206af5d078 --location "Brazil South" --admin-user admin_user --admin-password satc@2023

az sql server firewall-rule create --resource-group learn-191a5344-5ad0-4abf-bb6f-d1206af5d078 --server batata1 -n AllowYourIp --start-ip-address 177.54.50.222 --end-ip-address 177.54.50.222

az sql db create --resource-group learn-191a5344-5ad0-4abf-bb6f-d1206af5d078 --server batata1 --name dados --edition GeneralPurpose --compute-model Serverless --family Gen5 --capacity 2 --zone-redundant false --backup-storage-redundancy "Local"