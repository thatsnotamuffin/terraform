resource "aws_iam_policy_document" "document" {
  dynamic "statement" {
    for_each = var.statement
    content {
      actions   = statement.value.actions
      resources = statement.value.resources
      effect    = statement.value.effect
    }
  }
}

resource "aws_iam_policy" "policy" {
  name        = var.name
  description = var.description
  policy      = data.aws_iam_policy_document.document.json

  # Tags
  tags = merge({
    Name        = var.name
    Description = var.description
    Managed_By  = "Terraform"
  }, var.tags)

  depends_on = [
    aws_iam_policy_document.document
  ]
}
