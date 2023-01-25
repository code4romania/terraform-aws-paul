locals {
  namespace_prefix = "paul-"
  namespace_suffix = var.env == "production" ? "" : "-${var.env}"
  namespace        = "${local.namespace_prefix}${var.project_slug}${local.namespace_suffix}"
  hostname         = var.hostname != null ? var.hostname : replace(aws_lightsail_container_service.container_service.url, "/(^https?:\\/\\/|\\/$)/", "")

  container = {
    power           = "micro"
    scale           = 1
    service_name    = "${local.namespace}"
    deployment_name = "${local.namespace}-deployment"
    docker_image    = "code4romania/paul"
  }

  database = {
    name              = "${local.namespace}-db"
    blueprint_id      = "postgres_12"
    bundle_id         = "micro_2_0"
    username          = "psqladmin"
    password          = random_password.db_pass.result
    availability_zone = "${var.region}${var.availability_zone}"
  }

  ses_count = var.ses_domain != null ? 1 : 0

  mail = {
    host         = "email-smtp.${var.region}.amazonaws.com"
    port         = 587
    encryption   = true
    from_address = var.ses_domain != null ? "no-reply@${var.ses_domain}" : null
  }
}
