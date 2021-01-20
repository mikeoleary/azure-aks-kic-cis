#AKS outputs
#output "client_certificate" { value = module.aks.client_certificate}
output "kube_config" {  value = module.aks.kube_config}
output "kube_config_raw" {  value = module.aks.kube_config_raw}

#BIGIP outputs
output "vm01mgmtpip" {  value = module.bigip.vm01mgmtpip}
output "vm02mgmtpip" {  value = module.bigip.vm02mgmtpip}

#Verification outputs

output "appUrl" {  value = "http://${module.bigip.lbpip}/" }