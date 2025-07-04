resource "random_password" "redis" {
  length  = 16
  special = true
}

resource "azurerm_container_group" "redis" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  ip_address_type     = "Public"
  dns_name_label      = var.name
  sku                 = var.sku

  tags = var.tags

  container {
    name   = "redis"
    image  = "mcr.microsoft.com/cbl-mariner/base/redis:6.2-cm2.0"
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 6379
      protocol = "TCP"
    }

    commands = [
      "redis-server",
      "--protected-mode", "no",
      "--requirepass", random_password.redis.result
    ]
  }
}

resource "azurerm_key_vault_secret" "redis_password" {
  name         = var.redis_password_secret_name
  value        = random_password.redis.result
  key_vault_id = var.key_vault_id

  tags = var.tags

  depends_on = [azurerm_container_group.redis]
}

resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = var.redis_hostname_secret_name
  value        = azurerm_container_group.redis.fqdn
  key_vault_id = var.key_vault_id

  tags = var.tags

  depends_on = [azurerm_container_group.redis]
}