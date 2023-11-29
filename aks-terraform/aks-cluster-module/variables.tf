variable "aks_cluster_name" {
  description = "The name of the AKS cluster"
  type = string
}

variable "cluster_location" {
  description = "The Azure region where the cluster will be created"
  type = string
}

variable "dns_prefix" {
  description = "The dns prefix for the AKS cluster"
  type = string
}

variable "kubernetes_version" {
  description = "The version of kubernetes to be used to create the cluster"
  type = string
}

variable "service_principal_client_id" {
  description = "The client id of the service principle"
  type = string
}

variable "service_principal_client_secret" {
  description = "The client secrete of the service principle"
  type = string
}

# Input variables from the networking module
variable "resource_group_name" {
  description = "Name of the Azure Resource Group for networking resources "
  type = string
}

variable "vnet_id" {
  description = "ID of the virtual net(vnet)"
  type = string
}

variable "control_plane_subnet_id" {
  description = "ID of the control plane subnet"
  type = string
}

variable "worker_node_subnet_id" {
  description = "ID of the the worker nodes subnet"
  type = string
}