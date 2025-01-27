variable "clients" {
  description = "Lista de clientes"
  type        = list(string)
  default     = ["netflix", "meta", "rockstar"]
}

variable "environment" {
  description = "Ambiente (dev, qa, prod)"
  type        = string
  default     = "dev"
}

variable "client_config" {
  description = "Configurações específicas de cada cliente"
  type = map(object({
    db_user     = string
    db_password = string
    db_name     = string
    db_host     = string
  }))
  default = {
    "netflix" = {
      db_user     = "netflix_user"
      db_password = "netflix_password"
      db_name     = "netflix_db"
      db_host     = "db_netflix"
    },
    "meta" = {
      db_user     = "meta_user"
      db_password = "meta_password"
      db_name     = "meta_db"
      db_host     = "db_meta"
    },
    "rockstar" = {
      db_user     = "rockstar_user"
      db_password = "rockstar_password"
      db_name     = "rockstar_db"
      db_host     = "db_rockstar"
    }
  }
}
