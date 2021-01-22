
# Obtain Gateway IP for each Subnet
variable "rg_name" {default = ""}
variable "location" {default = ""}
variable "mgmt_subnet_id" {default = ""}
variable "internal_subnet_id" {default = ""}
variable "external_subnet_id" {default = ""}
variable "mgmt_gw" {default = ""}
variable "ext_gw" {default = ""}
variable "int_gw" {default = ""}
#Some BIG-IP variables
variable "prefix" {default = ""}
variable "f5vm01mgmt" {default = ""}
variable "f5vm02mgmt" {default = ""}
variable "f5vm01ext" {default = ""}
variable "f5vm01ext_sec" {default = ""}
variable "f5vm02ext" {default = ""}
variable "f5vm02ext_sec" {default = ""}
variable "f5vm01int" {default = ""}
variable "f5vm02int" {default = ""}

#Variables for onboard.tpl
variable "uname" {default = ""}
variable "upassword" {default = ""}
variable "DO_onboard_URL" {    default = "https://github.com/F5Networks/f5-declarative-onboarding/releases/download/v1.18.0/f5-declarative-onboarding-1.18.0-4.noarch.rpm"}
variable "AS3_URL" {default = "https://github.com/F5Networks/f5-appsvcs-extension/releases/download/v3.25.0/f5-appsvcs-3.25.0-3.noarch.rpm"}
variable "libs_dir" {default = "/config/cloud/azure/node_modules"}
variable "onboard_log" {default = "/var/log/startup-script.log"}

# BIGIP Setup
variable license1	      { default = ""}
variable license2	      { default = ""}
variable host1_name           { default = "f5vm01"}
variable host2_name           { default = "f5vm02"}
variable dns_server           { default = "8.8.8.8" }
variable ntp_server           { default = "0.us.pool.ntp.org" }
variable timezone             { default = "UTC" }

#Service Principal for Azure
variable "SP" {
	type = map(string)
	default = {
		subscription_id = ""
		client_id       = ""
		client_secret   = ""
		tenant_id       = ""
	}
}
# BIGIP Image
variable instance_type	{ default = "Standard_DS4_v2" }
variable image_name	{ default = "f5-bigip-virtual-edition-25m-best-hourly" }
variable product	{ default = "f5-big-ip-best" }
variable bigip_version	{ default = "latest" }

# TAGS
variable purpose        { default = "public"       }
variable environment    { default = "f5env"        }  #ex. dev/staging/prod
variable owner          { default = "f5owner"      }
variable group          { default = "f5group"      }
variable costcenter     { default = "f5costcenter" }
variable application    { default = "f5app"        }
# REST API Setting
variable rest_do_uri { default  = "/mgmt/shared/declarative-onboarding" }
variable rest_do_method { default = "POST" }
variable rest_as3_method { default = "POST" }
variable rest_vm01_do_file {default = "vm01_do_data.json" }
variable rest_vm02_do_file {default = "vm02_do_data.json" }
