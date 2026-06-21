module "example_iam_policy" {
  source = "../../../modules/iam/policy"

  # Tags
  source_terraform = "https://github.com/thatsnotamuffin/somerepo/terraform/policy.tf"

  name        = "example-iam-policy"
  description = "A policy"

  statement = [
    {
      actions = [
        "s3:GetObject"
      ]
      resources = [
        "arn:aws:s3:::my-bucket/*"
      ]
      effect = "Allow"
      conditions = [
        {
          test     = "StringEquals"
          variable = "aws:SourceIp"
          values   = ["192.168.0.1"]
        }
      ]
    }
  ]
}
