provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Namespace for Monitoring
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

# Prometheus Helm Chart
resource "helm_release" "prometheus" {
  name       = "prometheus"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  chart      = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"

  values = [
    yamlencode({
      serviceAccount = {
        create = true
      }
      server = {
        service = {
          type = "NodePort"
        }
      }
    })
  ]
}

# Grafana Helm Chart
resource "helm_release" "grafana" {
  name       = "grafana"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  chart      = "grafana"
  repository = "https://grafana.github.io/helm-charts"

  values = [
    yamlencode({
      adminUser     = "admin"
      adminPassword = "admin"
      service = {
        type = "NodePort"
      }
    })
  ]
}
