variable "sa_name" {
  description = "SA name."
  type        = string
}

variable "location" {
  description = "Location."
  type        = string
}

variable "resource_group_name" {
  description = "SA resource group."
  type        = string
}

variable "sa_container_name" {
  description = "SA container name."
  type        = string
}

variable "account_replication_type" {
  description = "SA account replication type."
  type        = string
}

variable "tags" {
  description = "Tags for resources."
  type        = map(string)
}