terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "cloudfront/custom-origin/alias-origin/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

# App - Assets
module "app_assets" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//cloudfront/custom-origins/alias-origin?ref=<relevant tag>"

    target_region               = "us-east-1"
    target_bucket               = "logs"
    
    custom_origin_lists = {
        aliases                 = ["assets.example.com"]
        origin_ssl_protocols    = ["TLSv1.1", "TLSv1.2"]
        allowed_methods         = ["GET", "HEAD", "OPTIONS"]
        cached_methods          = ["GET", "HEAD", "OPTIONS"]
    }

    custom_origin_settings = {
        # Origin
        domain_name             = "app.example.com"
        origin_id               = "assets"
        origin_protocol_policy  = "http-only"
        http_port               = 80
        https_port              = 443
        enabled                 = true
        ipv6_enabled            = true

        # Default Cache Behavior
        min_ttl                 = 0
        default_ttl             = 86400
        max_ttl                 = 31536000
        viewer_protocol_policy  = "allow-all"

        # Forwarded Values
        forward_query           = false
        forward_cookies       = "none"

        # Logging Config
        include_cookies         = false
        logging_prefix          = "cf-logs"

        # Restrictions
        geo_restriction_type    = "none"

        # Certificate
        cloudfront_cert         = "arn:aws:acm:us-east-1:000111222333:certificate/0123abcd"
        min_protocol_version    = "TLSv1.2_2021"
        ssl_method              = "sni-only"
    }
}
