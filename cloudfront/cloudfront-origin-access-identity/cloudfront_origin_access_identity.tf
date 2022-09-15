##-- Cloudfront Origin Access Identity --##

resource "aws_cloudfront_origin_access_identity" "cloudfront_private_content" {
    comment = var.cloudfront_origin_identity
}

