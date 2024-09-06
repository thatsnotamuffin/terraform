variable "create_role_policy_attachment" {
  type        = bool
  description = "Determines whether or not to attach a role policy"
  default     = false
}

variable "role" {
  type        = string
  description = "The name of the IAM role to which the policy should be applied"
  default     = null
}

variable "create_user_policy_attachment" {
  type        = bool
  description = "Determines whether or not to attach a user policy"
  default     = false
}

variable "user" {
  type        = string
  description = "The user the policy should be applied to"
  default     = null
}

variable "policy_arn" {
  type        = string
  description = "The ARN of the policy you want to apply"
}
