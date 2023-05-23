output "id" {
  description = "The id of the virtual machine(s)"
  value       = harvester_virtualmachine.this.*.id
}

output "state" {
  description = "The state of the virtual machine(s)"
  value       = harvester_virtualmachine.this.*.state
}
