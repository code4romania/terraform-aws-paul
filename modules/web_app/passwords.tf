resource "random_password" "db_pass" {
  length  = 32
  special = false

  lifecycle {
    ignore_changes = [
      length,
      special
    ]
  }
}

resource "random_password" "app_key" {
  length  = 50
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
  special = false

  lifecycle {
    ignore_changes = [
      length,
      special
    ]
  }
}
