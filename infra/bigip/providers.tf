# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.0.0"
  features {}
  subscription_id = "${var.SP["subscription_id"]}"
  tenant_id	    = "${var.SP["tenant_id"]}"
  client_id	    = "${var.SP["client_id"]}"
  client_secret   = "${var.SP["client_secret"]}"
}