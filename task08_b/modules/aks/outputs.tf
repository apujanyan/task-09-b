output "kube_config" {
  value = {
    host                   = azurerm_kubernetes_cluster.this.kube_config[0].host
    client_certificate     = azurerm_kubernetes_cluster.this.kube_config[0].client_certificate
    client_key             = azurerm_kubernetes_cluster.this.kube_config[0].client_key
    cluster_ca_certificate = azurerm_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate
  }
  sensitive = true
}

output "node_resource_group" {
  description = "AKS node resource group name"
  value       = azurerm_kubernetes_cluster.this.node_resource_group
}

output "kubelet_identity_object_id" {
  description = "AKS identity"
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}
output "aks_managed_identity_id" {
  description = "AKS SystemAssigned Managed Identity ID"
  value       = azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity[0].client_id
}

output "aks_kv_access_identity_id" {
  description = "AKS Key Vault access identity ID."
  value       = azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity[0].client_id
}