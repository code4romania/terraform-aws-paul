resource "random_password" "db_pass" {
  length           = 16
  special          = true
  override_special = "!#$%_-"

  lifecycle {
    ignore_changes = [
      length,
      special
    ]
  }
}

resource "random_password" "app_key" {
  length  = 32
  special = true

  lifecycle {
    ignore_changes = [
      length,
      special
    ]
  }
}

resource "random_password" "admin_password" {
  length  = 16
  special = true

  lifecycle {
    ignore_changes = [
      length,
      special
    ]
  }
}
