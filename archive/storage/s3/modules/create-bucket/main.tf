resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.bucket
  force_destroy = var.force_destroy

  tags = {
    Name        = var.bucket
    Purpose     = var.purpose
    Environment = var.environment
    Managed_By  = "Terraform"
  }
}
