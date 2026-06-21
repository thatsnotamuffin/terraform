# Tags
variable "tags" {
  type        = map(string)
  description = "A map defining user-supplied tags"
  default     = {}
}

variable "description" {
  type        = string
  description = "A description of the IAM Policy and its purpose"
}

variable "source_terraform" {
  type        = string
  description = "The URL of the Terraform code in the repo this module is used in. NOTE: not the central Terraform repo origin (thatsnotamuffin/terraform)"
}

# IAM Policy
variable "name" {
  type        = string
  description = "Name of the IAM policy"
}

variable "statement" {
  type = list(object({
    sid       = optional(string)
    actions   = list(string)
    resources = list(string)
    effect    = string
    principals = optional(list(object({
      type        = string
      identifiers = list(string)
    })), [])
    conditions = optional(list(object({
      test     = string
      variable = string
      values   = list(string)
    })), [])
  }))
  description = "Configuration block for a policy statement"
}
