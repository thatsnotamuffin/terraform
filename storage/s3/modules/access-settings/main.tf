# Server Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_server_side_encryption" {
  bucket = var.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key
      sse_algorithm     = var.algorithm
    }
  }
}

# ACL Ownership
resource "aws_s3_bucket_ownership_controls" "bucket_acl_ownership" {
  bucket = var.bucket

  rule {
    object_ownership = var.object_ownership
  }
}

# ACL
resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = var.bucket
  acl    = var.acl
}

# Public Access
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = var.bucket

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

# Bucket Versioning
resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = var.bucket

  versioning_configuration {
    status = var.status
  }
}
