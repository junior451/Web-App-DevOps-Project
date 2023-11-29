output "aks_cluster_name" {
  description = "Name of the provisioned cluster"
  value = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_cluster_id" {
  description = "ID of the cluster"
  value = azurerm_kubernetes_cluster.aks_cluster.id
}

output "aks_kubernetes_config" {
  description = "This wil capture the Kubernetes configuration file of the cluster"
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
}