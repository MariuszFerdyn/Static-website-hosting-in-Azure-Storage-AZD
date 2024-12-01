@description('Primary location for all resources')
param location string

@description('Name of the environment')
param environmentName string

@description('Tags to be applied to resources')
param tags object

@description('The name of the storage account')
var storageAccountName = 'st${environmentName}${uniqueString(resourceGroup().id)}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  tags: tags
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2022-05-01' = {
  parent: storageAccount
  name: 'default'
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
  parent: blobService
  name: 'mycontainer'
}

output storageAccountName string = storageAccount.name
output containerName string = container.name
