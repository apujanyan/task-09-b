output "aks_lb_ip" {
  description = "AKS Load Balancer IP."
  value       = module.k8s.aks_lb_ip
}

output "aca_fqdn" {
  description = "ACA FQDN."
  value       = module.aca.aca_fqdn
}

output "redis_fqdn" {
  description = "Redis FQDN."
  value       = module.aci_redis.redis_fqdn
}