  provider "minikube" {
}

resource "minikube_cluster" "example" {
  cluster_name = "example_cluster"
  nodes=2
}