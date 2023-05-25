# terraform-harvester-virtual-machine

<p align="center">
  <img src="https://user-images.githubusercontent.com/73097785/240722566-1daea92e-ca3b-4a8e-9942-ce11f300daf6.png">
</p>

Terraform module which creates a virtual machines for a Suse Harvester cluster. 

## Pre-requisites

Using the modules requires the following pre-requisites:
 * Suse Harvester cluster - [documentation](https://docs.harvesterhci.io/latest/install/requirements/)
 * Kubeconfig file of the Harvester cluster - [documentation](https://docs.harvesterhci.io/latest/faq/#how-can-i-access-the-kubeconfig-file-of-the-harvester-cluster)

<!-- BEGIN_TF_DOCS -->
# Usage
```hcl
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
```

## Providers

| Name | Version |
|------|---------|
| harvester | 0.6.2 |
| random | 3.5.1 |



## Resources

| Name | Type |
|------|------|
| [harvester_virtualmachine.default](https://registry.terraform.io/providers/harvester/harvester/latest/docs/resources/virtualmachine) | resource |
| [random_string.name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| description | Description for the virtual machine(s) | `string` | n/a | yes |
| reserved_memory | Amount of reserved memory to be assigned to the virtual machine(s) | `string` | n/a | yes |
| ssh_keys | List of SSH keys to be added to the virtual machine(s) | `list(any)` | n/a | yes |
| cloudinit | The cloud_init configuration to be used on the virtual machine(s) | ```object({ user_data = string user_data_base64 = string user_data_secret_name = string type = string network_data = string network_data_base64 = string network_data_secret_name = string })``` | `null` | no |
| cpu | Amount of cpu cores to be assigned to the virtual machine(s) | `number` | `1` | no |
| disk | The disk(s) to be assigned to the virtual machine(s) | ```object({ name = string access_mode = bool auto_delete = number boot_order = string bus = string container_image_name = string existing_volume_name = string hot_plug = bool image = string size = string storage_class_name = string type = string volume_mode = string volume_name = string })``` | `null` | no |
| efi | Determines if EFI system partition is to exist on the virtual machines data storage | `bool` | `true` | no |
| machine_type | The machine type for the virtual machine(s). | `string` | `"q35"` | no |
| memory | Amount of memory to be assigned to the virtual machine(s) | `string` | `"2Gi"` | no |
| name | Name prefix used when creating multiple virtual machines, if count is set to one the hyphen is trimmed from the name | `string` | `"virtual-machine"` | no |
| namespace | Namespace in which the virtual machine(s) is/are to be placed | `string` | `"default"` | no |
| network_interface | The network interface(s) to be assigned to the virtual machine(s) | ```object({ name = string mac_address = string model = string network_name = string type = string wait_for_lease = bool })``` | `null` | no |
| replicas | Amount of virtual machine(s) to create for the configuration | `number` | `1` | no |
| restart_after_update | Whether to restart the virtual machine(s) after updating | `bool` | `true` | no |
| run_strategy | Run strategy for the virtual machine(s) (options: Always, RerunOnFailure, Manual, Halted) | `string` | `"Always"` | no |
| secure_boot | Determines if the virtual machines are to be booted in secure modus. EFI must be enabled to use this feature | `bool` | `false` | no |
| tags | Tags to be placed on the virtual machine(s) | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The id of the virtual machine(s) |
| state | The state of the virtual machine(s) |
<!-- END_TF_DOCS -->

## Documentation

> Product: https://harvesterhci.io/
> 
> Provider: https://registry.terraform.io/providers/harvester/harvester/latest/docs
> 
> Documentation: https://docs.harvesterhci.io/latest/

# Contributing

Refer to the [contribution guidelines](./CONTRIBUTING) for information on contributing to this module.

# License

This project is licensed under the [MIT license](./LICENSE).
