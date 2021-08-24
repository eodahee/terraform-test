variable "network_security_group_name" {
    type = string
}



variable "network_security_rule_name" {
    type = string
}

variable "priority" {
    type        = number
    description = "The priority of the rule (100 ~ 4096)"
}

variable "direction" {
    type        = string
    description = "If rule will be evaluated on incoming or outgoing traffic -  Inbound, Outbound"
}

variable "access" {
    type        = string
    description = "Whether network traffic is allowed or denied - Allow, Deny"
}

variable "protocol" {
    type        = string
    description = "Network protocol this rule applies to - Tcp, Udp, Icmp, Esp, Ah, *"
}

variable "source_port_range" {
    type = string
}

variable "destination_port_range" {
    type = string
}

variable "source_address_prefix" {
    type = string
}

variable "destination_address_prefix" {
    type = string
}



variable "virtual_network_name" {
    type = string
}

variable "address_space" {
    type        = list(string)
    description = "The address space to use for the virtual network."
}



variable "subnet_name" {
    type = string
}

variable "address_prefixes" {
    type        = list(string)
    description = "The address prefixes to use for the subnet."
}



variable "network_interface_name" {
    type    = string
}

variable "ip_configuration_name" {
    type    = string
}

variable "private_ip_address_allocation" {
    type        = string
    description = "The allocation method used for the Private IP Address - Dynamic, Static"
}



variable "public_ip_name" {
    type = string
}

variable "allocation_method" {
    type        = string
    description = "The allocation method used for the Public IP Address - Dynamic, Static"
}



variable "virtual_machine_name" {
    type = string
}

variable "vm_size" {
    type        = string
    description = "Sizes for virtual machines - Standard_DS1_v2, Standard_DS2_v2, Standard_DS3_v2..."
}

variable "delete_os_disk_on_termination" {
    type = bool
}



variable "image_publisher" {
    type        = string
    description = "Publisher of the image to create the VM - Canonical..."
}

variable "image_offer" {
    type        = string
    description = "Offer of the image to create the VM - UbuntuServer..."
}

variable "image_sku" {
    type        = string
    description = "SKU of the image to create the VM - 16.04-LTS..."
}

variable "image_version" {
    type        = string
    description = "Version of the image to create the VM - latest..."
}



variable "os_disk_name" {
    type = string
}

variable "os_disk_caching" {
    type        = string
    description = "Caching requirements for the Data Disk - None, ReadOnly, ReadWrite..."
}

variable "os_disk_create_option" {
    type        = string
    description = "How the data disk should be created - Attach, FromImage, Empty..."
}

variable "os_disk_type" {
    type        = string
    description = "The type of managed disk to create - Standard_LRS, StandardSSD_LRS, Premium_LRS, UltraSSD_LRS..."
}



variable "computer_name" {
    type        = string
    description = "The name of the Virtual Machine"
}

variable "admin_username" {
    type        = string
    description = "The name of the local administrator account."
}

variable "admin_password" {
    type        = string
    description = "The password associated with the local administrator account."
}



variable "disable_password_authentication" {
    type = string
}
