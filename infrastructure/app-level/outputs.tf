output "load_balancer_hostname" {
  value       = module.urban_app.load_balancer_hostname
  description = "Load Balancer hostname"
}

output "load_balancer_ip" {
  value       = module.urban_app.load_balancer_ip
  description = "Load Balancer hostname"
}
