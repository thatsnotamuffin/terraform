data "aws_iam_policy_document" "eks_iam_doc" {
  statement {
    actions = [
      "iam:CreateInstanceProfile",
      "iam:DeleteInstanceProfile",
      "iam:GetInstanceProfile",
      "iam:RemoveRoleFromInstanceProfile",
      "iam:GetRole",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:AttachRolePolicy",
      "iam:PutRolePolicy",
      "iam:ListInstanceProfiles",
      "iam:AddRoleToInstanceProfile",
      "iam:ListInstanceProfilesForRole",
      "iam:PassRole",
      "iam:DetachRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:GetRolePolicy",
      "iam:GetOpenIDConnectProvider",
      "iam:CreateOpenIDConnectProvider",
      "iam:DeleteOpenIDConnectProvider",
      "iam:TagOpenIDConnectProvider",
      "iam:ListAttachedRolePolicies",
      "iam:TagRole",
      "iam:GetPolicy",
      "iam:CreatePolicy",
      "iam:DeletePolicy",
      "iam:ListPolicyVersions"
    ]
    resources = [
      "arn:aws:iam::111222333444:instance-profile/eksctl-*",
      "arn:aws:iam::111222333444:role/eksctl-*",
      "arn:aws:iam::111222333444:policy/eksctl-*",
      "arn:aws:iam::111222333444:oidc-provider/*",
      "arn:aws:iam::111222333444:role/aws-service-role/eks-nodegroup.amazonaws.com/AWSServiceRoleForAmazonEKSNodegroup",
      "arn:aws:iam::111222333444:role/eksctl-managed-*"
    ]
    effect = "Allow"
  }
  statement {
    actions = [
      "iam:GetRole"
    ]
    resources = [
      "arn:aws:iam::111222333444:role/*"
    ]
    effect = "Allow"
  }
  statement {
    actions = [
      "iam:CreateServiceLinkedRole"
    ]
    resources = [
      "*"
    ]
    effect = "Allow"
    condition {
      test     = "StringEquals"
      variable = "iam:AWSServiceName"
      values = [
        "eks.amazonaws.com",
        "eks-nodegroup.amazonaws.com",
        "eks-fargate.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_policy" "eks_iam_policy" {
  name        = "eks-iam-limited-access-policy"
  description = "Limited IAM access for EKS"
  policy      = data.aws_iam_policy_document.eks_iam_doc.json

  tags = {
    Name       = "eks-iam-access-policy"
    Service    = "Kubernetes"
    Managed_By = "Terraform"
  }
}
