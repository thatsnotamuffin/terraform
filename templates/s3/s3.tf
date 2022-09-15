terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "s3/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "s3_buckets" {
  source = "git::https://github.com/thatsnotamuffin/terraform.git//s3?ref=<relevant tag>"
  s3_buckets = {
    bucket1 = {
      target_bucket           = "bucket-1"
      target_acl              = "private"
      target_region           = "us-east-1"
      target_env              = "Stage"
      target_app              = "App"
      target_service          = "MyService"
      block_public_acl        = true
      block_public_policy     = true
      ignore_public_acls      = true
      restrict_public_buckets = true
    },
    bucket2 = {
      target_bucket           = "bucket-2"
      target_acl              = "private"
      target_region           = "us-east-1"
      target_env              = "Stage"
      target_app              = "App"
      target_service          = "MyService"
      block_public_acl        = true
      block_public_policy     = true
      ignore_public_acls      = true
      restrict_public_buckets = true
    },
    bucket3 = {
      target_bucket           = "bucket-3"
      target_acl              = "private"
      target_region           = "us-east-1"
      target_env              = "Stage"
      target_app              = "App"
      target_service          = "MyService"
      block_public_acl        = true
      block_public_policy     = true
      ignore_public_acls      = true
      restrict_public_buckets = true
    },
  }
}

