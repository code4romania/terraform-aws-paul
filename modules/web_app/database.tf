resource "aws_lightsail_database" "database" {
  relational_database_name = local.database.name
  availability_zone        = local.database.availability_zone
  blueprint_id             = local.database.blueprint_id
  bundle_id                = local.database.bundle_id
  master_database_name     = replace(local.database.name, "-", "_")
  master_username          = local.database.username
  master_password          = local.database.password
  publicly_accessible      = false
  apply_immediately        = true
  backup_retention_enabled = true

  # All times in UTC
  preferred_backup_window      = "02:00-02:30"
  preferred_maintenance_window = "sun:03:00-sun:03:30"

  final_snapshot_name = "${local.database.name}-snapshot"
}
