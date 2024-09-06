data "aws_iam_policy_document" "eks_all_access_doc" {
  statement {
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters"
    ]
    resources = [
      "arn:aws:ssm:*:111222333444:parameter/aws/*",
      "arn:aws:ssm:*::parameter:aws/*"
    ]
    effect = "Allow"
  }
  statement {
    actions = [
      "eks:*"
    ]
    resources = [
      "*"
    ]
    effect = "Allow"
  }
  statement {
    actions = [
      "kms:CreateGrant",
      "kms:DescribeKey"
    ]
    resources = [
      "*"
    ]
    effect = "Allow"
  }
  statement {
    actions = [
      "logs:PutRetentionPolicy"
    ]
    resources = [
      "*"
    ]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "eks_all_access_policy" {
  name        = "eks-all-access-policy"
  description = "Policy to allow role to necessary EKS resources"
  policy      = data.aws_iam_policy_document.eks_all_access_doc.json

  tags = {
    Name       = "eks-iam-access-policy"
    Service    = "Kubernetes"
    Managed_By = "Terraform"
  }
}
