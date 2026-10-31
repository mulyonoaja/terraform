terraform {
  required_providers {
    #Jika cluster sdh ready
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.7" # Izinkan Terraform mencari versi 0.7 ke atas yang mendukung multiplatform
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.38" # Menggunakan kubernetes terinstal di laptop Anda
    }
  }
}

provider "kubernetes" {
  host                   = kind_cluster.primary.endpoint
  client_certificate     = kind_cluster.primary.client_certificate
  client_key             = kind_cluster.primary.client_key
  cluster_ca_certificate = kind_cluster.primary.cluster_ca_certificate
  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
}


