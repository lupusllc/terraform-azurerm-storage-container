### Requirements:

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.54.0" # Tested on this provider version, but will allow future patch versions.
    }
  }
  required_version = "~> 1.14.0" # Tested on this Terraform CLI version, but will allow future patch versions.
}

### Data:

# To populate Tenant ID and Subscription ID if not provided.
data "azurerm_client_config" "current" {}

### Resources:

resource "azurerm_storage_container" "this" {
  for_each = local.storage_containers

  ### Basic

  container_access_type             = each.value.container_access_type
  default_encryption_scope          = each.value.default_encryption_scope
  encryption_scope_override_enabled = each.value.encryption_scope_override_enabled
  metadata                          = each.value.metadata
  name                              = each.value.name
  storage_account_id                = each.value.storage_account_id
}
