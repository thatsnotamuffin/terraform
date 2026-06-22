resource "aws_iam_role" "role" {
  name               = var.name
  assume_role_policy = var.assume_role_policy

  # Tags
  tags = local.tags
}

resource "aws_iam_instance_profile" "instance_profile" {
  count = var.create_instance_profile ? 1 : 0
  name  = var.name
  role  = var.name

  depends_on = [
    aws_iam_role.role
  ]
}
