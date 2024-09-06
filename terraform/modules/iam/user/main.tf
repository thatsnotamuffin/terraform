resource "aws_iam_user" "user" {
  name          = var.name
  force_destroy = var.force_destroy

  # Tags
  tags = merge({
    Name  = var.name
    Email = var.email
    Team  = var.team
  }, var.tags)
}
