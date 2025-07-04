locals {
  rg_name           = join("-", [var.name_prefix, "rg"])
  keyvault_name     = join("-", [var.name_prefix, "kv"])
  aca_env_name      = join("-", [var.name_prefix, "cae"])
  aca_name          = join("-", [var.name_prefix, "ca"])
  aks_name          = join("-", [var.name_prefix, "ks"])
  redis_aci_name    = join("-", [var.name_prefix, "redis-ci"])
  docker_image_name = join("-", [var.name_prefix, "app"])
  sa_name           = replace("${var.name_prefix}sa", "-", "")
  acr_name          = replace("${var.name_prefix}cr", "-", "")
}