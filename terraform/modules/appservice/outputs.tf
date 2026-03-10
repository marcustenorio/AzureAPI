output "app_identity_principal_id" {
  value = azurerm_linux_web_app.api.identity[0].principal_id
}
