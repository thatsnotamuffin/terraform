#- Cloudfront Origin Access Identity Variables -#

variable "cloudfront_origin_identity" {
    type = string
    description = "A comment to label the Cloudfront Origin Access Identity"
}

variable "target_region" {
    type = string
    description = "The region the AWS provider references"
}

