az group list

az sql server create --name batata1 --resource-group learn-245a54a3-07c6-4bbf-8795-4c2b9f8dd026 --location "Brazil South" --admin-user admin_user --admin-password satc@2023

az sql server firewall-rule create --resource-group learn-245a54a3-07c6-4bbf-8795-4c2b9f8dd026 --server batata1 -n AllowYourIp --start-ip-address 177.54.50.222 --end-ip-address 177.54.50.222

az sql db create --resource-group learn-245a54a3-07c6-4bbf-8795-4c2b9f8dd026 --server batata1 --name dados --edition GeneralPurpose --compute-model Serverless --family Gen5 --capacity 2 --zone-redundant false --backup-storage-redundancy "Local"