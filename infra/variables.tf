#Azure SP cred details
variable "client_id" {default = ""}
variable "client_secret" {default = ""}
variable "subscription_id" {default = ""}
variable "tenant_id" {default = ""}
#BIG-IP variables
variable "prefix" {default = "mydemo"}
variable "uname" {default = "azureuser"}
variable "upassword" {default = "DefaultPass12345!"}
variable "location" {default = "East US 2"}
#Network variables
variable "network_cidr" {default = "10.0.0.0/16"}
variable "mgmt_subnet_prefix" {default = "10.0.1.0/24"}
variable "external_subnet_prefix" {default = "10.0.2.0/24"}
variable "internal_subnet_prefix" {default = "10.0.3.0/24"}
