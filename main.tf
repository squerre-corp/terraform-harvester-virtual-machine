resource "random_string" "name_suffix" {
  length  = 4
  special = false
  lower   = true
}

resource "harvester_virtualmachine" "default" {
  count = var.replicas

  name        = var.replicas != 1 ? "${var.name}-${count.index}-${random_string.name_suffix.id}" : "${var.name}-${random_string.name_suffix.id}"
  hostname    = var.replicas != 1 ? "${var.name}-${count.index}-${random_string.name_suffix.id}" : "${var.name}-${random_string.name_suffix.id}"
  namespace   = var.namespace
  description = var.description

  restart_after_update = var.restart_after_update
  run_strategy         = var.run_strategy
  machine_type         = var.machine_type
  cpu                  = var.cpu
  memory               = var.memory
  reserved_memory      = var.reserved_memory
  ssh_keys             = var.ssh_keys
  efi                  = var.efi
  secure_boot          = var.secure_boot

  dynamic "network_interface" {
    for_each = var.network_interface
    content {
      name           = network_interface.value["name"]
      mac_address    = network_interface.value["mac_address"]
      model          = network_interface.value["model"]
      network_name   = network_interface.value["network_name"]
      type           = network_interface.value["type"]
      wait_for_lease = network_interface.value["wait_for_lease"]
    }
  }

  dynamic "disk" {
    for_each = var.disk
    content {
      name                 = disk.value["name"]
      access_mode          = disk.value["access_mode"]
      auto_delete          = disk.value["auto_delete"]
      boot_order           = disk.value["boot_order"]
      bus                  = disk.value["bus"]
      container_image_name = disk.value["container_image_name"]
      existing_volume_name = disk.value["existing_volume_name"]
      hot_plug             = disk.value["hot_plug"]
      image                = disk.value["image"]
      size                 = disk.value["size"]
      storage_class_name   = disk.value["storage_class_name"]
      type                 = disk.value["type"]
      volume_mode          = disk.value["volume_mode"]
      volume_name          = disk.value["volume_name"]
    }
  }

  dynamic "cloudinit" {
    for_each = var.cloudinit
    content {
      user_data                = cloudinit.value["user_data"]
      user_data_base64         = cloudinit.value["user_data_base64"]
      user_data_secret_name    = cloudinit.value["user_data_secret_name"]
      type                     = cloudinit.value["type"]
      network_data             = cloudinit.value["network_data"]
      network_data_base64      = cloudinit.value["network_data_base64"]
      network_data_secret_name = cloudinit.value["network_data_secret_name"]
    }
  }

  tags = merge(
    {
      "name" = format("%s", var.name)
    },
    var.tags,
  )
}
