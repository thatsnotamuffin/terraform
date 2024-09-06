resource "aws_iam_policy_document" "dlm_lifecycle_doc" {
  statement {
    actions = [
      "ec2:CreateSnapshot",
      "ec2:CreateSnapshots",
      "ec2:DeleteSnapshot",
      "ec2:DescribeInstances",
      "ec2:DescribeVolumes",
      "ec2:DescribeSnapshots"
    ]
    resources = [
      "*"
    ]
    effect = "Allow"
  }
  statement {
    actions = [
        "ec2:CreateTags"
    ]
    resources = [
        "arn:aws:ec2:*::snapshot/*"
    ]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "dlm_lifecycle_policy" {
  name        = "dlm-lifecycle-policy"
  description = "Lifecycle permissions"
  policy      = data.aws_iam_policy_document.dlm_lifecycle_doc

  tags = {
    Name        = "dlm-lifecycle-policy"
    Environment = "All"
    Managed_By  = local.managed_by
  }
}
