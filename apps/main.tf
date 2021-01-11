data "azurerm_kubernetes_cluster" "akscluster" {
  name                = "${var.prefix}-akscluster1"
  resource_group_name = "${var.rg_name}"
}

module "cis" {
  source = "./cis"
  #variables for kubernetes provider
  kube_host              = "${data.azurerm_kubernetes_cluster.akscluster.kube_config.0.host}"
  client_certificate     = "${base64decode(data.azurerm_kubernetes_cluster.akscluster.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(data.azurerm_kubernetes_cluster.akscluster.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(data.azurerm_kubernetes_cluster.akscluster.kube_config.0.cluster_ca_certificate)}"

  #variables for CIS configuration
  f5vm01int = "${var.f5vm01int}"
  f5vm02int = "${var.f5vm02int}"
  upassword = "${var.upassword}"
}

module "azureVoteApp" {
  source = "./azureVoteApp"
  #variables for kubernetes provider
  kube_host              = "${data.azurerm_kubernetes_cluster.akscluster.kube_config.0.host}"
  client_certificate     = "${base64decode(data.azurerm_kubernetes_cluster.akscluster.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(data.azurerm_kubernetes_cluster.akscluster.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(data.azurerm_kubernetes_cluster.akscluster.kube_config.0.cluster_ca_certificate)}"

  #variables for k8s app
  f5vm01ext_sec = "${var.f5vm01ext_sec}"
  f5vm02ext_sec = "${var.f5vm02ext_sec}"

  dependencies = [
    "${module.cis.depended_on}",
  ]
}
