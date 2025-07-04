output "redis_password" {
  description = "Redis password."
  value       = random_password.redis.result
  sensitive   = true
}

output "redis_fqdn" {
  description = "Redis FQDN."
  value       = azurerm_container_group.redis.fqdn
}

output "redis_password_secret_id" {
  description = "Redis password secret ID."
  value       = azurerm_key_vault_secret.redis_password.id
}

output "redis_hostname_secret_id" {
  description = "Redis hostname secret ID."
  value       = azurerm_key_vault_secret.redis_hostname.id
}