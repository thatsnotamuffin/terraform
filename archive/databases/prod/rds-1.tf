module "rds_1" {
  source = "../modules/rds/db/from-snapshot"

  # Tags
  region            = local.region
  environment       = local.environment
  supported_service = local.postgres_supported_service
  supported_app     = "My App"

  # General Instance Settings
  snapshot_identifier  = "thatsnotamuffin-prod-db-1-snapshot"
  db_identifier        = "thatsnotamuffin-prod-db-1"
  instance_class       = "db.m6g.large"
  deletion_protection  = true
  parameter_group_name = local.rds_parameter_group

  # Storage
  storage_encrypted = true
  kms_key_id        = local.rds_kms_key
  storage_type      = "gp3"

  # Networking
  db_subnet_group_name = local.rds_subnet_group_name

  # Security
  iam_database_authentication_enabled = false
  vpc_security_group_ids              = local.security_group_ids

  # Maintenance
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = true
  maintenance_window          = local.maintenance_window
  apply_immediately           = true

  # Backup
  skip_final_snapshot       = false
  final_snapshot_identifier = "thatsnotamuffin-prod-db-1-final"
  backup_retention_period   = 30
  backup_window             = local.backup_window
  copy_tags_to_snapshot     = true
}
