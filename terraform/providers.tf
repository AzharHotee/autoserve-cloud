terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Start with local state. You can later move to a remote backend in Azure Storage.
  # backend "azurerm" {}
}

provider "azurerm" {
  features {}
  subscription_id = "383b2e80-4f8c-4edb-b145-99f1ebc1f2d6"
}

