output "web_app_hostname" {
  value = aws_lightsail_container_service.container_service.url
}

output "admin_password" {
  value     = random_password.admin_password.result
  sensitive = true
}
