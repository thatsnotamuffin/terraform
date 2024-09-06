# Tags
variable "tags" {
  type        = map(string)
  description = "A map defining user-supplied tags"
  default     = {}
}

variable "name" {
  type        = string
  description = "Name of the IAM role"
}

variable "purpose" {
  type        = string
  description = "The function or purpose of the role"
}

# Role
variable "assume_role_policy" {
  type        = string
  description = "Policy that grants an entity permission to assume the role"
}

variable "create_instance_profile" {
  type        = bool
  description = "Determines whether or not to make the instance role an instance profile"
  default     = false
}
