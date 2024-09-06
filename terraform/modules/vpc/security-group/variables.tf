# Tags
variable "tags" {
  type        = map(string)
  description = "A map of user-supplied tags"
  default     = {}
}

variable "region" {
  type        = string
  description = "Region the security group is created in"
  default     = "us-east-1"
}

# Security Group
variable "name" {
  type        = string
  description = "Name of the Security Group"
}

variable "description" {
  type        = string
  description = "Security group description"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

# Rules
variable "rules" {
  type        = any
  description = "List of additional security group rules"
  default     = {}
}
