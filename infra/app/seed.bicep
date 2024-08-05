metadata description = 'Seed data in database accounts.'

param location string = resourceGroup().location
param tags object = {}

type managedIdentity = {
  name: string
  resourceId: string
  clientId: string
}

@description('Unique identifier for user-assigned managed identity.')
param userAssignedManagedIdentity managedIdentity

@description('Endpoint for Azure Cosmos DB for NoSQL account.')
param databaseAccountEndpoint string

module nosqlSeedData '../core/management/deployment/script.bicep' = {
  name: 'nosql-seed-data'
  params: {
    name: 'nosql-seed-data-deployment-script'
    location: location
    tags: tags
    userAssignedManagedIdentityIds: [
      userAssignedManagedIdentity.resourceId
    ]
    shell: 'AzureCLI'
    version: 'latest'
    content: '''
      dotnet tool install cosmicworks --tool-path ~/dotnet/tools
      ~/dotnet/tools/cosmicworks --disable-formatting --hide-credentials --use-managed-identity --endpoint ${Env:AZURE_COSMOS_DB_NOSQL_ENDPOINT}
    '''
    forceUpdateTag: '1'
    timeout: 'PT1H'
    cleanupPreference: 'OnSuccess'
    retentionInterval: 'P1D'
    environmentVariables: [
      {
        name: 'AZURE_COSMOS_DB_NOSQL_ENDPOINT'
        secureValue: databaseAccountEndpoint
      }
    ]
  }
}
