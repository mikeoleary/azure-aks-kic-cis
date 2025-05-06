resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_virtual_network" "moleary-vnet" {
  name                = "${var.rg_name}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.network_cidr]

  subnet {
    name           = "mgmt"
    address_prefixes = [var.mgmt_subnet_prefix]
  }

  subnet {
    name           = "external"
    address_prefixes = [var.external_subnet_prefix]
  }

  subnet {
    name           = "internal"
    address_prefixes = [var.internal_subnet_prefix]
#    security_group = azurerm_network_security_group.example.id
  }
}
