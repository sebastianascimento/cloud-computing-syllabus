provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "dev" {
  metadata {
    name = "development"
  }
}

resource "kubernetes_namespace" "prod" {
  metadata {
    name = "production"
  }
}