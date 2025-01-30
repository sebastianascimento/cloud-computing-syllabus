resource "kubernetes_deployment" "odoo" {
  for_each = toset(var.clients)

  metadata {
    name      = "odoo-deployment"
    namespace = kubernetes_namespace.client_namespace[each.key].metadata[0].name
    labels = {
      app = "odoo"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "odoo"
      }
    }

    template {
      metadata {
        labels = {
          app = "odoo"
        }
      }

      spec {
        container {
          name  = "odoo"
          image = "odoo:14"

          env {
            name  = "HOST"
            value = "postgres-service"  
          }

          env {
            name  = "PORT"
            value = "5432"
          }

          env {
            name  = "USER"
            value = "odoo"
          }

          env {
            name  = "PASSWORD"
            value = "password1"
          }

          env {
            name  = "NAME"
            value = "odoo_db"
          }

          port {
            container_port = 8069
          }
        }
      }
    }
  }

  depends_on = [kubernetes_namespace.client_namespace]
}

resource "kubernetes_service" "odoo_service" {
  for_each = toset(var.clients)

  metadata {
    name      = "odoo-service"
    namespace = kubernetes_namespace.client_namespace[each.key].metadata[0].name
    labels = {
      app = "odoo"
    }
  }

  spec {
    selector = {
      app = "odoo"
    }

    port {
      port        = 8069
      target_port = 8069
    }

    type = "NodePort"
  }

  depends_on = [kubernetes_deployment.odoo]
}

resource "kubernetes_secret" "odoo_tls_secret" {
  for_each = toset(var.clients)

  metadata {
    name      = "odoo-tls-secret"
    namespace = kubernetes_namespace.client_namespace[each.key].metadata[0].name
  }

  data = {
    "tls.crt" = filebase64("${path.module}/tls/cert.crt")  # Caminho para o seu certificado
    "tls.key" = filebase64("${path.module}/tls/cert.key")  # Caminho para sua chave privada
  }

  type = "kubernetes.io/tls"
  
  depends_on = [kubernetes_service.odoo_service]
}

resource "kubernetes_ingress_v1" "odoo_https" {
  for_each = toset(var.clients)

  metadata {
    name      = "odoo-ingress-${each.value}"
    namespace = kubernetes_namespace.client_namespace[each.key].metadata[0].name
  }

  spec {
    tls {
      secret_name = kubernetes_secret.odoo_tls_secret[each.key].metadata[0].name
      hosts       = ["odoo-${each.value}.example.com"]
    }

    rule {
      host = "odoo-${each.value}.example.com"
      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.odoo_service[each.key].metadata[0].name
              port {
                number = 8069
              }
            }
          }
        }
      }
    }
  }

  depends_on = [kubernetes_service.odoo_service]
}
