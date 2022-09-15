##-- Creates an S3 Bucket that has a CORs Policy --##
resource "aws_s3_bucket" "cors_bucket" {
    bucket              = var.bucket_settings.target_bucket
  
    tags = {
      Name              = var.bucket_settings.target_bucket
      Region            = var.bucket_settings.target_region
      Env               = var.bucket_settings.target_env
      App               = var.bucket_settings.target_app
      Service           = var.bucket_settings.target_service
    }
}

# ACL - Version 4 of the AWS Provider requires setting the S3 Bucket ACL separately
resource "aws_s3_bucket_acl" "bucket_acl" {
    bucket              = var.bucket_settings.target_bucket
    acl                 = var.bucket_settings.bucket_acl

    depends_on = [
      aws_s3_bucket.cors_bucket
    ]
}

# CORS Rules - Version 4 of the AWS Provider requires settings the CORS rules separately
resource "aws_s3_bucket_cors_configuration" "cors_rules" {
  bucket              = var.bucket_settings.target_bucket

  cors_rule {
    allowed_headers   = var.bucket_settings_lists.allowed_headers
    allowed_methods   = var.bucket_settings_lists.allowed_methods
    allowed_origins   = var.bucket_settings_lists.allowed_origins
    expose_headers    = var.bucket_settings_lists.expose_headers
    max_age_seconds   = var.bucket_settings.max_age_seconds
  }

  depends_on = [
    aws_s3_bucket.cors_bucket
  ]
}

resource "aws_s3_bucket_public_access_block" "public_access_settings" {
    bucket                  = var.bucket_settings.target_bucket

    block_public_acls       = var.bucket_settings.block_public_acl
    block_public_policy     = var.bucket_settings.block_public_policy
    ignore_public_acls      = var.bucket_settings.ignore_public_acls
    restrict_public_buckets = var.bucket_settings.restrict_public_buckets

    depends_on = [
      aws_s3_bucket.cors_bucket
    ]
}

# Bucket Policy
# Policy Document
data "aws_iam_policy_document" "policy_doc" {
  statement {
    principals {
      type = "AWS"
      identifiers = ["arn:aws:iam::111111111111:user/${var.bucket_settings.bucket_user}"]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]

    resources = [
      "${aws_s3_bucket.cors_bucket.arn}/*",
    ]
  }
}

# Attach the policy
resource "aws_s3_bucket_policy" "policy_attach" {
  bucket    = aws_s3_bucket.cors_bucket.id
  policy    = data.aws_iam_policy_document.policy_doc.json
}
