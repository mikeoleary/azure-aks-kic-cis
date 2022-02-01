#AKS outputs
#output "client_certificate" { value = module.aks.client_certificate}
output "kube_config" {  
    value = module.aks.kube_config
    sensitive = true
    }
output "kube_config_raw" {  
    value = module.aks.kube_config_raw
    sensitive = true
    }

#BIGIP outputs
output "vm01mgmtpip" {  value = module.bigip.vm01mgmtpip}
output "vm02mgmtpip" {  value = module.bigip.vm02mgmtpip}

#Verification outputs

output "appUrl" {  value = "http://${module.bigip.lbpip}/" }
output "appUrl_secure" {  value = "https://${module.bigip.lbpip}/" }
output "app-vip" {  value = module.bigip.lbpip }
output "dns-listener-vip" {  value = module.bigip.lbpip2 }
