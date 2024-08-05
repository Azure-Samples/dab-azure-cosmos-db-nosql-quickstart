metadata description = 'Create storage resources.'

param accountName string

param location string = resourceGroup().location
param tags object = {}

module storage '../core/storage/account.bicep' = {
  name: 'storage-account'
  params: {
    name: accountName
    location: location
    tags: tags
    allowSharedKeyAccess: false
  }
}

module fileService '../core/storage/files/service.bicep' = {
  name: 'storage-file-service'
  params: {
    parentAccountName: storage.outputs.name
  }
}

module fileShare '../core/storage/files/share.bicep' = {
  name: 'storage-file-share'
  params: {
    name: 'configuration'
    parentAccountName: storage.outputs.name
    parentServiceName: fileService.outputs.name
  }
}

output accountName string = storage.outputs.name
output fileShareName string = fileShare.outputs.name
output fileShareEndpoint string = storage.outputs.fileEndpoint
