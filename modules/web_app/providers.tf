terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.51"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      app = var.project_slug
      env = var.env
    }
  }
}
