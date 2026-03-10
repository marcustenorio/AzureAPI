variable "storage_account_name" {
  description = "Nome da Storage Account."
  type        = string
}

variable "resource_group_name" {
  description = "Nome do Resource Group."
  type        = string
}

variable "location" {
  description = "Região Azure."
  type        = string
}

variable "principal_id" {
  description = "Principal ID da identidade com acesso ao Storage."
  type        = string
}
