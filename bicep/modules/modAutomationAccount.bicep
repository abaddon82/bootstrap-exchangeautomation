@description('Azure region where the Automation Account is to be placed')
param location string

@description('Name of Automation Account')
param aaName string

@description('SKU level of Automation Account')
@allowed(['Basic', 'Free'])
param aaSku string = 'Free'

@description('Version of the Exchange Online Management module to use')
param exModuleVersion string = '3.6.0'

@description('Version of the Microsoft.Graph module to use')
param msGraphModuleVersion string = '2.24.0'

var testScriptUrl = 'https://raw.githubusercontent.com/abaddon82/bootstrap-exchangeautomation/refs/heads/main/runbooks/Test-ExchangeConnectivity.ps1'

resource aa_exchange 'Microsoft.Automation/automationAccounts@2023-11-01' = {
  name: aaName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    sku: {
      name: aaSku
    }
    publicNetworkAccess: true
  }
}

resource runbook_exchange 'Microsoft.Automation/automationAccounts/runbooks@2023-11-01' = {
  parent: aa_exchange
  location: location
  name: 'Exchange Test Runbook'
  properties: {
    runbookType: 'PowerShell'
    publishContentLink: {
      uri: testScriptUrl
    }
    logProgress: false
    logVerbose: false
  }
}

resource aa_exchangemgmt_module 'Microsoft.Automation/automationAccounts/modules@2023-11-01' = {
  parent: aa_exchange
  location: location
  name: 'ExchangeOnlineManagement'
  properties: {
    contentLink: {
      uri: 'https://www.powershellgallery.com/api/v2/package/ExchangeOnlineManagement/${exModuleVersion}'
    }
  }
}

resource aa_msgraph_module 'Microsoft.Automation/automationAccounts/modules@2023-11-01' = {
  parent: aa_exchange
  name: 'Microsoft.Graph'
  properties: {
    contentLink: {
      uri: 'https://www.powershellgallery.com/api/v2/package/Microsoft.Graph/${msGraphModuleVersion}'
    }
  }
}

resource aa_msgraphauth_module 'Microsoft.Automation/automationAccounts/modules@2023-11-01' = {
  parent: aa_exchange
  name: 'Microsoft.Graph.Authentication'
  properties: {
    contentLink: {
      uri: 'https://www.powershellgallery.com/api/v2/package/Microsoft.Graph.Authentication/${msGraphModuleVersion}'
    }
  }
}

resource aa_msgraphdirman_module 'Microsoft.Automation/automationAccounts/modules@2023-11-01' = {
  parent: aa_exchange
  name: 'Microsoft.Graph.Identity.DirectoryManagement'
  properties: {
    contentLink: {
      uri: 'https://www.powershellgallery.com/api/v2/package/Microsoft.Graph.Identity.DirectoryManagement/${msGraphModuleVersion}'
    }
  }
}

output aa_exchange string = aa_exchange.id
output aa_exchange_sami string = aa_exchange.identity.principalId
