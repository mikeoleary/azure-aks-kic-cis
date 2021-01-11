#variable cismetadata {default = ""}
variable f5vm01ext_sec {default = ""}
variable f5vm02ext_sec {default = ""}

#variables for kubernetes provider config
variable kube_host { default = "" }
variable client_certificate { default = "" }
variable client_key { default = "" }
variable cluster_ca_certificate { default = "" }
variable "dependencies" {
  type    = "list"
  default = []
}