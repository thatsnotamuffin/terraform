#- Cloudfront S3 Origins Variables -#

variable "target_bucket" {
    type = string
    description = "The S3 bucket for the Cloudfront origin"
}

variable "s3_origin_lists" {
    type = map(list(string))
    description = "A collection of lists for the allowed and cached methods and the aliases in the Cloudfront distribution"
}

variable "s3_origin_settings" {
    type = map(any)
    description = "A map of the various Cloudfront settings for the S3 origin - origin_id (str) , enabled (bool) , min_ttl (int) , default_ttl (int) , max_ttl (int) , viewer_protocol_policy (str) , forward_query (str) , forward_cookies (str) , geo_restriction_type (str) , cloudfront_cert (str arn) , min_protocol_version (str) , ssl_method (str)"
}
