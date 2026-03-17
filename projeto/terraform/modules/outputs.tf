output "instance_public_addr" {
  value       = aws_instance.srv_web.public_ip
  description = "IP Publico da instancia"
}