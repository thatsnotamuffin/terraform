# Tags
variable "tags" {
  type        = map(string)
  description = "A map defining user-supplied tags"
  default     = {}
}

# Policy
variable "name" {
  type        = string
  description = "Name of the policy"
}

variable "description" {
  type        = string
  description = "Description of the IAM policy"
}

variable "statement" {
  type = list(object({
    actions   = list(string)
    resources = list(string)
    effect    = string
  }))
}
