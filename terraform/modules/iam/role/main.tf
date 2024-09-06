resource "aws_iam_role" "role" {
  name               = var.name
  assume_role_policy = var.assume_role_policy

  # Tags
  tags = merge({
    Name       = var.name
    Purpose    = var.purpose
    Managed_By = "Terraform"
  }, var.tags)
}
