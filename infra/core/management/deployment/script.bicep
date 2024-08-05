metadata description = 'Creates and run a deployment script.'

param name string
param location string = resourceGroup().location
param tags object = {}

@description('List of user-assigned managed identities. Defaults to an empty list.')
param userAssignedManagedIdentityIds string[] = []

@allowed([
  'AzureCLI'
  'AzurePowerShell'
])
@description('Shell to use for the script. Defaults to "AzureCLI".')
param shell string = 'AzureCLI'

@description('Version of the selected shell to use.')
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

module bashScript 'bash/script.bicep' = if (shell == 'AzureCLI') {
  name: 'bash-deployment-script'
  params: {
    name: name
    location: location
    tags: tags
    userAssignedManagedIdentityIds: userAssignedManagedIdentityIds
    version: version
    forceUpdateTag: forceUpdateTag
    content: content
    timeout: timeout
    cleanupPreference: cleanupPreference
    retentionInterval: retentionInterval
    environmentVariables: environmentVariables
  }
}

module powershellScript 'powershell/script.bicep' = if (shell == 'AzurePowerShell') {
  name: 'powershell-deployment-script'
  params: {
    name: name
    location: location
    tags: tags
    userAssignedManagedIdentityIds: userAssignedManagedIdentityIds
    version: version
    forceUpdateTag: forceUpdateTag
    content: content
    timeout: timeout
    cleanupPreference: cleanupPreference
    retentionInterval: retentionInterval
    environmentVariables: environmentVariables
  }
}
