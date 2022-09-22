variable "docker_tag" {
  description = "Docker image tag"
  type        = string
}

variable "project_slug" {
  description = "Project slug"
  type        = string
}

variable "hostname" {
  description = "Domain for website factory web app"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "debug_mode" {
  description = "Is debug mode enabled"
  type        = bool
}

variable "region" {
  description = "Region where to deploy resources"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone (suffix only)"
  type        = string

  validation {
    condition     = contains(["a", "b", "c"], var.availability_zone)
    error_message = "Allowed values for availability_zone are \"a\", \"b\", or \"c\"."
  }
}

variable "ses_domain" {
  description = "Domain for AWS SES"
  type        = string
}

variable "admin_email" {
  description = "Email address of initial admin account"
  type        = string
}
