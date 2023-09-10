# Tags
variable "vol_name" {
  type        = string
  description = "Name of the EBS volume"
}

variable "region" {
  type        = string
  description = "Region the volume is created in"
}

variable "environment" {
  type        = string
  description = "Environment the volume is created for"
}

variable "supported_app" {
  type        = string
  description = "App the volume supports"
}

variable "supported_service" {
  type        = string
  description = "Service the volume supports"
}

# EBS
variable "az_id" {
  type        = string
  description = "Availability Zone for the volume"
}

variable "final_snapshot" {
  type        = bool
  description = "Create a snapshot of the volume when it's deleted"
  default     = false
}

variable "vol_size" {
  type        = number
  description = "The size in GB of the volume"
  default     = 50
}

variable "kms_key_id" {
  type        = string
  description = "ARN of the KMS key to encrypt the volume"
}

variable "iops" {
  type        = number
  description = "The iOPS for the volume"
  default     = 3000
}

variable "throughput" {
  type        = number
  description = "The throughput of the volume in MiB/s"
  default     = 125
}
