variable "name" {
  description = "ACR name."
  type        = string
}

variable "location" {
  description = "Location."
  type        = string
}

variable "resource_group_name" {
  description = "ACR resource group."
  type        = string
}

variable "sku" {
  description = "ACR SKU."
  type        = string
}

variable "blob_url" {
  description = "Blob URL."
  type        = string
}

variable "sas_token" {
  description = "SAS token."
  type        = string
}

variable "docker_image_name" {
  description = "Docker image name."
  type        = string
}

variable "tags" {
  description = "Tags for resources."
  type        = map(string)
}