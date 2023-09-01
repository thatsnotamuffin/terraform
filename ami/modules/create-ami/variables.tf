# Tags
variable "region" {
  type        = string
  description = "Region the AMI is being created in"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Environment the AMI belongs to"
}

# AMI Settings
variable "ami_name" {
  type        = string
  description = "Name of the AMI"
}

variable "source_instance_id" {
  type        = string
  description = "The instance ID to create the AMI from"
}
