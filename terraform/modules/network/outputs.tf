output "resource_group_name" {
  description = "Nome do Resource Group criado."
  value       = azurerm_resource_group.rg.name
}

output "vnet_id" {
  description = "ID da VNet."
  value       = azurerm_virtual_network.vnet.id
}

output "web_subnet_id" {
  description = "ID da subnet web."
  value       = azurerm_subnet.web.id
}

output "app_subnet_id" {
  description = "ID da subnet app."
  value       = azurerm_subnet.app.id
}
