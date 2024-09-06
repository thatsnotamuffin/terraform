module "rds_2" {
  source = "../modules/rds/db/fresh-db"

  # Tags
  region            = local.region
  environment       = local.environment
  supported_service = local.postgres_supported_service
  supported_app     = "My App"

  # General Instance Settings
  db_identifier        = "thatsnotamuffin-dev-db-2"
  engine               = "postgres"
  engine_version       = "13"
  instance_class       = "db.m6g.large"
  deletion_protection  = true
  parameter_group_name = local.rds_parameter_group

  # Storage
  allocated_storage = 100
  storage_encrypted = true
  kms_key_id        = local.rds_kms_key
  storage_type      = "gp3"

  # Authentication
  db_name  = "postgres"
  username = var.notamuffin_rds_username
  password = var.notamuffin_rds_password

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
  final_snapshot_identifier = "thatsnotamuffin-dev-db-2-final"
  backup_retention_period   = 30
  backup_window             = local.backup_window
  copy_tags_to_snapshot     = true
}
