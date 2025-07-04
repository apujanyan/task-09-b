output "aca_fqdn" {
  description = "ACA FQDN."
  value       = azurerm_container_app.aca.latest_revision_fqdn
}