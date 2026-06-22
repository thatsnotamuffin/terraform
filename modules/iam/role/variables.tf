# Tags
variable "tags" {
  type        = map(string)
  description = "A map defining user-supplied tags"
  default     = {}
}

variable "description" {
  type        = string
  description = "A description of the IAM Role and its purpose"
}

variable "source_terraform" {
  type        = string
  description = "The URL of the Terraform code in the repo this module is used in. NOTE: not the central Terraform repo origin (thatsnotamuffin/terraform)"
}

# IAM Role
variable "name" {
  type        = string
  description = "Name of the IAM role"
}

variable "assume_role_policy" {
  type        = string
  description = "Policy that grants an entity permission to assume the role"
}

variable "create_instance_profile" {
  type        = bool
  description = "Determines whether or not to make the instance role an instance profile"
  default     = false
}
