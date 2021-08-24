# Manages Network Security Groups
resource "azurerm_network_security_group" "kismi" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.kismi.location
  resource_group_name = azurerm_resource_group.kismi.name
}

# Manages Network Security Rules
resource "azurerm_network_security_rule" "kismi" {
  name                        = var.network_security_rule_name
  priority                    = var.priority
  direction                   = var.direction
  access                      = var.access
  protocol                    = var.protocol
  source_port_range           = var.source_port_range
  destination_port_range      = var.destination_port_range
  source_address_prefix       = var.source_address_prefix
  destination_address_prefix  = var.destination_address_prefix

  resource_group_name         = azurerm_resource_group.kismi.name
  network_security_group_name = var.network_security_group_name
}

# Manages Virtual Networks / Subnets
resource "azurerm_virtual_network" "kismi" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.kismi.location
  resource_group_name = azurerm_resource_group.kismi.name
  address_space       = var.address_space
}

resource "azurerm_subnet" "kismi" {
  name                 = var.subnet_name      
  resource_group_name  = azurerm_resource_group.kismi.name
  virtual_network_name = azurerm_virtual_network.kismi.name
  address_prefixes     = var.address_prefixes
}

# Manages Network Interfaces
resource "azurerm_network_interface" "kismi" {
  name                = var.network_interface_name
  location            = azurerm_resource_group.kismi.location
  resource_group_name = azurerm_resource_group.kismi.name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = azurerm_subnet.kismi.id
    # subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    
    ## If "private_ip_address_allocation" is set to "Static"
    # private_ip_address = var.private_ip_address 

    ## If you want to associate a specific Public IP Address with this NIC
    public_ip_address_id = azurerm_public_ip.kismi.id
    # public_ip_address_id = var.public_ip_address_id
  }
}

# Manages IP Addresses
resource "azurerm_public_ip" "kismi" {
  name                = var.public_ip_name
  resource_group_name = azurerm_resource_group.kismi.name
  location            = azurerm_resource_group.kismi.location
  allocation_method   = var.allocation_method
}

# Manages a Virtual Machine
resource "azurerm_virtual_machine" "kismi" {
  name                  = var.virtual_machine_name
  location              = azurerm_resource_group.kismi.location
  resource_group_name   = azurerm_resource_group.kismi.name
  network_interface_ids = [ azurerm_network_interface.kismi.id ]
  # network_interface_ids = var.network_interface_ids
  vm_size               = var.vm_size
  delete_os_disk_on_termination = var.delete_os_disk_on_termination

  # Provisions the VM from one of two sources: an Azure Platform Image(e.g. Ubuntu/Windows Server) OR a Custom Image.
  storage_image_reference {
    publisher = var.image_publisher            
    offer     = var.image_offer         
    sku       = var.image_sku           
    version   = var.image_version       
  }

  # Configure the OS Disk.
  storage_os_disk {
    name              = var.os_disk_name          
    caching           = var.os_disk_caching       
    create_option     = var.os_disk_create_option 
    managed_disk_type = var.os_disk_type          
  }

  # When create_option in the "storage_os_disk" block is set to "FromImage", os_profile block is required.
  os_profile {
    computer_name  = var.computer_name      
    admin_username = var.admin_username     
    admin_password = var.admin_password     
  }


  # When VM is a Linux machine.
  os_profile_linux_config {     
    # If set to false, an admin_password must be specified.             
    disable_password_authentication = var.disable_password_authentication  

    # If "disable_password_authentication" is set to true
    # ssh_keys {
    #   path     = "/home/${var.admin_username}/.ssh/authorized_keys"
    #   key_data = "${var.ssh_public_key}"
    # }
  }

  # When VM is a Windows machine.
  # os_profile_windows_config {                 
  #  provision_vm_agent = var.provision_vm_agent
  # }
}