data "azuread_application_published_app_ids" "well_known" {}

data "azuread_service_principal" "msgraph_sp" {
  client_id = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]
}

data "azuread_service_principal" "exo_sp" {
  client_id = data.azuread_application_published_app_ids.well_known.result["Office365ExchangeOnline"]
}

resource "azuread_app_role_assignment" "exoadmin_ara" {
  resource_object_id = data.azuread_service_principal.exo_sp.object_id
  app_role_id = local.appRoles.exchangeOnlineAdministrator
  principal_object_id = var.aa_sami_id
}

resource "azuread_app_role_assignment" "orgreader_ara" {
  resource_object_id = data.azuread_service_principal.msgraph_sp.object_id
  app_role_id = local.appRoles.msGraphOrgReadAll
  principal_object_id = var.aa_sami_id
}

resource "azuread_directory_role_assignment" "exoadmin_dra" {
  role_id = local.directoryRoles.exchangeAdministrator
  principal_object_id = var.aa_sami_id
}