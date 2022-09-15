##-- S3 Variables --##
# Create Map objects to be iterated over
variable "s3_buckets" {
    type = map(object({
     target_bucket              = string
     target_acl                 = string
     target_region              = string
     target_env                 = string
     target_app                 = string
     target_service             = string
     block_public_acl           = bool
     block_public_policy        = bool
     ignore_public_acls         = bool
     restrict_public_buckets    = bool
    }))
}
