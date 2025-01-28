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
}
