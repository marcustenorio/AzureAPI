output "id" {
  description = "ID da Managed Identity."
  value       = azurerm_user_assigned_identity.identity.id
}

output "principal_id" {
  description = "Principal ID da Managed Identity."
  value       = azurerm_user_assigned_identity.identity.principal_id
}
