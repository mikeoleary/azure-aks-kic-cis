# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.0.0"
  features {}
  subscription_id = "${var.subscription_id}"
  tenant_id	    = "${var.tenant_id}"
  client_id	    = "${var.client_id}"
  client_secret   = "${var.client_secret}"
}