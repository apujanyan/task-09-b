resource "azurerm_container_registry" "this" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  admin_enabled                 = true
  public_network_access_enabled = true

  tags = var.tags
}

resource "azurerm_container_registry_task" "build_task" {
  name                  = "build-task"
  container_registry_id = azurerm_container_registry.this.id

  platform {
    os = "Linux"
  }

  docker_step {
    context_path         = var.blob_url
    context_access_token = var.sas_token
    dockerfile_path      = "Dockerfile"
    image_names          = ["${var.docker_image_name}:latest"]
  }

  tags = var.tags

  depends_on = [azurerm_container_registry.this]
}

resource "azurerm_container_registry_task_schedule_run_now" "build_now" {
  container_registry_task_id = azurerm_container_registry_task.build_task.id

  depends_on = [azurerm_container_registry_task.build_task]
}