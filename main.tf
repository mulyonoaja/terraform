
provider "kind" {}

resource "kind_cluster" "primary" {
  name           = "kind-kluster-multinode"
  wait_for_ready = true
  
  # PAKSA MENGGUNAKAN IMAGE K8S MODERN YANG COCOK DENGAN WINDOWS/CGROUP V2
  node_image     = "kindest/node:v1.31.0" 

  kind_config {
    api_version = "kind.x-k8s.io/v1alpha4"
    kind        = "Cluster"
    networking {
      api_server_address = "127.0.0.1"
    }

    node { role = "control-plane" }
    node { role = "worker" }
    node { role = "worker" }
    node { role = "worker" }
  }
}


# # =================================================================
# # 2. BIKIN APLIKASI DI DALAMNYA (Kode yang Anda punya sebelumnya)
# # =================================================================
# # 1. Membuat Namespace terisolasi
# resource "kubernetes_namespace" "jarvis_app" {
#   metadata {
#     name = "jarvis-environment"
#   }
# }

# # 2. Membuat Deployment Aplikasi (Kontainer)
# resource "kubernetes_deployment" "nginx_app" {
#   metadata {
#     name      = "jarvis-web-deployment"
#     namespace = kubernetes_namespace.jarvis_app.metadata[0].name
#     labels = {
#       app = "jarvis-web"
#     }
#   }

#   spec {
#     replicas = 2 # Menjalankan 2 kontainer sekaligus untuk redundancy

#     selector {
#       match_labels = {
#         app = "jarvis-web"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "jarvis-web"
#         }
#       }

#       spec {
#         container {
#           name  = "web-container"
#           image = "nginx:alpine" # Menggunakan image ringan agar hemat kuota & RAM

#           # Pengaturan Resource Limits (Praktik terbaik agar laptop tidak crash/lag)
#           resources {
#             limits = {
#               cpu    = "0.5"
#               memory = "256Mi"
#             }
#             requests = {
#               cpu    = "0.2"
#               memory = "128Mi"
#             }
#           }

#           port {
#             container_port = 80
#           }
#         }
#       }
#     }
#   }
# }

# # 3. Membuat Service untuk mengekspos aplikasi ke browser Laptop
# resource "kubernetes_service" "nginx_service" {
#   metadata {
#     name      = "jarvis-web-service"
#     namespace = kubernetes_namespace.jarvis_app.metadata[0].name
#   }

#   spec {
#     selector = {
#       app = kubernetes_deployment.nginx_app.metadata[0].labels.app
#     }

#     port {
#       port        = 80
#       target_port = 80
#       node_port   = 30080 # Anda bisa akses aplikasi via http://localhost:30080
#     }

#     type = "NodePort"
#   }
# }
