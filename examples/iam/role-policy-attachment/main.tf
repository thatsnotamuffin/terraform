locals {
  my_role_trust_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

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

module "my_role" {
  source = "../../../modules/iam/role"

  # Tags
  description      = "A role for my application"
  source_terraform = "https://github.com/thatsnotamuffin/somerepo/terraform/role.tf"

  name                    = "myrole"
  assume_role_policy      = local.my_role_trust_policy
  create_instance_profile = true
}

module "myrole_policy_attach" {
  source = "../../../modules/iam/policy-attachment"

  role       = module.my_role.name
  policy_arn = module.example_iam_policy.arn
}
