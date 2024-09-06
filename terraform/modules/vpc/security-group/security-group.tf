resource "aws_security_group" "security_group" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge({
    Name        = var.name
    Region      = var.region
    Description = var.description
  }, var.tags)
}
