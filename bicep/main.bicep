extension microsoftgraph
extension microsoftgraphbeta

@description('Azure region where the Resource Group and Automation Account is to be placed')
param location string

@description('Name of the Resource Group that will be created and contain the Automation Account')
param resourceGroupName string

@description('Name of Automation Account')
param aaName string

targetScope = 'subscription'

var exchangeOnlineAdministratorAppRoleId  = 'dc50a0fb-09a3-484d-be87-e023b12c6440'
var exchangeOnlineAppId                   = '00000002-0000-0ff1-ce00-000000000000'
// var azureServiceManagementAPIAppId        = '797f4846-ba00-4fd7-ba43-dac1f8f63013'
var msGraphAppId                          = '00000003-0000-0000-c000-000000000000'

// https://learn.microsoft.com/en-us/graph/permissions-reference#organizationreadall
var msGraphOrgReadAllAppRoleId = '498476ce-e0fe-48b0-b801-37ba7e2685c6'

// https://learn.microsoft.com/en-us/graph/permissions-reference#domainreadall
// var msGraphDomainReadAllAppRoleId = 'dbb9058a-0e50-45d7-ae91-66909b5d4664'

// https://learn.microsoft.com/en-us/graph/permissions-reference#directoryreadall
// var msGraphDirectoryReadAllAppRoleId = '7ab1d382-f21e-4acd-a863-ba3e13f7da61'

resource exo_sp 'Microsoft.Graph/servicePrincipals@v1.0' existing = {
  appId: exchangeOnlineAppId
}

//resource azsmapi_sp 'Microsoft.Graph/servicePrincipals@v1.0' existing = {
//  appId: azureServiceManagementAPIAppId
//}

resource msgraph_sp 'Microsoft.Graph/servicePrincipals@v1.0' existing = {
  appId: msGraphAppId
}

resource rg_automation 'Microsoft.Resources/resourceGroups@2024-06-01-preview' = {
  name: resourceGroupName
  location: location
}

module aa_exchange 'modules/modAutomationAccount.bicep' = {
  scope: rg_automation
  name: 'aa_exchange'
  params: {
    aaName: aaName
    location: location
  }
}

resource aa_ara_exoadmin 'Microsoft.Graph/appRoleAssignedTo@v1.0' = {
  appRoleId: exchangeOnlineAdministratorAppRoleId
  principalId: aa_exchange.outputs.aa_exchange_sami
  resourceId: exo_sp.id
}

resource aa_ara_orgreader 'Microsoft.Graph/appRoleAssignedTo@v1.0' = {
  appRoleId: msGraphOrgReadAllAppRoleId
  principalId: aa_exchange.outputs.aa_exchange_sami
  resourceId: msgraph_sp.id
}
