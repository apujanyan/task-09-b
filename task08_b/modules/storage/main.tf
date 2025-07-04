resource "azurerm_storage_account" "this" {
  name                     = var.sa_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = var.account_replication_type

  tags = var.tags
}

resource "azurerm_storage_container" "this" {
  name                  = var.sa_container_name
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}

data "archive_file" "app" {
  type        = "tar.gz"
  source_dir  = "${path.module}/../../application"
  output_path = "${path.module}/../../application.tar.gz"
}

resource "azurerm_storage_blob" "archive" {
  name                   = "application.tar.gz"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.this.name
  type                   = "Block"
  source                 = data.archive_file.app.output_path
}

resource "time_static" "sas_start" {}

resource "time_offset" "sas_end" {
  base_rfc3339 = time_static.sas_start.rfc3339
  offset_hours = 3
}

data "azurerm_storage_account_sas" "blob_sas" {
  connection_string = azurerm_storage_account.this.primary_connection_string

  https_only = true
  start      = time_static.sas_start.rfc3339
  expiry     = time_offset.sas_end.rfc3339

  resource_types {
    service   = true
    container = false
    object    = true
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  permissions {
    read    = true
    write   = true
    delete  = false
    list    = false
    add     = true
    create  = true
    update  = false
    process = false
    tag     = false
    filter  = false
  }
}