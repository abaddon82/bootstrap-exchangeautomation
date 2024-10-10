variable "location" {
  type = string
  description = "Azure region where the Resource Group and Automation Account is to be placed"
  default = "norwayeast"
}

variable "resourceGroupName" {
  type = string
  description = "Name of the Resource Group that will be created and contain the Automation Account"
  default = "rg-exchangeautomation"
}

variable "aaName" {
    type = string
    description = "Name of Automation Account"
    default = "aa-exchangeautomationaccount"
}

variable "subscription_id" {
    type = string
    description = "Subscription ID where the solution should be deployed"
}