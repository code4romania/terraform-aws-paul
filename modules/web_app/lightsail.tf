resource "aws_lightsail_container_service" "container_service" {
  name  = local.container.service_name
  power = local.container.power
  scale = local.container.scale

  dynamic "public_domain_names" {
    for_each = var.hostname == null ? [] : [var.hostname]

    content {
      certificate {
        certificate_name = replace(public_domain_names.value, ".", "-")

        domain_names = [
          public_domain_names.value
        ]
      }
    }
  }
}

resource "aws_lightsail_container_service_deployment_version" "container_deployment" {
  service_name = aws_lightsail_container_service.container_service.name

  container {
    container_name = local.container.deployment_name
    image          = "${local.container.docker_image}:${var.docker_tag}"

    environment = {
      "DEBUG"                 = var.debug_mode ? "True" : "False"
      "DATABASE_URL"          = "postgres://${aws_lightsail_database.database.master_username}:${aws_lightsail_database.database.master_password}@${aws_lightsail_database.database.master_endpoint_address}/${aws_lightsail_database.database.master_database_name}"
      "SECRET_KEY"            = random_password.app_key.result
      "DJANGO_ADMIN_USERNAME" = var.admin_email
      "DJANGO_ADMIN_EMAIL"    = var.admin_email
      "DJANGO_ADMIN_PASSWORD" = random_password.admin_password.result


      "CORS_ALLOWED_ORIGINS" = "https://${local.hostname}"
      "FRONTEND_DOMAIN"      = local.hostname
      "ALLOWED_HOSTS"        = local.hostname

      "NO_REPLY_EMAIL"      = local.mail.from_address
      "EMAIL_BACKEND"       = "django.core.mail.backends.smtp.EmailBackend"
      "EMAIL_HOST"          = local.mail.host
      "EMAIL_HOST_USER"     = aws_iam_access_key.iam_user_key.id
      "EMAIL_HOST_PASSWORD" = aws_iam_access_key.iam_user_key.ses_smtp_password_v4
      "EMAIL_PORT"          = local.mail.port
      "EMAIL_USE_TLS"       = local.mail.encryption ? "True" : "False"

      "USE_S3"                  = "True"
      "AWS_ACCESS_KEY_ID"       = aws_iam_access_key.iam_user_key.id
      "AWS_SECRET_ACCESS_KEY"   = aws_iam_access_key.iam_user_key.secret
      "AWS_STORAGE_BUCKET_NAME" = "aws_s3_bucket.media.bucket"
      "AWS_S3_REGION_NAME"      = var.region
    }

    ports = {
      80 = "HTTP"
    }
  }

  public_endpoint {
    container_name = local.container.deployment_name
    container_port = 80

    health_check {
      # interval_seconds = 30
      # path             = "/health"
    }
  }

  depends_on = [
    aws_lightsail_database.database
  ]
}
