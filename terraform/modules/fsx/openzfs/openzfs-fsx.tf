resource "aws_fsx_openzfs_file_system" "openzfs" {
  # FSx OpenZFS
  deployment_type     = var.deployment_type
  storage_capacity    = var.storage_capacity
  throughput_capacity = var.throughput_capacity

  # Backup and Maintenance
  automatic_backup_retention_days   = var.automatic_backup_retention_days
  backup_id                         = var.backup_id
  copy_tags_to_backups              = var.copy_tags_to_backups
  daily_automatic_backup_start_time = var.daily_automatic_backup_start_time
  skip_final_backup                 = var.skip_final_backup
  weekly_maintenance_start_time     = var.weekly_maintenance_start_time

  # Storage
  kms_key_id           = var.kms_key_id
  storage_type         = "SSD" # Only value supported
  copy_tags_to_volumes = var.copy_tags_to_volumes

  disk_iops_configuration {
    iops = var.iops
    mode = var.mode
  }

  root_volume_configuration {
    copy_tags_to_snapshots = var.copy_tags_to_snapshots
    data_compression_type  = var.data_compression_type
    read_only              = var.read_only
    record_size_kib        = var.record_size_kib

    dynamic "user_and_group_quotas" {
      for_each = var.user_and_group_quotas

      content {
        id                         = user_and_group_quotas.value.id
        storage_capacity_quota_gib = user_and_group_quotas.value.storage_capacity_quota_gib
        type                       = user_and_group_quotas.value.type
      }
    }
  }

  # Networking and Security
  subnet_ids          = var.subnet_ids
  preferred_subnet_id = var.preferred_subnet_id
  security_group_ids  = var.security_group_ids

  # Tags
  tags = merge({
    Name       = var.name
    Region     = var.region
    Managed_By = "Terraform"
  }, var.tags)
}
