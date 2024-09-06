resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge({
    Name       = var.name
    Region     = var.region
    Managed_By = "Terraform"
  }, var.tags)
}

resource "aws_vpc_dhcp_options" "dhcp_options" {
  count = var.dhcp_options_enabled ? 1 : 0

  domain_name         = var.domain_name
  domain_name_servers = var.domain_name_servers

  tags = merge({
    Name       = var.name
    Region     = var.region
    Managed_By = "Terraform"
  })

  depends_on = [
    aws_vpc.vpc
  ]
}

resource "aws_vpc_dhcp_options_association" "dhcp_options_association" {
  count = var.dhcp_options_enabled ? 1 : 0

  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp_options[0].id

  depends_on = [
    aws_vpc_dhcp_options.dhcp_options
  ]
}
