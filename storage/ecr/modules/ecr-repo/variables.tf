# Tags
variable "region" {
  type        = string
  description = "Region the ECR is created in"
}

# Repo
variable "name" {
  type        = string
  description = "Name of the ECR"
}

variable "image_tag_mutability" {
  type        = string
  description = "Mutability setting for the repo - MUTABLE or IMMUTABLE"
  default     = "MUTABLE"
}

variable "scan_on_push" {
  type        = bool
  description = "Scan the images when pushed to ECR"
}
