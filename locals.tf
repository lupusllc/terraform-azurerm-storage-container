# Helps to combine data, easier debug and remove complexity in the main resource.

locals {
  storage_containers_list = [
    for index, settings in var.storage_containers : {
      # Most will try and use key/value settings first, then try applicable defaults and then null as a last resort.
      ### Basic

      container_access_type    = settings.container_access_type
      default_encryption_scope = settings.default_encryption_scope
      # If default_encryption_scope is null, this must be null, otherwise use it's settings.
      encryption_scope_override_enabled = settings.default_encryption_scope == null ? null : settings.encryption_scope_override_enabled
      index                             = index # Added in case it's ever needed, since for_each/for loops don't have inherent indexes.
      metadata                          = settings.metadata
      name                              = settings.name
      # If storage_account_id is provided, use it directly.
      storage_account_id = settings.storage_account_id != null ? settings.storage_account_id : (
        # Otherwise, if storage_account_name and storage_account_resource_group_name are provided, construct the storage_account_id.
        settings.storage_account_name != null && settings.storage_account_resource_group_name != null ? format(
          "/subscriptions/%s/resourceGroups/%s/providers/Microsoft.Storage/storageAccounts/%s",
          data.azurerm_client_config.current.subscription_id,
          settings.storage_account_resource_group_name,
          settings.storage_account_name
        ) : null
      )
      # If storage_account_id is not null, split out name to populate storage_account_name. If null, use storage_account_name directly.
      storage_account_name = settings.storage_account_id != null ? element(split("/", settings.storage_account_id), 8) : settings.storage_account_name
      # If storage_account_id is not null, split out resource group name to populate storage_account_resource_group_name. If null, use storage_account_resource_group_name directly.
      storage_account_resource_group_name = settings.storage_account_id != null ? element(split("/", settings.storage_account_id), 4) : settings.storage_account_resource_group_name
    }
  ]

  # Used to create unique id for for_each loops, as just using the name may not be unique.
  storage_containers = {
    for index, settings in local.storage_containers_list : "${settings.storage_account_resource_group_name}>${settings.storage_account_name}>${settings.name}" => settings
  }
}
