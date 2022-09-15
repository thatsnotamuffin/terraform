#-- S3 CORs Variables --#
variable "bucket_settings" {
    type = map(any)
    description = "S3 Bucket settings with CORs Policy"
}

variable "bucket_settings_lists" {
    type = map(list(string))
    description = "A map of bucket lists for the CORs policies"
    default = {
        allowed_headers = ["*"]
        allowed_methods = ["GET"]
        allowed_origins = ["*"],
        expose_headers = []
    }
}

