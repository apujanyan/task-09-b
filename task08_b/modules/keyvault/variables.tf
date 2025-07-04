variable "name" {
  description = "Key Vault name."
  type        = string
}

variable "location" {
  description = "Location."
  type        = string
}

variable "resource_group_name" {
  description = "Key Vault resource group."
  type        = string
}

variable "sku" {
  description = "Key Vault SKU."
  type        = string
}

variable "tags" {
  description = "Tags for resources."
  type        = map(string)
}