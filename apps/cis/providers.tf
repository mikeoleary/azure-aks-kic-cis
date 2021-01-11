provider "kubernetes" {
  version = "=1.11.1"
  host                   = "${var.kube_host}"
  client_certificate     = "${var.client_certificate}"
  client_key             = "${var.client_key}"
  cluster_ca_certificate = "${var.cluster_ca_certificate}"
  load_config_file       = false
}

provider "helm" {
  version = "=1.1.1"
  kubernetes {
    host                   = "${var.kube_host}"
    client_certificate     = "${var.client_certificate}"
    client_key             = "${var.client_key}"
    cluster_ca_certificate = "${var.cluster_ca_certificate}"
    load_config_file       = false
  }
}
