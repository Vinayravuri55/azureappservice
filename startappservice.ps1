param (
    [string]$serviceprincipalAppId,
    [string]$sppassword,
    [string]$tenantId,
    [string]$subscription
)

$resourcegroup = "813-c4ec6a02-hands-on-with-terraform-on-azure"

az login --service-principal -u $serviceprincipalAppId --password $sppassword --tenant $tenantId

az account set --subscription $subscription

az webapp list --query "[].{Name:name, ResourceGroup: resourceGroup, Location: location, State:state}" --output table

$output = az webapp list -g $resourcegroup -o json --query '[].{Name: name}' --output tsv

#Loop thru the variables and stop the instances one by one
foreach($item in $output){
    #start the app instances
    az webapp start --name $item --resource-group $resourcegroup
}