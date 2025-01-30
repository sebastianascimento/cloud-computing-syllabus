resource "kubernetes_namespace" "client_namespace" {
  for_each = toset(var.clients)

  metadata {
    name = "${each.value}-${var.environment}"
  }
}

resource "kubernetes_ingress_v1" "odoo_https" {
  for_each = toset(var.clients)

  metadata {
    name      = "odoo-ingress-${each.value}"
    namespace = kubernetes_namespace.client_namespace[each.key].metadata[0].name
  }

  spec {
    tls {
      secret_name = "odoo-tls-secret"
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
              name = "odoo-service"
              port {
                number = 8069
              }
            }
          }
        }
      }
    }
  }

  depends_on = [kubernetes_namespace.client_namespace]
}
