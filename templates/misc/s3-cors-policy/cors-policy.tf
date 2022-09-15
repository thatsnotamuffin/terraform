terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "misc/cors-policy/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "s3_cors" {
  source = "git::https://github.com/thatsnotamuffin/terraform.git//misc/s3-cors-policy?ref=<relevant tag>"

  bucket_settings = {
    target_bucket           = "my-cors-bucket"
    bucket_acl              = "private"
    max_age_seconds         = 3000
    target_region           = "us-east-1"
    target_env              = "Stage"
    target_app              = "N/A"
    target_service          = "N/A"
    block_public_acl        = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
    user                    = "user"
  }
}
