data "aws_iam_policy_document" "document" {
  dynamic "statement" {
    for_each = var.statement
    content {
      sid       = statement.value.sid
      actions   = statement.value.actions
      resources = statement.value.resources
      effect    = statement.value.effect

      dynamic "principals" {
        for_each = statement.value.principals
        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = statement.value.conditions
        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}

resource "aws_iam_policy" "policy" {
  name        = var.name
  description = var.description
  policy      = data.aws_iam_policy_document.document.json

  # Tags
  tags = local.tags
}
