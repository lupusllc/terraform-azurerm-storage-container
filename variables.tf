### Defaults

### Required

### Dependencies

### Resources

variable "storage_containers" {
  default     = [] # Defaults to an empty list.
  description = "Storage Containers."
  nullable    = false # This will treat null values as unset, which will allow for use of defaults.
  type = list(object({
    ### Basic

    container_access_type               = optional(string, "private") # private, blob, container, or rootlevel. Default is private.
    default_encryption_scope            = optional(string, null)      # The default encryption scope to use for blobs uploaded. Changing requires recreation.
    encryption_scope_override_enabled   = optional(bool, true)        # Allow blobs to override the default encryption scope when specifying default_encryption_scope. Defaults to true, changing requires recreation.
    metadata                            = optional(map(string), {})   # Metadata for the container.
    name                                = string
    storage_account_id                  = optional(string, null) # Can use name and resource group or id, id takes precedence.
    storage_account_name                = optional(string, null) # Can use name and resource group or id, id takes precedence.
    storage_account_resource_group_name = optional(string, null) # Can use name and resource group or id, id takes precedence.
  }))
}
