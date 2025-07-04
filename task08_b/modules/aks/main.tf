resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.name

  default_node_pool {
    name            = var.default_node_pool_name
    node_count      = var.default_node_pool_count
    vm_size         = var.default_node_pool_size
    os_disk_type    = var.default_node_pool_disk_type
    os_disk_size_gb = 64
    node_labels = {
      "name" = "value"
    }
  }
  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.aks_agent_identity.id
    ]
  }

  tags = var.tags
}

resource "azurerm_user_assigned_identity" "aks_agent_identity" {
  name                = "${var.name}-pool"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "acr_pull_role" {
  scope                            = var.acr_id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
  skip_service_principal_aad_check = true
}

resource "azurerm_key_vault_access_policy" "aks_key_vault_access" {
  key_vault_id = var.keyvault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity[0].object_id

  secret_permissions = [
    "Get", "List", "Set", "Delete", "Purge", "Recover", "Backup", "Restore"
  ]
  depends_on = [azurerm_kubernetes_cluster.this]
}

data "azurerm_client_config" "current" {}