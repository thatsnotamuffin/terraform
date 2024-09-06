
resource "aws_iam_role_policy_attachment" "role_attachment" {
  count      = var.create_role_policy_attachment ? 1 : 0
  role       = var.role
  policy_arn = var.policy_arn
}

resource "aws_iam_user_policy_attachment" "user_attachment" {
  count      = var.create_user_policy_attachment ? 1 : 0
  user       = var.user
  policy_arn = var.policy_arn
}
