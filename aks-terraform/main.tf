terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  client_id       = "0de38bd7-4965-4fed-a6a7-c5a810183f52"
  client_secret   = "WHI8Q~BuvLzuIcqMLp5vFVj5raEe1fw4QFOjgc70"
  subscription_id = "4f4f3acd-6d28-4d0c-a47d-7ee8d3c5d6d4"
  tenant_id       = "47d4542c-f112-47f4-92c7-a838d8a5e8ef"
}

module "networking" {
  source = "./networking-module"

  resource_group_name = "networking-resource-group"
  location = "UK South"
  vnet_address_space = ["10.0.0.0/16"]
}

module "aks_cluster" {
  source = "./aks-cluster-module"

  aks_cluster_name           = "terraform-aks-cluster"
  cluster_location           = "UK South"
  dns_prefix                 = "myaks-project"
  kubernetes_version         = "1.26.6" 
  service_principal_client_id = "0de38bd7-4965-4fed-a6a7-c5a810183f52"
  service_principal_client_secret = "WHI8Q~BuvLzuIcqMLp5vFVj5raEe1fw4QFOjgc70"

  resource_group_name = module.networking.resource_group_name
  vnet_id = module.networking.vnet_id
  control_plane_subnet_id = module.networking.control_plane_subnet_id
  worker_node_subnet_id = module.networking.worker_node_subnet_id

}