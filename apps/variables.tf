variable "f5vm01int" {}
variable "f5vm02int" {}
variable "f5vm01ext_sec" {}
variable "f5vm02ext_sec" {}

#Azure SP cred details
variable "client_id" {default = ""}
variable "client_secret" {default = ""}
variable "subscription_id" {default = ""}
variable "tenant_id" {default = ""}

#other variables
variable "prefix" {}
variable "rg_name" {}
variable "upassword" {}

