#Confinger a service account for tiller
resource "kubernetes_cluster_role_binding" "tiller" {
  metadata {
    name = "tiller"
  }

  subject {
    kind = "User"
    name = "system:serviceaccount:kube-system:tiller"
  }

  role_ref {
    kind  = "ClusterRole"
    name = "cluster-admin"
    api_group="rbac.authorization.k8s.io"
  }
} 

resource "kubernetes_service_account" "tiller" {
  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }
  automount_service_account_token = true
}
resource "kubernetes_secret" "f5cis" {
  metadata {
    name = "f5cis"
    namespace = "kube-system"
  }

  data = {
    username = "admin"
    password = "${var.upassword}"
  }
}

data "helm_repository" "f5-stable" {
  name = "f5-stable"
  url  = "https://f5networks.github.io/charts/stable"
}

resource "helm_release" "f5cis" {
  name  = "f5cis"
  chart = "f5-stable/f5-bigip-ctlr"

  set {
    name  = "args.bigip_url"
    value = "${var.f5vm01int}"  
  }
  set {
    name  = "args.bigip_partition"
    value = "kubernetes"  
  }
  set {
    name  = "args.insecure"
    value = "true"  
  }
  set {
    name = "args.agent"
    value = "as3"
  }
  set {
    name  = "bigip_login_secret"
    value = "${kubernetes_secret.f5cis.metadata[0].name}"
  }
  set {
    name  = "args.pool-member-type"
    value = "cluster"
  }
  depends_on = [
    "kubernetes_service_account.tiller", 
    "kubernetes_cluster_role_binding.tiller",
    "kubernetes_secret.f5cis"
  ]
}
resource "helm_release" "f5cis2" {
  name  = "f5cis2"
  chart = "f5-stable/f5-bigip-ctlr"

  set {
    name  = "args.bigip_url"
    value = "${var.f5vm02int}"  
  }
  set {
    name  = "args.bigip_partition"
    value = "kubernetes"  
  }
    set {
    name  = "args.insecure"
    value = "true"  
  }
  set {
    name  = "bigip_login_secret"
    value = "${kubernetes_secret.f5cis.metadata[0].name}"
  }
  set {
    name  = "args.pool-member-type"
    value = "cluster"
  }
  depends_on = [
    "kubernetes_service_account.tiller", 
    "kubernetes_cluster_role_binding.tiller",
    "kubernetes_secret.f5cis"
  ]
}

resource "null_resource" "dependency_setter" {
  depends_on = [
    "helm_release.f5cis",
    "helm_release.f5cis2"
  ]
}
