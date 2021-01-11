output "vm01mgmtpip" {
  value = data.azurerm_public_ip.vm01mgmtpip.ip_address
}
output "vm02mgmtpip" {
  value = data.azurerm_public_ip.vm02mgmtpip.ip_address
}
output "lbpip" {value = data.azurerm_public_ip.lbpip.ip_address}

