#variables for kubernetes provider config
variable kube_host { default = "" }
variable kube_username { default = "" }
variable kube_password { default = "" }
variable client_certificate { default = "" }
variable client_key { default = "" }
variable cluster_ca_certificate { default = "" }

#variables for CIS config
variable f5vm01int { default = ""}
variable f5vm02int { default = ""}
variable upassword { default = ""}
variable "dependencies" {
  type    = "list"
  default = []
}