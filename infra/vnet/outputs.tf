#
# Outputs
#
output "vnet_id" {
  value = azurerm_virtual_network.moleary-vnet.id
}
output "mgmt_subnet_id" {
  value = join("/", [azurerm_virtual_network.moleary-vnet.id, "subnets", "mgmt"])
}
output "internal_subnet_id" {
  value = join("/", [azurerm_virtual_network.moleary-vnet.id, "subnets", "internal"])
}
output "external_subnet_id" {
  value = join("/", [azurerm_virtual_network.moleary-vnet.id, "subnets", "external"])
}
output "rg_name" {
  value = azurerm_resource_group.rg.name
}
output "rg_location" {
  value = azurerm_resource_group.rg.location
}
output "mgmt_subnet_prefix" {
  value = var.mgmt_subnet_prefix
}
output "external_subnet_prefix" {
  value = var.external_subnet_prefix
}
output "internal_subnet_prefix" {
  value = var.internal_subnet_prefix
}