resource "kubernetes_deployment" "db" {
  for_each = toset(var.clients)

  metadata {
    name      = "postgres-deployment"
    namespace = kubernetes_namespace.client_namespace[each.key].metadata[0].name
    labels = {
      app = "postgres"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "postgres"
      }
    }

    template {
      metadata {
        labels = {
          app = "postgres"
        }
      }

      spec {
        container {
          name  = "postgres"
          image = "postgres:14"

          env {
            name  = "POSTGRES_USER"
            value = "odoo"
          }

          env {
            name  = "POSTGRES_PASSWORD"
            value = "password1"
          }

          env {
            name  = "POSTGRES_DB"
            value = "odoo_db"
          }

          port {
            container_port = 5432
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "postgres_service" {
  for_each = toset(var.clients)

  metadata {
    name      = "postgres-service"
    namespace = kubernetes_namespace.client_namespace[each.key].metadata[0].name
    labels = {
      app = "postgres"
    }
  }

  spec {
    selector = {
      app = "postgres"
    }

    port {
      port        = 5432
      target_port = 5432
    }
  }
}

