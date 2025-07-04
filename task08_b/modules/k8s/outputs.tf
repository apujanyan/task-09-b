output "aks_lb_ip" {
  description = "AKS Load Balancer ID."
  value = try(
    data.kubernetes_service.app_service.status[0].load_balancer[0].ingress[0].ip,
    "pending"
  )
}