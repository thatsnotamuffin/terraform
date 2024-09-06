# Tags
variable "snapshot_name" {
  type        = string
  description = "Name of the snapshot"
}

variable "region" {
  type        = string
  description = "Region the snapshot is created in"
}

variable "environment" {
  type        = string
  description = "Environment the snapshot is created for"
}

variable "supported_app" {
  type        = string
  description = "App the snapshot supports"
}

variable "supported_service" {
  type        = string
  description = "Service the snapshot supports"
}

# Snapshot
variable "volume_id" {
  type        = string
  description = "Source volume the snapshot is created from"
}

variable "description" {
  type        = string
  description = "Description for the snapshot"
}
