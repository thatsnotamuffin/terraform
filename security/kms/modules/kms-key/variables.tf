# Tags
variable "purpose" {
  type        = string
  description = "What the KMS Key encrypts"
}

variable "region" {
  type        = string
  description = "Region the key is created in"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Environment the key is created for"
}

# Key
variable "kms_key_alias" {
  type        = string
  description = "Name of the KMS key"
}

variable "description" {
  type        = string
  description = "Description for the KMS key"
}

variable "deletion_window_in_days" {
  type        = number
  description = "How many days the key exists before being deleted"
}

variable "enable_key_rotation" {
  type        = bool
  description = "Enable key rotation"
}
