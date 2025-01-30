resource "kubernetes_namespace" "client_namespace" {
  for_each = toset(var.clients)

  metadata {
    name = "${each.value}-${var.environment}"
  }
}

