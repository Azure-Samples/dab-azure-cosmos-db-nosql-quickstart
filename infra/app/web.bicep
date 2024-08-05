metadata description = 'Create web container resources.'

param appName string

param serviceTag string
param location string = resourceGroup().location
param tags object = {}

@description('Name of the environment where the application will be hosted.')
param envName string

@description('Endpoint for the API container.')
param apiEndpoint string

module containerAppsApp '../core/host/container-apps/app.bicep' = {
  name: 'container-apps-app-${appName}'
  params: {
    name: appName
    parentEnvironmentName: envName
    location: location
    tags: union(tags, {
      'azd-service-name': serviceTag
    })
    enableSystemAssignedManagedIdentity: false
    targetPort: 8080
    secrets: [
      {
        name: 'azure-container-app-endpoint' // Create a uniquely-named secret
        value: apiEndpoint // Azure Container App endpoint
      }
    ]
    environmentVariables: [
      {
        name: 'DATAAPIBUILDER__ENDPOINT' // Name of the environment variable referenced in the application
        secretRef: 'azure-container-app-endpoint' // Reference to secret
      }
    ]
  }
}

output name string = containerAppsApp.outputs.name
output endpoint string = containerAppsApp.outputs.endpoint
