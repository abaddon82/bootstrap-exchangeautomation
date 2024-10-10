terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">=4.4.0"
    }
    time = {
        source = "hashicorp/time"
        version = ">=0.12.1"
    }
  }

    /*backend "local" {
      path = "./terraform.tfstate"
    }*/

}

provider "azurerm" {
    features {}
    subscription_id = var.subscription_id
}