# General
variable "bucket" {
  type        = string
  description = "Name of the S3 bucket"
}

# Server Side Encryption
variable "kms_key" {
  type        = string
  description = "ARN of the KMS key to encrypt the S3 bucket"
  default     = null
}

variable "algorithm" {
  type        = string
  description = "Algorithm to encrypt the S3 bucket - I.E. aws:kms"
  default     = null
}

# ACL Ownership
variable "object_ownership" {
  type        = string
  description = "Ownership of the bucket objects - I.E. BucketOwnerPreferred"
  default     = null
}

# ACL
variable "acl" {
  type        = string
  description = "ACL to apply to the bucket - I.E. private"
  default     = null
}

# Public Access
variable "block_public_acls" {
  type        = bool
  description = "Block public ACLs"
  default     = null
}

variable "block_public_policy" {
  type        = bool
  description = "Block public policies"
  default     = null
}

variable "ignore_public_acls" {
  type        = bool
  description = "Ignore public ACLs"
  default     = null
}

variable "restrict_public_buckets" {
  type        = bool
  description = "Restrict public bucket policies"
  default     = null
}

# Bucket Versioning
variable "status" {
  type        = string
  description = "Enable versioning - Enabled - Disabled - Suspeneded"
  default     = null
}
