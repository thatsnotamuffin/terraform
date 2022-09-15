terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "cloudfront/s3-origins/alias/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "alias_s3_origin" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//cloudfront/s3-origins/alias?ref=<relevant tag>"

    target_region               = "us-east-1"
    # S3 Bucket for data source
    target_bucket               = "publiccontent"

    s3_origin_lists = {
        aliases                 = ["cloud.example.com"]
        allowed_methods         = ["GET", "HEAD"]
        cached_methods          = ["GET", "HEAD"]
    }

    s3_origin_settings = {
        cloud_origin_id         = "cloud-publiccontent"
        enabled                 = true
        min_ttl                 = 0
        default_ttl             = 5
        max_ttl                 = 60
        viewer_protocol_policy  = "allow-all"
        forward_query           = false
        forward_cookies         = "none"
        geo_restriction_type    = "none"
        cloudfront_cert         = "arn:aws:acm:us-east-1:000111222333:certificate/0123abcd"
        min_protocol_version    = "TLSv1.2_2021"
        ssl_method              = "sni-only"
    }
}

