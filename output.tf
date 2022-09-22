output "web_app_hostname" {
  value = module.web_app.web_app_hostname
}

output "admin_password" {
  value     = module.web_app.admin_password
  sensitive = true
}
