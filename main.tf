module "web_app" {
  source = "./modules/web_app"

  # Input Variables
  docker_tag        = var.docker_tag
  hostname          = var.hostname
  env               = var.env
  project_slug      = var.project_slug
  region            = var.region
  availability_zone = var.availability_zone
  debug_mode        = var.debug_mode
  admin_email       = var.admin_email
  ses_domain        = var.ses_domain
}
