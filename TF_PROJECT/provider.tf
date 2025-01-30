terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.11.0"  
    }
    minikube = {
      source = "scott-the-programmer/minikube"
      version = "0.4.4"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.6"
    }
  }

  backend "local" {}
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "minikube" {
  # Configuration options
}

provider "tls" {
  # Configuration options
}