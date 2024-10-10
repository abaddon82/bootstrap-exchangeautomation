// Create Resource Group for Automation Account to live in
resource "azurerm_resource_group" "exchangeautomation" {
  name = var.resourceGroupName
  location = var.location
}

// Create Automation Account and initialize with testing Runbook
module "aa_exchange" {
  source = "./modules/modAutomationAccount"
  aaName = var.aaName
  location = azurerm_resource_group.exchangeautomation.location
  resourceGroupName = azurerm_resource_group.exchangeautomation.name
}

// Add small wait time to allow for Enterprise App and Service Principal synchronization
resource "time_sleep" "wait_enterprise_app" {
  create_duration = "30s"
  triggers = {
    sami_id = module.aa_exchange.aa_exchange_sami
  }
}

// Assign permissions to the System Assigned Managed Identity of the Automation Account
module "aa_sami_permission" {
  source = "./modules/modPermissionManagement"
  aa_sami_id = time_sleep.wait_enterprise_app.triggers["sami_id"]
}

output "automation_account_name" {
  value = module.aa_exchange.aa_name
}