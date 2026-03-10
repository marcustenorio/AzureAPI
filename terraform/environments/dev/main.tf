module "network" {
  source = "../../modules/network"

  resource_group_name = var.resource_group_name
  location            = var.location

  vnet_name          = "vnet-api-dev"
  vnet_address_space = ["10.0.0.0/16"]

  web_subnet_name     = "web-subnet"
  web_subnet_prefixes = ["10.0.1.0/24"]

  app_subnet_name     = "app-subnet"
  app_subnet_prefixes = ["10.0.2.0/24"]
}

module "identity" {
  source = "../../modules/identity"

  identity_name       = "api-managed-identity"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "storage" {
  source = "../../modules/storage"

  storage_account_name = "stazureapidata001"
  resource_group_name  = var.resource_group_name
  location             = var.location
  principal_id         = module.identity.principal_id
}

module "appservice" {
  source = "../../modules/appservice"

  plan_name           = "api-plan-dev"
  app_name            = "azureapi-dev"
  resource_group_name = var.resource_group_name
  location            = var.location
  container_image     = "nginx"
}
