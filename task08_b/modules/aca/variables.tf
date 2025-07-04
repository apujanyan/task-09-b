variable "aca_env_name" {
  description = "ACAE name."
  type        = string
}

variable "aca_name" {
  description = "ACA name."
  type        = string
}

variable "location" {
  description = "Location."
  type        = string
}

variable "resource_group_name" {
  description = "ACAE resource group."
  type        = string
}

variable "aca_env_workload_profile_type" {
  description = "ACAE workload profile type."
  type        = string
}

variable "aca_workload_profile_type" {
  description = "ACA workload profile type."
  type        = string
}

variable "docker_image_name" {
  description = "Docker image name."
  type        = string
}

variable "acr_login_server" {
  description = "ACR login server."
  type        = string
}

variable "acr_id" {
  description = "ACR ID."
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault ID."
  type        = string
}

variable "redis_hostname_secret_id" {
  description = "Redis hostname secret ID."
  type        = string
}

variable "redis_password_secret_id" {
  description = "Redis password secret ID."
  type        = string
}

variable "tags" {
  description = "Tags for resources."
  type        = map(string)
}