# Tags
variable "region" {
  type        = string
  description = "Region the snapshot is created in"
}

variable "environment" {
  type        = string
  description = "Environment the snapshot is created for"
}

# Snapshot
variable "db_instance" {
  type        = string
  description = "The database identifier to take the snapshot from"
}

variable "db_snapshot_identifier" {
  type        = string
  description = "The name of the snapshot"
}
