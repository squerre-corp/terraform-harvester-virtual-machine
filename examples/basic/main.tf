module "virtual_machine" {
  source = "../../"

  replicas    = 3
  name        = "kubernetes"
  namespace   = "default"
  description = "Virtual machines in the form of worker nodes for a Kubernetes cluster"

  machine_type = "q35"

  cpu    = 2
  memory = "4Gi"

  ssh_keys = []

  network_interface {
    name         = "vlan-9asj2l"
    network_name = harvester_network.vlan-9asj2l.id
  }

  disk {
    name        = "disk-9aulwi"
    type        = "disk"
    size        = "10Gi"
    bus         = "virtio"
    boot_order  = 1
  }

  disk {
    name        = "cd-ais90d"
    type        = "cd-rom"
    size        = "10Gi"
    bus         = "sata"
    boot_order  = 1
    image       = harvester_image.opensuse-15-4.id
    auto_delete = true
  }

  cloudinit {
    user_data = <<-EOF
      #cloud-config
      EOF
  }
}
