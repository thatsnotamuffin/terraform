# External DNS
data "aws_iam_policy_document" "external_dns_doc" {
  statement {
    actions = [
      "route53:ChangeResourceRecordSets"
    ]
    resources = [
      "arn:aws:route53:::hostedzone/*"
    ]
    effect = "Allow"
  }
  statement {
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
    ]
    resources = [
      "*"
    ]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "external_dns_policy" {
  name        = "external-dns-policy"
  description = "Manages the External DNS Kubernetes Service"
  policy      = data.aws_iam_policy_document.external_dns_doc.json

  tags = {
    Name       = "external-dns-policy"
    Service    = "Kubernetes - ExternalDNS"
    Managed_By = "Terraform"
  }
}
