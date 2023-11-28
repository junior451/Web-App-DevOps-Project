variable "resource_group_name" {
  description = "The name of the resource group for the network"
  type = string
  default = "aks-network-rg"
}

variable "location" {
  description = "The regional location of the network resource"
  type = string
  default = "UK South"

}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network (VNet)."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}  