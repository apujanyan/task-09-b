variable "name" {
  description = "ACI name."
  type        = string
}

variable "location" {
  description = "Location."
  type        = string
}

variable "resource_group_name" {
  description = "ACI resource group."
  type        = string
}

variable "sku" {
  description = "ACI SKU."
  type        = string
}

variable "redis_password_secret_name" {
  description = "Redis password secret name."
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "Redis hostname secret name."
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault ID"
  type        = string
}

variable "tags" {
  description = "Tags for resources."
  type        = map(string)
}