# Autoscaler Policy
data "aws_iam_policy_document" "autoscaler_doc" {
  statement {
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeScalingActivities",
      "autoscaling:DescribeTags",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeLaunchTemplateVersions",
    ]
    resources = [
      "*"
    ]
    effect = "Allow"
  }
  statement {
    actions = [
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "ec2:DescribeImages",
      "ec2:GetInstanceTypesFromInstanceRequirements",
      "eks:DescribeNodegroup",
    ]
    resources = [
      "*"
    ]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "autoscaler_policy" {
  name        = "eks-autoscaler-policy"
  description = "Permissions for Kubernetes Autoscaler"
  policy      = data.aws_iam_policy_document.autoscaler_doc.json

  tags = {
    Name       = "eks-autoscaler-policy"
    Service    = "Kubernetes - Autoscaler"
    Managed_By = "Terraform"
  }
}
