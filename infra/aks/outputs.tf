
output "client_certificate" {
  value = base64decode(azurerm_kubernetes_cluster.akscluster1.kube_config.0.client_certificate)
}
output "kube_config" {
  value = azurerm_kubernetes_cluster.akscluster1.kube_config
}
output "kube_config_raw" {
  value = azurerm_kubernetes_cluster.akscluster1.kube_config_raw
}
output "kube_host" {
  value = azurerm_kubernetes_cluster.akscluster1.kube_config.0.host
}
output "client_key" {
    value = base64decode(azurerm_kubernetes_cluster.akscluster1.kube_config.0.client_key)
}
output "cluster_ca_certificate" {
    value = base64decode(azurerm_kubernetes_cluster.akscluster1.kube_config.0.cluster_ca_certificate)
}
output "depended_on" {
  value = null_resource.dependency_setter.id
}