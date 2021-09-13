provider "azurerm" {
  features {}
}

// Resource Group

resource "azurerm_resource_group" "Mpore" {
  name     = "Mpore"
  location = "eastus"
}

// Networking
resource "azurerm_virtual_network" "Mpore-vnet" {
  name                = "Mpore-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.Mpore.location
  resource_group_name = azurerm_resource_group.Mpore.name
}

resource "azurerm_subnet" "Mpore-subnet-A" {
  name                 = "Mpore-Subnet-A"
  resource_group_name  = azurerm_resource_group.Mpore.name
  virtual_network_name = azurerm_virtual_network.Mpore-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "Mpore" {
  name                = "Mpore-pip"
  resource_group_name = azurerm_resource_group.Mpore.name
  location            = azurerm_resource_group.Mpore.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "Mpore" {
  name                = "Mpore-nic"
  location            = azurerm_resource_group.Mpore.location
  resource_group_name = azurerm_resource_group.Mpore.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.Mpore-subnet-A.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.Mpore.id
  }
}

// Instances

resource "azurerm_linux_virtual_machine" "Mpore-Instance-A" {
  name                = "mpore.xyz"
  resource_group_name = azurerm_resource_group.Mpore.name
  location            = azurerm_resource_group.Mpore.location
  size                = "Standard_B1s"
  admin_username      = "" // FILL IN PRODUCTION
  network_interface_ids = [
    azurerm_network_interface.Mpore.id,
  ]

  admin_ssh_key {
    username   = "" // FILL IN PRODUCTION
    public_key = file("./keys/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}