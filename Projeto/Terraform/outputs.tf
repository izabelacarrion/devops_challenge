output "ip_publico_web" {
  value       = module.desafio_devops.instance_public_addr
  description = "IP Publico da instancia WEB"
}