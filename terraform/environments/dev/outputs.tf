output "resource_group_name" {
  value = module.network.resource_group_name
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "web_subnet_id" {
  value = module.network.web_subnet_id
}

output "app_subnet_id" {
  value = module.network.app_subnet_id
}
