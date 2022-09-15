terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "cloudfront/origin-access-identity/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "cloudfront_origin_identity" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//cloudfront/cloudfront-origin-access-identity?ref=<relevant tag>"

    cloudfront_origin_identity = "Cloudfront Private Content"
}

