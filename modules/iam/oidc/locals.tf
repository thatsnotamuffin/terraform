locals {
  tags = merge({
    Name             = var.name
    Description      = var.description
    Source_Terraform = var.source_terraform
    Managed_By       = "Terraform"
  }, var.tags)
}
