##-- RDS --##
# This module creates an RDS instance from a snapshot

resource "aws_db_instance" "snapshot_rds_postgres" {

    snapshot_identifier                     = var.postgres_settings.db_snapshot   
    identifier                              = var.postgres_settings.db_identifier
    instance_class                          = var.postgres_settings.db_instance_class
    skip_final_snapshot                     = var.postgres_settings.skip_final_snapshot
    allow_major_version_upgrade             = var.postgres_settings.allow_major_version_upgrade
    auto_minor_version_upgrade              = var.postgres_settings.auto_minor_upgrade
    backup_retention_period                 = var.postgres_settings.backup_retention
    backup_window                           = var.postgres_settings.backup_window
    maintenance_window                      = var.postgres_settings.maintenance_window
    copy_tags_to_snapshot                   = var.postgres_settings.snapshot_tags
    db_subnet_group_name                    = var.postgres_settings.rds_subnet_group_name
    deletion_protection                     = var.postgres_settings.delete_protection
    final_snapshot_identifier               = var.postgres_settings.final_snapshot_identifier
    iam_database_authentication_enabled     = var.postgres_settings.iam_auth_enabled
    storage_encrypted                       = var.postgres_settings.encrypted_storage
    kms_key_id                              = var.postgres_settings.kms_key
    storage_type                            = var.postgres_settings.storage_type
    vpc_security_group_ids                  = var.target_security_groups


    tags = {
        Name                                = var.postgres_settings.db_identifier
        Region                              = var.postgres_settings.target_region
        Env                                 = var.postgres_settings.target_env
        App                                 = var.postgres_settings.target_app
        Service                             = var.postgres_settings.target_service
    }
}

