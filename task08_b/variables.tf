variable "name_prefix" {
  description = "Name prefix for resources."
  type        = string
}

variable "location" {
  description = "Location."
  type        = string
}

variable "sa_replication_type" {
  description = "SA replication type."
  type        = string
}

variable "sa_container_name" {
  description = "SA container name."
  type        = string
}

variable "redis_aci_sku" {
  description = "Redis ACI SKU."
  type        = string
}

variable "keyvault_sku" {
  description = "Key Vault SKU."
  type        = string
}

variable "redis_password" {
  description = "Redis password."
  type        = string
}

variable "redis_hostname" {
  description = "Redis hostname."
  type        = string
}

variable "acr_sku" {
  description = "ACR SKU."
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

variable "aks_node_pool_name" {
  description = "AKS node pool name."
  type        = string
}
variable "aks_node_pool_count" {
  description = "AKS node pool count."
  type        = number
}
variable "aks_node_pool_size" {
  description = "AKS node pool size."
  type        = string
}
variable "aks_node_pool_disk_type" {
  description = "AKS node pool disk type."
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
}