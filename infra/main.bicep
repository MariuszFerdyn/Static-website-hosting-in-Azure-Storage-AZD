targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name of the environment that can be used as part of naming resource convention')
param environmentName string

@minLength(1)
@description('Primary location for all resources')
param location string

// Tags that should be applied to all resources
var tags = {
  'azd-env-name': environmentName
}

// Create a resource group
resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'rg-${environmentName}'
  location: location
  tags: tags
}

// Create resources within the resource group's scope
module storageResources './storage.bicep' = {
  name: 'storageDeployment'
  scope: rg
  params: {
    location: location
    environmentName: environmentName
    tags: tags
  }
}

// Output the storage account and container names
output storageAccountName string = storageResources.outputs.storageAccountName
output resourceGroupName string = rg.name
output storageHostName string = storageResources.outputs.staticWebsiteHostName
