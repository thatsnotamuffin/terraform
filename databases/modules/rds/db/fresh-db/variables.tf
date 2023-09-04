# Tags
variable "region" {
  type        = string
  description = "Region the database is deployed in"
}

variable "environment" {
  type        = string
  description = "Environment the database is deployed in"
}

variable "supported_service" {
  type        = string
  description = "Service the database supports"
}

variable "supported_app" {
  type        = string
  description = "App the database supports"
}

# General Instance Settings
variable "db_identifier" {
  type        = string
  description = "Name of the database"
}

variable "engine" {
  type        = string
  description = "Name of the database engine to be used"
  default     = "postgres"
}

variable "engine_version" {
  type        = string
  description = "Engine version to use"
  default     = "13"
}

variable "instance_class" {
  type        = string
  description = "Instance class for the database - refer to AWS documentation"
  default     = "db.m6g.large"
}

variable "deletion_protection" {
  type        = bool
  description = "Enable deletion protection"
  default     = true
}

variable "parameter_group_name" {
  type        = string
  description = "Name of the parameter group for the database"
}

# Storage
variable "storage_encrypted" {
  type        = bool
  description = "Encrypt storage"
  default     = true
}

variable "kms_key_id" {
  type        = string
  description = "ARN of the KMS key used to encrypt"
}

variable "storage_type" {
  type        = string
  description = "Storage type - refer to AWS documentation"
  default     = "gp3"
}

# Authentication
variable "db_name" {
  type        = string
  description = "Name of the database to create when the instance is created"
  default     = "postgres"
}

variable "username" {
  type        = string
  description = "Username for the master user"
  sensitive   = true
}

variable "password" {
  type        = string
  description = "Password for the master user"
  sensitive   = true
}

# Networking
variable "db_subnet_group_name" {
  type        = string
  description = "DB subnet group name"
}

# Security
variable "iam_database_authentication_enabled" {
  type        = bool
  description = "Enable IAM database authentication"
  default     = false
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs"
}

# Maintenance
variable "allow_major_version_upgrade" {
  type        = bool
  description = "Allow major version upgrade"
  default     = false
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Allow auto minor version upgrade"
  default     = true
}

variable "maintenance_window" {
  type        = string
  description = "Maintenance window - ddd:hh24:mi-ddd:hh24:mi - I.E. Mon:00:00-Mon:03:00"
  default     = null
}

variable "apply_immediately" {
  type        = bool
  description = "Apply changes immediately"
  default     = false
}

# Backup
variable "skip_final_snapshot" {
  type        = bool
  description = "Skip final snapshot when database is deleted"
  default     = null
}

variable "final_snapshot_identifier" {
  type        = string
  description = "Final snapshot name"
  default     = null
}

variable "backup_retention_period" {
  type        = number
  description = "Backup retention in Days"
  default     = null
}

variable "backup_window" {
  type        = string
  description = "Backup window - daily time range 24h in UTC - I.E. 09:00-10:00 - cannot overlap with maintenance window"
  default     = null
}

variable "copy_tags_to_snapshot" {
  type        = bool
  description = "Copy the DB instance tags to snapshots"
  default     = null
}
