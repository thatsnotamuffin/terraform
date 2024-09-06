# Tags
variable "tags" {
  type        = map(string)
  description = "A map defining user-supplied tags"
  default     = {}
}

variable "name" {
  type        = string
  description = "Name of the container repo"
}

variable "region" {
  type        = string
  description = "Region the container repo is hosted"
  default     = "us-east-1"
}

# Repository
variable "image_tag_mutability" {
  type        = string
  description = "Mutability setting for the repo - MUTABLE or IMMUTABLE"
  default     = "MUTABLE"
}

variable "scan_on_push" {
  type        = bool
  description = "Scan the images when pushed to the ECR"
  default     = false
}

# Lifecycle
variable "set_policy" {
  type        = bool
  description = "Set to true to create a lifecycle policy for the container repo"
  default     = true
}

variable "untagged_image_retention" {
  type        = number
  description = "How many days to retain untagged images"
  default     = 14
}

variable "image_retention_count" {
  type        = number
  description = "The amount of images to retain"
  default     = 100
}
