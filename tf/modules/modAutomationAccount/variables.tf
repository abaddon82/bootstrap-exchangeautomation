variable "location" {
  type = string
  description = "Azure region where the Automation Account is to be placed"
  default = "norwayeast"
}

variable "aaName" {
    type = string
    description = "Name of Automation Account"
    default = "aa-exchangeautomationaccount"
}

variable "aaSku" {
  type = string
  description = "SKU level of Automation Account"
  default = "Basic"
}

variable "resourceGroupName" {
  type = string
  description = "Resource Group in which the Automation Account will be created"
  default = "rg-exchangeautomation"
}

variable "exModuleVersion" {
  type = string
  description = "Version of the Exchange Online Management module to use"
  default = "3.6.0"
}

variable "msGraphModuleVersion" {
  type = string
  description = "Version of the Microsoft.Graph module to use"
  default = "2.24.0"
}