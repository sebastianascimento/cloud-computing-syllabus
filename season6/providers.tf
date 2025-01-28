provider "kubernetes" {
  host = minikube_cluster.example.host
  client_certificate = minikube_cluster.example.client_certificate
  client_key = minikube_cluster.example.client_key
  cluster_ca_certificate = minikube_cluster.example.cluster_ca_certificate
}