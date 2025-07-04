resource "azurerm_user_assigned_identity" "aca_identity" {
  name                = "aca-identity"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = azurerm_user_assigned_identity.aca_identity.principal_id
  role_definition_name = "AcrPull"
  scope                = var.acr_id

  depends_on = [azurerm_user_assigned_identity.aca_identity]
}

resource "azurerm_key_vault_access_policy" "aca_kv_policy" {
  key_vault_id = var.key_vault_id
  tenant_id    = azurerm_user_assigned_identity.aca_identity.tenant_id
  object_id    = azurerm_user_assigned_identity.aca_identity.principal_id

  secret_permissions = ["Get"]
}

resource "azurerm_container_app_environment" "aca_env" {
  name                = var.aca_env_name
  location            = var.location
  resource_group_name = var.resource_group_name

  workload_profile {
    name                  = "Consumption"
    workload_profile_type = var.aca_env_workload_profile_type
  }

  infrastructure_subnet_id = null

  tags = var.tags
}

resource "azurerm_container_app" "aca" {
  name                         = var.aca_name
  container_app_environment_id = azurerm_container_app_environment.aca_env.id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aca_identity.id]
  }

  registry {
    identity = azurerm_user_assigned_identity.aca_identity.id
    server   = var.acr_login_server
  }

  secret {
    name                = "redis-url"
    key_vault_secret_id = var.redis_hostname_secret_id
    identity            = azurerm_user_assigned_identity.aca_identity.id
  }

  secret {
    name                = "redis-key"
    key_vault_secret_id = var.redis_password_secret_id
    identity            = azurerm_user_assigned_identity.aca_identity.id
  }

  template {
    container {
      name   = "redis-flask-app"
      image  = "${var.acr_login_server}/${var.docker_image_name}"
      cpu    = "0.5"
      memory = "1.0Gi"

      env {
        name        = "REDIS_URL"
        secret_name = "redis-url"
      }

      env {
        name        = "REDIS_PWD"
        secret_name = "redis-key"
      }

      env {
        name  = "REDIS_PORT"
        value = "6379"
      }

      env {
        name  = "CREATOR"
        value = "ACA"
      }
    }
  }

  ingress {
    external_enabled = true
    target_port      = 8080
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  depends_on = [azurerm_role_assignment.acr_pull]
}

data "azurerm_client_config" "current" {}