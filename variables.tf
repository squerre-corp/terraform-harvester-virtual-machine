variable "replicas" {
  description = "Amount of virtual machine(s) to create for the configuration"
  type        = number

  validation  {
    error_message = "The amount of virtual machines to be created needs to be 1 or higher."
    condition     = var.replicas >= 1
  }
}

variable "name" {
  description = "Name prefix used when creating multiple virtual machines, if count is set to one the hyphen is trimmed from the name"
  type        = string
}

variable "namespace" {
  description = "Namespace in which the virtual machine(s) is/are to be placed"
  type        = string
  default     = "default"
}

variable "description" {
  description = "Description for the virtual machine(s)"
  type        = string
  default     = ""
}

variable "restart_after_update" {
  description = "Whether to restart the virtual machine(s) after updating"
  type        = bool
  default     = true
}

variable "run_strategy" {
  description = "Run strategy for the virtual machine(s) (options: Always, RerunOnFailure, Manual, Halted)"
  type        = string
  default     = "Always"
}

variable "machine_type" {
  description = "The machine type for the virtual machine(s)."
  type        = string
  default     = "q35"
}

variable "cpu" {
  description = "Amount of cpu cores to be assigned to the virtual machine(s)"
  type        = number
  default     = 1
}

variable "memory" {
  description = "Amount of memory to be assigned to the virtual machine(s)"
  type        = string
  default     = "2Gi"
}

variable "reserved_memory" {
  description = "Amount of reserved memory to be assigned to the virtual machine(s)"
  type        = string
}

variable "ssh_keys" {
  description = "List of SSH keys to be added to the virtual machine(s)"
  type        = list(any)
  default     = []
}

variable "efi" {
  description = "Determines if EFI system partition is to exist on the virtual machines data storage"
  type        = bool
  default     = true
}

variable "secure_boot" {
  description = "Determines if the virtual machines are to be booted in secure modus. EFI must be enabled to use this feature"
  type        = bool
  default     = false
}

variable "network_interface" {
  description = "The network interface(s) to be assigned to the virtual machine(s)"
  type = object({
    name           = string
    mac_address    = string
    model          = string
    network_name   = string
    type           = string
    wait_for_lease = bool
  })
}

variable "disk" {
  description = "The disk(s) to be assigned to the virtual machine(s)"
  type = object({
    name                 = string
    access_mode          = bool
    auto_delete          = number
    boot_order           = string
    bus                  = string
    container_image_name = string
    existing_volume_name = string
    hot_plug             = bool
    image                = string
    size                 = string
    storage_class_name   = string
    type                 = string
    volume_mode          = string
    volume_name          = string
  })
}

variable "cloudinit" {
  description = "The cloud_init configuration to be used on the virtual machine(s)"
  type = object({
    user_data                = string
    user_data_base64         = string
    user_data_secret_name    = string
    type                     = string
    network_data             = string
    network_data_base64      = string
    network_data_secret_name = string
  })
  default = null
}

variable "tags" {
  description = "Tags to be placed on the virtual machine(s)"
  type        = map(string)
  default     = {}
}
