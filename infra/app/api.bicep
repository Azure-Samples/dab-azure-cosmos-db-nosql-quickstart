metadata description = 'Create API contianer resources.'

param appName string

param location string = resourceGroup().location
param tags object = {}

type managedIdentity = {
  name: string
  resourceId: string
  clientId: string
}

@description('Unique identifier for user-assigned managed identity.')
param userAssignedManagedIdentity managedIdentity

@description('Name of the environment where the application will be hosted.')
param envName string

@description('Endpoint for Azure Cosmos DB for NoSQL account.')
param databaseAccountEndpoint string

module containerAppsApp '../core/host/container-apps/app.bicep' = {
  name: 'container-apps-app-${appName}'
  params: {
    name: appName
    parentEnvironmentName: envName
    location: location
    tags: tags
    enableSystemAssignedManagedIdentity: false
    userAssignedManagedIdentityIds: [
      userAssignedManagedIdentity.resourceId
    ]
    targetPort: 5000
    containerImage: 'mcr.microsoft.com/azure-databases/data-api-builder:latest'
    secrets: [
      {
        name: 'azure-cosmos-db-nosql-endpoint' // Create a uniquely-named secret
        value: databaseAccountEndpoint // NoSQL database account endpoint
      }
      {
        name: 'azure-managed-identity-client-id' // Create a uniquely-named secret
        value: userAssignedManagedIdentity.clientId // Client ID of user-assigned managed identity
      }
    ]
    environmentVariables: [
      {
        name: 'AZURE_COSMOS_DB_NOSQL_ENDPOINT' // Name of the environment variable referenced in the application
        secretRef: 'azure-cosmos-db-nosql-endpoint' // Reference to secret
      }
      {
        name: 'AZURE_CLIENT_ID' // Name of the environment variable referenced in the application
        secretRef: 'azure-managed-identity-client-id' // Reference to secret
      }
    ]
  }
}

output name string = containerAppsApp.outputs.name
output endpoint string = containerAppsApp.outputs.endpoint
