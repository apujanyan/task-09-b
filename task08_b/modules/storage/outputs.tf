output "storage_account_name" {
  value = azurerm_storage_account.this.name
}

output "container_name" {
  value = azurerm_storage_container.this.name
}

output "blob_url" {
  value = "https://${azurerm_storage_account.this.name}.blob.core.windows.net/${azurerm_storage_container.this.name}/${azurerm_storage_blob.archive.name}"
}

output "sas_token" {
  value     = data.azurerm_storage_account_sas.blob_sas.sas
  sensitive = true
}