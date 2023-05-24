output "id" {
  description = "The id of the virtual machine(s)"
  value       = harvester_virtualmachine.default.*.id
}

output "state" {
  description = "The state of the virtual machine(s)"
  value       = harvester_virtualmachine.default.*.state
}
