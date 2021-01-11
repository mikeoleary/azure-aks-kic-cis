resource "null_resource" "dependency_getter" {
  provisioner "local-exec" {
    command = "sleep 20 && echo ${length(var.dependencies)}"
  }
}

#Create namespace
resource "kubernetes_namespace" "azurevote" {
  metadata {
    name = "azurevote"
  }
  depends_on    = ["null_resource.dependency_getter"]
}

#Deploy AzureVote App
resource "kubernetes_deployment" "azurevote-backend-deployment" {
  metadata {
    name = "azure-vote-back"
    labels = {
      app = "azure-vote-back"
    }
    namespace = "azurevote"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "azure-vote-back"
      }
    }
    template {
      metadata {
        labels = {
          app = "azure-vote-back"
        }
      }
      spec {
        container {
          image = "redis"
          name  = "azure-vote-back"

          port {
            container_port = 6379
          }
        }
      }
    }
  }
  depends_on    = ["null_resource.dependency_getter"]
}

resource "kubernetes_service" "azure-vote-back" {
  metadata {
    name = "azure-vote-back"
    labels = {
      app = kubernetes_deployment.azurevote-backend-deployment.spec.0.template.0.metadata[0].labels.app
    }
    namespace = "azurevote"
  }
  spec {
    selector = {
      app = kubernetes_deployment.azurevote-backend-deployment.spec.0.template.0.metadata[0].labels.app
    }
    port {
      port        = 6379
    }
    type = "ClusterIP"
  }
  depends_on    = ["null_resource.dependency_getter"]
}
resource "kubernetes_deployment" "azurevote-frontend-deployment" {
  metadata {
    name = "azure-vote-front"
    labels = {
      app = "azure-vote-front"
    }
    namespace = "azurevote"
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "azure-vote-front"
      }
    }
    template {
      metadata {
        labels = {
          app = "azure-vote-front"
        }
      }
      spec {
        container {
          image = "microsoft/azure-vote-front:v1"
          name  = "azure-vote-front"

          port {
            container_port = 80
          }
          env {
            name = "REDIS"
            value = "azure-vote-back"
          }
        }
      }
    }
  }
  depends_on = [
    "kubernetes_service.azure-vote-back"
  ]
}

resource "kubernetes_service" "azure-vote-front" {
  metadata {
    name = "azure-vote-front"
    labels = {
      app = kubernetes_deployment.azurevote-frontend-deployment.spec.0.template.0.metadata[0].labels.app
      "cis.f5.com/as3-pool" = "azurevote_pool"
      "cis.f5.com/as3-tenant" = "azurevote"
      "cis.f5.com/as3-app" = "azurevote"
    }
    namespace = "azurevote"
  }
  spec {
    selector = {
      app = kubernetes_deployment.azurevote-frontend-deployment.spec.0.template.0.metadata[0].labels.app
    }
    port {
      port        = 80
    }
    type = "ClusterIP"
  }
}

data "template_file" "azurevote_configmap" {
  template = "${file("./${path.module}/azurevote.configmap.example")}"
  vars = {
    private_ip1 = "${var.f5vm01ext_sec}"
    private_ip2 = "${var.f5vm02ext_sec}"
  }
  depends_on    = ["null_resource.dependency_getter"]
}

# deploy Kubernetes ConfigMap resource
resource "kubernetes_config_map" "azurevote" {
  metadata {
    name = "azurevote"
    namespace= "azurevote"
    labels = {
      f5type= "virtual-server"
      as3= "true"
    }
  }
  data = {
    template = "${data.template_file.azurevote_configmap.rendered}"
  }
  depends_on = [
    "kubernetes_service.azure-vote-front",
    "kubernetes_service.azure-vote-back"
  ]
}
