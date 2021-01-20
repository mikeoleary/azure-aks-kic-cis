# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  features {}
  subscription_id = var.SP["subscription_id"]
  tenant_id	    = var.SP["tenant_id"]
  client_id	    = var.SP["client_id"]
  client_secret   = var.SP["client_secret"]
}

terraform {
  required_providers {
    azurerm = {
      # The "hashicorp" namespace is the new home for the HashiCorp-maintained
      # provider plugins.
      #
      # source is not required for the hashicorp/* namespace as a measure of
      # backward compatibility for commonly-used providers, but recommended for
      # explicitness.
      source  = "hashicorp/azurerm"
      version = "~> 2.0.0"
    }
  }
}