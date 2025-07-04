variable "aks_kv_access_identity_id" {
  description = "AKS Key Vault access identity ID."
  type        = string
}

variable "keyvault_name" {
  description = "Key Vault name."
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "Redis hostname secret name."
  type        = string
}

variable "redis_primary_key_secret_name" {
  description = "Redis primary key secret name."
  type        = string
}

variable "acr_login_server" {
  description = "ACR logint server."
  type        = string
}

variable "docker_image_name" {
  description = "Docker image name."
  type        = string
}