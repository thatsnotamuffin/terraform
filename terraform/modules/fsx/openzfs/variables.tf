# Tags
variable "tags" {
  type        = map(string)
  description = "A map defining user-supplied tags"
  default     = {}
}

variable "region" {
  type        = string
  description = "AWS region the resource is created in"
  default     = "us-east-1"
}

variable "name" {
  type        = string
  description = "Name of the file system"
}

# FSx
variable "deployment_type" {
  type        = string
  description = "The filesystem deployment type. Valid values: SINGLE_AZ_1, SINGLE_AZ_2 and MULTI_AZ_1"
  default     = "SINGLE_AZ_1"
}

variable "storage_capacity" {
  type        = number
  description = "The storage capacity (GiB) of the file system. Valid values between 64 and 524288"
  default     = 100
}

variable "throughput_capacity" {
  type        = number
  description = "Throughput (MB/s) of the file system. Valid values depend on deployment_typ"
  default     = 256 # Assumes that deployment_type is SINGLE_AZ_1
}

# Backup and Maintenance
variable "automatic_backup_retention_days" {
  type        = number
  description = "The number of days to retain automatic backups. Setting this to 0 disables automatic backups. You can retain automatic backups for a maximum of 90 days"
  default     = 7
}

variable "backup_id" {
  type        = string
  description = " The ID of the source backup to create the filesystem from"
  default     = null
}

variable "copy_tags_to_backups" {
  type        = bool
  description = "A boolean flag indicating whether tags for the file system should be copied to backups"
  default     = true
}

variable "copy_tags_to_volumes" {
  type        = bool
  description = "A boolean flag indicating whether tags for the file system should be copied to snapshots"
  default     = true
}

variable "daily_automatic_backup_start_time" {
  type        = string
  description = "A recurring daily time, in the format HH:MM"
  default     = "05:00"
}

variable "skip_final_backup" {
  type        = bool
  description = "When enabled, will skip the default final backup taken when the file system is deleted"
  default     = false
}

variable "weekly_maintenance_start_time" {
  type        = string
  description = "The preferred start time (in d:HH:MM format) to perform weekly maintenance, in the UTC time zone"
  default     = "sun:05:00"
}

# Storage
variable "kms_key_id" {
  type        = string
  description = "ARN for the KMS Key to encrypt the file system at rest, Defaults to an AWS managed KMS Key"
  default     = ""
}

variable "iops" {
  type        = number
  description = "The total number of SSD IOPS provisioned for the file system"
  default     = "value"
}

variable "mode" {
  type        = string
  description = "Specifies whether the number of IOPS for the file system is using the system. Valid values are AUTOMATIC and USER_PROVISIONED"
  default     = "AUTOMATIC"
}

variable "copy_tags_to_snapshots" {
  type        = bool
  description = "A boolean flag indicating whether tags for the file system should be copied to snapshots"
  default     = true
}

variable "data_compression_type" {
  type        = string
  description = "Method used to compress the data on the volume. Valid values are LZ4, NONE or ZSTD"
  default     = "value"
}

variable "read_only" {
  type        = bool
  description = "Specifies whether the volume is read-only"
  default     = false
}

variable "record_size_kib" {
  type        = number
  description = "Specifies the record size of an OpenZFS root volume, in kibibytes (KiB). Valid values are 4, 8, 16, 32, 64, 128, 256, 512, or 1024 KiB"
  default     = 128
}

variable "user_and_group_quotas" {
  type = list(object({
    id                         = number # The ID of the user or group
    storage_capacity_quota_gib = number # The amount of storage that the user or group can use in gibibytes (GiB)
    type                       = string # A value that specifies whether the quota applies to a user or group
  }))
  description = "Specify how much storage users or groups can use on the volume"
}

# Networking and Security
variable "subnet_ids" {
  type        = list(string)
  description = "A list of IDs for the subnets that the file system will be accessible from"
}

variable "preferred_subnet_id" {
  type        = string
  description = "Required when deployment_type is set to MULTI_AZ_1"
  default     = null
}

variable "security_group_ids" {
  type        = list(string)
  description = "A list of IDs for the security groups that apply to the specified network interfaces created for file system access"
}

# Secondary Volumes
variable "volumes" {
  type        = any
  description = "A map of OpenZFS volumes to create"
  default     = {}
}
