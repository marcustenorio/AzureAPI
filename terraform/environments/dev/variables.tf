variable "resource_group_name" {
  description = "Nome do Resource Group do ambiente dev."
  type        = string
  default     = "rg-azureapi-dev"
}

variable "location" {
  description = "Região Azure do ambiente dev."
  type        = string
  default     = "East US"
}
