terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.19"
    }
  }

  backend "local" {}
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
