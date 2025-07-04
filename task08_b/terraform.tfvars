name_prefix                   = "cmtr-d4qm9uvw-mod8b"
location                      = "northeurope"
sa_replication_type           = "LRS"
sa_container_name             = "app-content"
redis_aci_sku                 = "Standard"
keyvault_sku                  = "standard"
redis_password                = "redis-password"
redis_hostname                = "redis-hostname"
acr_sku                       = "Basic"
aca_env_workload_profile_type = "Consumption"
aca_workload_profile_type     = "Consumption"
aks_node_pool_name            = "system"
aks_node_pool_count           = 1
aks_node_pool_size            = "Standard_D2ads_v5"
aks_node_pool_disk_type       = "Ephemeral"
tags = {
  "Creator" = "aramazd_apujanyan@epam.com"
}