#- Cloudfront Custom Origins Variables -#

variable "custom_origin_lists" {
    type = map(list(string))
    description = "A collection of lists for the allowed and cached methods and the aliases in the Cloudfront distribution"
}

variable "custom_origin_settings" {
    type = map(any)
    description = "A map of the various Cloudfront settings for the Custom origin - origin_id (str) , enabled (bool) , min_ttl (int) , default_ttl (int) , max_ttl (int) , viewer_protocol_policy (str) , forward_query (str) , forward_cookies (str) , geo_restriction_type (str) , cloudfront_cert (str arn) , min_protocol_version (str) , ssl_method (str)"
}
