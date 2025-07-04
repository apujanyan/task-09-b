resource "azurerm_resource_group" "main" {
  name     = local.rg_name
  location = var.location

  tags = var.tags
}

module "keyvault" {
  source              = "./modules/keyvault"
  name                = local.keyvault_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = var.keyvault_sku

  tags = var.tags
}

module "storage" {
  source                   = "./modules/storage"
  sa_name                  = local.sa_name
  location                 = azurerm_resource_group.main.location
  resource_group_name      = azurerm_resource_group.main.name
  account_replication_type = var.sa_replication_type
  sa_container_name        = var.sa_container_name

  tags = var.tags

  depends_on = [azurerm_resource_group.main]
}

module "acr" {
  source              = "./modules/acr"
  name                = local.acr_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = var.acr_sku
  blob_url            = module.storage.blob_url
  sas_token           = module.storage.sas_token
  docker_image_name   = local.docker_image_name

  tags = var.tags

  depends_on = [module.storage]
}

module "aci_redis" {
  source                     = "./modules/aci_redis"
  name                       = local.redis_aci_name
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  sku                        = var.redis_aci_sku
  key_vault_id               = module.keyvault.keyvault_id
  redis_password_secret_name = var.redis_password
  redis_hostname_secret_name = var.redis_hostname

  tags = var.tags

  depends_on = [module.keyvault, module.acr]
}

module "aca" {
  source = "./modules/aca"
  aca_env_name = local.aca_env_name
  aca_name = local.aca_name
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  aca_env_workload_profile_type = var.aca_env_workload_profile_type
  aca_workload_profile_type = var.aca_workload_profile_type
  key_vault_id = module.keyvault.keyvault_id
  acr_id = module.acr.acr_id
  acr_login_server = module.acr.acr_login_server
  docker_image_name = local.docker_image_name
  redis_hostname_secret_id = module.aci_redis.redis_hostname_secret_id
  redis_password_secret_id = module.aci_redis.redis_password_secret_id

  tags = var.tags

  depends_on = [module.acr, module.keyvault, module.aci_redis]
}

module "aks" {
  source                      = "./modules/aks"
  name                        = local.aks_name
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  default_node_pool_name      = var.aks_node_pool_name
  default_node_pool_count     = var.aks_node_pool_count
  default_node_pool_size      = var.aks_node_pool_size
  default_node_pool_disk_type = var.aks_node_pool_disk_type
  acr_id                      = module.acr.acr_id
  keyvault_id                 = module.keyvault.keyvault_id

  tags = var.tags

  depends_on = [module.acr, module.keyvault, module.aci_redis]
}

module "k8s" {
  source                        = "./modules/k8s"
  aks_kv_access_identity_id     = module.aks.aks_kv_access_identity_id
  acr_login_server              = module.acr.acr_login_server
  keyvault_name                 = module.keyvault.keyvault_name
  docker_image_name             = local.docker_image_name
  redis_hostname_secret_name    = var.redis_hostname
  redis_primary_key_secret_name = var.redis_password

  depends_on = [module.aks]
}