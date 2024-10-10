resource "azurerm_automation_account" "aa_exchange" {
  resource_group_name = var.resourceGroupName
  name = var.aaName
  sku_name = var.aaSku
  location = var.location
  public_network_access_enabled = true
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_automation_runbook" "runbook_exchange" {
  automation_account_name = azurerm_automation_account.aa_exchange.name
  name = "Exchange-Test-Runbook"
  resource_group_name = var.resourceGroupName
  location = var.location
  runbook_type = "PowerShell"
  log_progress = false
  log_verbose = false
  publish_content_link {
    uri = local.testScriptUrl
  }
}

resource "azurerm_automation_module" "aa_exchangemgmt_module" {
  name = "ExchangeOnlineManagement"
  automation_account_name = azurerm_automation_account.aa_exchange.name
  resource_group_name = var.resourceGroupName
  module_link {
    uri = local.exoMgmtModuleUrl
  }
}

resource "azurerm_automation_module" "aa_msgraph_module" {
  name = "Microsoft.Graph"
  automation_account_name = azurerm_automation_account.aa_exchange.name
  resource_group_name = var.resourceGroupName
  module_link {
    uri = local.mgGraphModuleUrl
  }
}

resource "azurerm_automation_module" "aa_msgraphauth_module" {
  name = "Microsoft.Graph.Authentication"
  automation_account_name = azurerm_automation_account.aa_exchange.name
  resource_group_name = var.resourceGroupName
  module_link {
    uri = local.mgGraphAuthModuleUrl
  }
}

resource "azurerm_automation_module" "aa_msgraphdirman_module" {
  name = "Microsoft.Graph.Identity.DirectoryManagement"
  automation_account_name = azurerm_automation_account.aa_exchange.name
  resource_group_name = var.resourceGroupName
  module_link {
    uri = local.mgGraphIdDirMgmtModuleUrl
  }
}

output "aa_name" {
  value = azurerm_automation_account.aa_exchange.name
}

output "aa_exchange_sami" {
  value = azurerm_automation_account.aa_exchange.identity[0].principal_id
}