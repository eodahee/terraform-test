output "virtual_machine_name" {
  value = azurerm_virtual_machine.kismi.name
}

output "public_ip_address" {
  value = azurerm_public_ip.kismi.*.ip_address
}