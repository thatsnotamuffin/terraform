resource "aws_cloudfront_distribution" "no_alias_custom_origin" {
    origin {
        domain_name                         = var.custom_origin_settings.domain_name
        origin_id                           = var.custom_origin_settings.origin_id

        custom_origin_config {
            origin_protocol_policy          = var.custom_origin_settings.origin_protocol_policy
            origin_ssl_protocols            = var.custom_origin_lists.origin_ssl_protocols
            http_port                       = var.custom_origin_settings.http_port
            https_port                      = var.custom_origin_settings.https_port
        }
    }

    enabled                                 = var.custom_origin_settings.enabled
    is_ipv6_enabled                         = var.custom_origin_settings.ipv6_enabled

    default_cache_behavior {
      allowed_methods                       = var.custom_origin_lists.allowed_methods
      cached_methods                        = var.custom_origin_lists.cached_methods
      target_origin_id                      = var.custom_origin_settings.origin_id
      viewer_protocol_policy                = var.custom_origin_settings.viewer_protocol_policy
      
      forwarded_values {
        query_string                        = var.custom_origin_settings.forward_query

        cookies {
            forward                         = var.custom_origin_settings.forward_cookies
        }
      }
    }

    restrictions {
      geo_restriction {
          restriction_type                  = var.custom_origin_settings.geo_restriction_type
      }
    }

    viewer_certificate {
      acm_certificate_arn                   = var.custom_origin_settings.cloudfront_cert
      minimum_protocol_version              = var.custom_origin_settings.min_protocol_version
      ssl_support_method                    = var.custom_origin_settings.ssl_method
    }
}
