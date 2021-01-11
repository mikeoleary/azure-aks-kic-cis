#
# Variables Configuration
#
variable "location" {
  default = ""
}
variable "rg_name" {
  default = ""
}
variable "int_subnet_id" {
  default = ""
}
variable "service_cidr" {
  default = ""
}
variable "dns_service_ip" {
  default = ""
}
variable "docker_bridge_cidr" {
  default = ""
}
variable "prefix" {}
variable "admin_username" {}
variable "admin_password" {}
#variables for AzureRM provider
variable "client_id" {  default = ""}
variable "subscription_id" {  default = ""}
variable "tenant_id" {  default = ""}
variable "client_secret" {  default = ""}
