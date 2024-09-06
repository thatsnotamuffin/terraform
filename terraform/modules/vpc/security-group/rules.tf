resource "aws_security_group_rule" "rule" {
  for_each = { for k, v in var.rules : k => v }

  security_group_id = aws_security_group.security_group.id

  protocol  = each.value.protocol
  from_port = each.value.from_port
  to_port   = each.value.to_port
  type      = each.value.type

  # Optional
  description              = lookup(each.value, "description", null)
  cidr_blocks              = lookup(each.value, "cidr_blocks", null)
  ipv6_cidr_blocks         = lookup(each.value, "ipv6_cidr_blocks", null)
  prefix_list_ids          = lookup(each.value, "prefix_list_ids", null)
  self                     = lookup(each.value, "self", null)
  source_security_group_id = lookup(each.value, "source_security_group_id", null)

  depends_on = [
    aws_security_group.security_group
  ]
}
