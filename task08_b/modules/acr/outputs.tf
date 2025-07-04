output "acr_login_server" {
  description = "ACR login server."
  value       = azurerm_container_registry.this.login_server
}

output "acr_id" {
  description = "ACR ID."
  value       = azurerm_container_registry.this.id
}
