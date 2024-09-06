# Tags
variable "tags" {
  type        = map(string)
  description = "A map defining user-supplied tags"
  default     = {}
}

variable "email" {
  type        = string
  description = "Email address for the user - if applicable"
  default     = null
}

variable "team" {
  type        = string
  description = "Team the user belongs to - if applicable"
  default     = null
}

# User
variable "name" {
  type        = string
  description = "Name of the IAM user"
}

variable "force_destroy" {
  type        = bool
  description = "When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices"
  default     = false
}
