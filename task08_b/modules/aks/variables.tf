variable "name" {
  description = "AKS name."
  type        = string
}

variable "location" {
  description = "Location."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group."
  type        = string
}

variable "default_node_pool_name" {
  description = "AKS node pool name."
  type        = string
}

variable "default_node_pool_count" {
  description = "AKS node pool count."
  type        = number
}

variable "default_node_pool_size" {
  description = "AKS node pool size."
  type        = string
}

variable "default_node_pool_disk_type" {
  description = "AKS node pool disk type"
  type        = string
}

variable "acr_id" {
  description = "ACR ID."
  type        = string
}

variable "keyvault_id" {
  description = "Key Vault ID."
  type        = string
}

variable "tags" {
  description = "Tags for resources."
  type        = map(string)
}