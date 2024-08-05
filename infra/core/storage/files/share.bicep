metadata description = 'Creates an Azure Files share.'

param name string

@description('Name of the parent Azure Storage account.')
param parentAccountName string

@description('Name of the parent Azure Files service.')
param parentServiceName string

resource account 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
  name: parentAccountName
}

resource service 'Microsoft.Storage/storageAccounts/fileServices@2023-05-01' existing = {
  name: parentServiceName
  parent: account
}

resource share 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  name: name
  parent: service
}

output name string = share.name
