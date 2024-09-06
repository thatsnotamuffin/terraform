# Elasticsearch
data "aws_iam_policy_document" "eks_doc" {
  statement {
    actions = [
      "eks:DescribeCluster",
      "eks:ListClusters"
    ]
    resources = [
      "*"
    ]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "eks_access_policy" {
  name        = "eks-access-policy"
  description = "EKS access permissions"
  policy      = data.aws_iam_policy_document.eks_doc.json

  tags = {
    Name        = "eks-access-policy"
    Environment = "All"
    Managed_By  = local.managed_by
  }
}
