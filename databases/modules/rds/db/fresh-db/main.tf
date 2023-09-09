resource "aws_db_instance" "fresh_db" {
  # General Instance Settings
  identifier           = var.db_identifier
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  deletion_protection  = var.deletion_protection
  parameter_group_name = var.parameter_group_name

  # Storage
  allocated_storage = var.allocated_storage
  storage_encrypted = var.storage_encrypted
  kms_key_id        = var.kms_key_id
  storage_type      = var.storage_type

  # Authentication
  db_name  = var.db_name
  username = var.username
  password = var.password

  # Networking
  db_subnet_group_name = var.db_subnet_group_name

  # Security
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  vpc_security_group_ids              = var.vpc_security_group_ids

  # Maintenance
  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  maintenance_window          = var.maintenance_window
  apply_immediately           = var.apply_immediately

  # Backup
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier
  backup_retention_period   = var.backup_retention_period
  backup_window             = var.backup_window
  copy_tags_to_snapshot     = var.copy_tags_to_snapshot

  # Tags
  tags = {
    Name        = var.db_identifier
    Region      = var.region
    Environment = var.environment
    Service     = var.supported_service
    App         = var.supported_app
  }
}
