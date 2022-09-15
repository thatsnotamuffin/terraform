##-- Cloudfront --##
#- S3 Origins

# Data Source for S3 bucket regional domain name
data "aws_s3_bucket" "selected" {
    bucket = var.target_bucket
}

resource "aws_cloudfront_distribution" "alias_s3_origin_distribution" {
    origin {
        domain_name                     = data.aws_s3_bucket.selected.bucket_regional_domain_name
        origin_id                       = var.s3_origin_settings.cloud_origin_id
    }

    enabled                             = var.s3_origin_settings.enabled
    aliases                             = var.s3_origin_lists.aliases

    default_cache_behavior {
      allowed_methods                   = var.s3_origin_lists.allowed_methods
      cached_methods                    = var.s3_origin_lists.cached_methods
      target_origin_id                  = var.s3_origin_settings.cloud_origin_id
      min_ttl                           = var.s3_origin_settings.min_ttl
      default_ttl                       = var.s3_origin_settings.default_ttl
      max_ttl                           = var.s3_origin_settings.max_ttl
      viewer_protocol_policy            = var.s3_origin_settings.viewer_protocol_policy

      forwarded_values {
        query_string                    = var.s3_origin_settings.forward_query

        cookies {
            forward                     = var.s3_origin_settings.forward_cookies
        }
      }
    }

    restrictions {
        geo_restriction {
            restriction_type            = var.s3_origin_settings.geo_restriction_type
        }
    }

    viewer_certificate {
        acm_certificate_arn             = var.s3_origin_settings.cloudfront_cert
        minimum_protocol_version        = var.s3_origin_settings.min_protocol_version
        ssl_support_method              = var.s3_origin_settings.ssl_method
    }
}

