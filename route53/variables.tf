#-- Route53 Variables --#

#variable "zone_id" {
#    type = string
#    description = "The target Zone ID to create the Route53 record(s)"
#}

#variable "r53_name" {
#    type = string
#    description = ""
#}

#variable "record_type" {
#    type = string
#    description = "The type of Route53 record to create"
#}

#variable "r53_ttl" {
#    type = number
#    description = "The TTL for the record - some record types have a default determined by AWS and are unchangeable"
#}

#variable "record_list" {
#    type = list(string)
#    description = "A list of records to create with these settings"
#}

variable "route_53_records" {
    type = map(object({
        zone_id             = string
        r53_name            = string
        record_type         = string
        r53_ttl             = number
        record_list         = list(string)
    }))
}

