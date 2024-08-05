metadata description = 'Creates and run a Bash (Azure CLI) deployment script.'

param name string
param location string = resourceGroup().location
param tags object = {}

@description('List of user-assigned managed identities. Defaults to an empty list.')
param userAssignedManagedIdentityIds string[] = []

@description('Version of Azure CLI to use.')
param version string = 'latest'

@description('Tag that controls when the script executes based on a changed value. Defaults to "00000000-0000-0000-0000-000000000000".')
param forceUpdateTag string = '00000000-0000-0000-0000-000000000000'

@description('Content of the script to execute.')
param content string

@description('Timeout for the script to execute in ISO 8601 format. Defaults to "P1D".')
param timeout string = 'P1D'

@allowed([
  'Always'
  'OnSuccess'
  'OnExpiration'
])
@description('Cleanup preference for the script. Defaults to "Always".')
param cleanupPreference string = 'Always'

@description('Retention interval for the script in ISO 8601 format. Defaults to "P1D".')
param retentionInterval string = 'P1D'

type environmentVariable = {
  name: string
  value: string?
  secureValue: string?
}

@description('List of environment variables to set for the script. Defaults to an empty list.')
param environmentVariables environmentVariable[] = []

resource script 'Microsoft.Resources/deploymentScripts@2023-08-01' = {
  name: name
  location: location
  tags: tags
  identity: !empty(userAssignedManagedIdentityIds)
    ? {
        type: 'UserAssigned'
        userAssignedIdentities: toObject(userAssignedManagedIdentityIds, uaid => uaid, uaid => {})
      }
    : null
  kind: 'AzureCLI'
  properties: {
    azCliVersion: version
    forceUpdateTag: forceUpdateTag
    scriptContent: content
    timeout: timeout
    cleanupPreference: cleanupPreference
    retentionInterval: retentionInterval
    environmentVariables: environmentVariables
  }
}
