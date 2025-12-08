output "storage_containers" {
  description = "The storage containers."
  value       = azurerm_storage_container.this
}

### Debug Only

output "var_storage_containers" {
  value = var.storage_containers
}

output "local_storage_containers" {
  value = local.storage_containers
}
