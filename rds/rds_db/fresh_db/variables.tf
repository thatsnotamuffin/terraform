##-- RDS Variables --##

# Network and Security
variable "db_subnets" {
    type = list(string)
    description = "List of DB Subnets to create the RDS instance and subnet group in"
}

variable "target_security_groups" {
    type = list(string)
    description = "List of security groups to apply to the database"
}

#- RDS Settings
variable "rds_db_username" {
    type = string
    description = "The RDS username to associate with the database set up - marked as sensitive"
    sensitive = true
}

variable "rds_db_password" {
    type = string
    description = "The RDS password to associate with the database set up - marked as sensitive"
    sensitive = true
}

variable "postgres_settings" {
    type = map(any)
    description = "A map of the RDS postgres settings - rds_subnet_group_name (str) , db_snapshot (str) - this is required but set to none if not creating a database from a snapshot , db_identifier (str) , allocated_storage (int) , db_engine (str) , db_engine_version (str) , db_instance_class (str) , name (str) , skip_final_snapshot (bool) , allow_major_version_upgrade (bool) , auto_minor_upgrade (bool) , backup_retention (int) , backup_window (str) , maintenance_window (str) , snapshot_tags (bool) , delete_protection (bool) , final_snapshot_identifier (str) , iam_auth_enabled (bool) , encrypted_storage (bool) , kms_key (str) , storage_type (str) , target_region (str) , target_env (str) , target_app (str) , target_service (str)"
}

