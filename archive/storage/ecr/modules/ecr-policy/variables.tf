variable "container_repo" {
  type        = string
  description = "ECR name"
}

variable "image_retention_count" {
  type        = number
  description = "The amount of images to retain"
  default     = 90
}

variable "untagged_image_retention" {
  type        = number
  description = "How many days to retain untagged images"
  default     = 14
}
