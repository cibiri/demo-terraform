terraform {
  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "cibiridemoterraform"
    container_name       = "terraform-demo"
    key                  = "terraform-demotfstate"
  }
}

provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

#Create Resource Group
resource "azurerm_resource_group" "tamops" {
  name     = "demo-terraform"
  location = "eastus"
}

#Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "demo-vnet"
  address_space       = ["192.168.0.0/16"]
  location            = "eastus"
  resource_group_name = azurerm_resource_group.tamops.name
}

# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "demo-subnet"
  resource_group_name  = azurerm_resource_group.tamops.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "192.168.0.0/24"
}
  