output "cf_domain" {
    description = "CloudFront domain for alias"
    value = aws_cloudfront_distribution.no_alias_s3_origin_distribution.domain_name
}

