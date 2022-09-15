##-- Route53 Records --##
#- Miscellaneous records not handled by other modules

#resource "aws_route53_record" "r53_record" {
#    zone_id         = var.zone_id
#    name            = var.r53_name
#    type            = var.record_type
#    ttl             = var.r53_ttl
#    records         = var.record_list
#}

resource "aws_route53_record" "r53_record" {
    for_each        = var.route_53_records
    
    zone_id         = "${each.value.zone_id}"
    name            = "${each.value.r53_name}"
    type            = "${each.value.record_type}"
    ttl             = "${each.value.r53_ttl}"
    records         = "${each.value.record_list}"
}

