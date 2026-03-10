variable "resource_group_name" {
  description = "Nome do Resource Group da solução."
  type        = string
}

variable "location" {
  description = "Região Azure."
  type        = string
}

variable "vnet_name" {
  description = "Nome da VNet."
  type        = string
}

variable "vnet_address_space" {
  description = "Espaço de endereçamento da VNet."
  type        = list(string)
}

variable "web_subnet_name" {
  description = "Nome da subnet da camada web."
  type        = string
}

variable "web_subnet_prefixes" {
  description = "Prefixos da subnet web."
  type        = list(string)
}

variable "app_subnet_name" {
  description = "Nome da subnet da camada da API."
  type        = string
}

variable "app_subnet_prefixes" {
  description = "Prefixos da subnet app."
  type        = list(string)
}
