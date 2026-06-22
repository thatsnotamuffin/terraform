variable "role" {
  type        = string
  description = "The name of the IAM role to which the policy should be applied"
  default     = null
}

variable "policy_arn" {
  type        = string
  description = "The ARN of the policy you want to apply"
}
