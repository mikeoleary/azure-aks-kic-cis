resource "azurerm_kubernetes_cluster" "akscluster1" {
  name                = "${var.prefix}-akscluster1"
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = "${var.prefix}-akscluster1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
    vnet_subnet_id = var.int_subnet_id
  }
  network_profile {
    network_plugin = "azure"
    dns_service_ip = var.dns_service_ip
    docker_bridge_cidr = var.docker_bridge_cidr
    service_cidr = var.service_cidr
  }
  node_resource_group = "${var.rg_name}-aks-resources"
  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
  windows_profile {
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
}
resource "null_resource" "dependency_setter" {
  depends_on = [
    azurerm_kubernetes_cluster.akscluster1
  ]
}

