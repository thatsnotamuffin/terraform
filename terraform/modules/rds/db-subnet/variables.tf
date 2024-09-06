# Tags
variable "region" {
  type        = string
  description = "Region the subnet group is deployed in"
}

variable "environment" {
  type        = string
  description = "Environment the subnet group is deployed in"
}

# Subnet Group
variable "subnet_group_name" {
  type        = string
  description = "Name of the subnet group"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs"
}
