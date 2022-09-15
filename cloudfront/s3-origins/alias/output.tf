output "cf_domain" {
    description = "CloudFront domain for alias"
    value = aws_cloudfront_distribution.alias_s3_origin_distribution.domain_name
}

