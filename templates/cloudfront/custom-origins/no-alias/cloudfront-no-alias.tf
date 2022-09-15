terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "cloudfront/custom-origin/no-alias/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "no_alias" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//cloudfront/custom-origins/no-alias?ref=<relevant tag>"

    target_region                   = "us-east-1"

    # Listed custom origin settings
    custom_origin_lists = {
        allowed_methods             = ["GET", "HEAD"]
        cached_methods              = ["GET", "HEAD"]
        origin_ssl_protocols        = ["TLSv1.1", "TLSv1.2"]
    }

    custom_origin_settings = {
        # Origin
        domain_name                 = "api.example.com"
        origin_id                   = "api"
        origin_protocol_policy      = "match-viewer"
        http_port                   = 80
        https_port                  = 443
        enabled                     = true
        ipv6_enabled                = true

        # Default Cache Behavior
        viewer_protocol_policy      = "allow-all"

        # Forwarded Values
        forward_query               = false
        forward_cookies             = "none"

        # Restrictions
        geo_restriction_type        = "none"

        # Certificate
        cloudfront_cert             = "arn:aws:acm:us-east-1:000111222333:certificate/0123abcd"
        min_protocol_version        = "TLSv1.2_2021"
        ssl_method                  = "sni-only"
    }
}
