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
            name  = "DB_HOST"
            value = "db"  
          }

          env {
            name  = "DB_PORT"
            value = "5432"  
          }

          env {
            name  = "DB_USER"
            value = "odoo"  
          }

          env {
            name  = "DB_PASSWORD"
            value = "password"  
          }

          env {
            name  = "DB_NAME"
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

resource "kubernetes_service" "db_service" {
  for_each = toset(var.clients)

  metadata {
    name      = "db"
    namespace = kubernetes_namespace.client_namespace[each.key].metadata[0].name
    labels = {
      app = "db"
    }
  }

  spec {
    selector = {
      app = "db"
    }

    port {
      port        = 5432
      target_port = 5432
    }
  }
}

resource "kubernetes_deployment" "db" {
  for_each = toset(var.clients)

  metadata {
    name      = "db"
    namespace = kubernetes_namespace.client_namespace[each.key].metadata[0].name
    labels = {
      app = "db"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "db"
      }
    }

    template {
      metadata {
        labels = {
          app = "db"
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
            value = "password"
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

    type = "ClusterIP"  
  }
}

