# Tags
variable "purpose" {
  type   = string
  string = "What data does the S3 bucket serve or store"
}

variable "environment" {
  type   = string
  string = "Environment the bucket is created for"
}

# Bucket
variable "bucket" {
  type   = string
  string = "Name of the S3 bucket"
}

variable "force_destroy" {
  type   = bool
  string = "Delete the contents of the bucket when the bucket is destroyed"
}
