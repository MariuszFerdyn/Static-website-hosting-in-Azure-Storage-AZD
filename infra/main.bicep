@description('The location where resources will be created')
param location string = resourceGroup().location

@description('Base name for resources')
param baseName string = 'staticwebsite${uniqueString(resourceGroup().id)}'

module storageModule 'storage.bicep' = {
  name: 'storage-deployment'
  params: {
    location: location
    storageAccountName: baseName
  }
}

output storageAccountName string = storageModule.outputs.storageAccountName
output staticWebsiteUrl string = storageModule.outputs.staticWebsiteUrl
