targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name of the environment that can be used as part of naming resource convention.')
param environmentName string

@minLength(1)
@description('Primary location for all resources.')
param location string

// Optional parameters
param cosmosDbAccountName string = ''
param containerAppsEnvName string = ''
param containerAppsWebAppName string = ''
param containerAppsDataApiBuilderAppName string = ''
param userAssignedIdentityName string = ''

// *ServiceName is used as value for the tag (azd-service-name) azd uses to identify deployment host
param serviceName string = 'web'

var abbreviations = loadJsonContent('abbreviations.json')
var resourceToken = toLower(uniqueString(subscription().id, environmentName, location))
var tags = {
  'azd-env-name': environmentName
  repo: 'https://github.com/azure-samples/dab-azure-cosmos-db-nosql-quickstart'
}

// Define resource group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: environmentName
  location: location
  tags: tags
}

module identity 'app/identity.bicep' = {
  name: 'identity'
  scope: resourceGroup
  params: {
    identityName: !empty(userAssignedIdentityName)
      ? userAssignedIdentityName
      : '${abbreviations.userAssignedIdentity}-${resourceToken}'
    location: location
    tags: tags
  }
}

module database 'app/database.bicep' = {
  name: 'database'
  scope: resourceGroup
  params: {
    accountName: !empty(cosmosDbAccountName) ? cosmosDbAccountName : '${abbreviations.cosmosDbAccount}-${resourceToken}'
    location: location
    tags: tags
  }
}


module env 'app/environment.bicep' = {
  name: 'environment'
  scope: resourceGroup
  params: {
    envName: !empty(containerAppsEnvName) ? containerAppsEnvName : '${abbreviations.containerAppsEnv}-${resourceToken}'
    location: location
    tags: tags
  }
}

module api 'app/api.bicep' = {
  name: 'api'
  scope: resourceGroup
  params: {
    appName: !empty(containerAppsWebAppName) ? containerAppsWebAppName : '${abbreviations.containerAppsApp}-web-${resourceToken}'
    envName: env.outputs.name
    location: location
    tags: tags
    userAssignedManagedIdentity: {
      name: identity.outputs.name
      resourceId: identity.outputs.resourceId
      clientId: identity.outputs.clientId
    }
    databaseAccountEndpoint: database.outputs.endpoint
  }
}

module web 'app/web.bicep' = {
  name: 'web'
  scope: resourceGroup
  params: {
    appName: !empty(containerAppsDataApiBuilderAppName) ? containerAppsDataApiBuilderAppName : '${abbreviations.containerAppsApp}-api-${resourceToken}'
    envName: env.outputs.name
    location: location
    tags: tags
    serviceTag: serviceName
    apiEndpoint: api.outputs.endpoint
  }
}


// Application outputs
output AZURE_WEB_APP_ENDPOINT string = web.outputs.endpoint
output DATA_API_BUILDER_ENDPOINT string = api.outputs.endpoint
