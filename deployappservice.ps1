param (
    [string]$serviceprincipalAppId,
    [string]$sppassword,
    [string]$tenantId,
    [string]$subscription
)

$resourcegroup = "813-c4ec6a02-hands-on-with-terraform-on-azure"

az login --service-principal -u $serviceprincipalAppId --password $sppassword --tenant $tenantId

az account set --subscription $subscription

az appservice plan create -n hondsalesasp -g $resourcegroup -l EastUS --sku B1

az appservice plan list --query "[].{Name: name, ResourceGroup: resourceGroup, Location: location, State:state}" --output table

az webapp create -n hondaas -g $resourcegroup --plan hondsalesasp --runtime "ASPNET:V4.8"
