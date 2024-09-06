# Tags
variable "region" {
  type        = string
  description = "Region the lifecycle policy is created for"
}

variable "environment" {
  type        = string
  description = "Environment the lifecycle applies to"
}

# Lifecycle
variable "lifecycle_name" {
  type        = string
  description = "Name of the lifecycle"
}

variable "description" {
  type        = string
  description = "Description for the lifecycle"
}

variable "execution_role_arn" {
  type        = string
  description = "ARN of the execution role to create the snapshots"
}

variable "state" {
  type        = string
  description = "ENABLED - DISABLED"
  default     = "ENABLED"
}

variable "resource_types" {
  type        = list(string)
  description = "Resource types for the lifecycle - VOLUME - INSTANCE"
  default     = ["VOLUME"]
}

variable "schedule_name" {
  type        = string
  description = "Name of the schedule"
}

variable "create_interval" {
  type        = number
  description = "How often in hours this policy is to be executed"
  default     = 24
}

variable "create_interval_unit" {
  type        = string
  description = "Interval unit to execute the policy - only HOURS is currently supported"
  default     = "HOURS"
}

variable "times" {
  type        = list(string)
  description = "Times to execute the policy = 24h"
  default     = ["23:00"]
}

variable "retain_interval" {
  type        = number
  description = "How long to retain the snapshot"
  default     = 7
}

variable "retain_interval_unit" {
  type        = string
  description = "Unit to describe the retention interval - HOURS - DAYS - MONTHS - YEARS"
  default     = "DAYS"
}

variable "copy_tags" {
  type        = bool
  description = "Copy tags from the source"
  default     = true
}

variable "target_name" {
  type        = string
  description = "Naming convention of the snapshot"
}
