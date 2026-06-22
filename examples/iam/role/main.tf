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

module "my_role" {
  source = "../../../modules/iam/role"

  # Tags
  description      = "A role for my application"
  source_terraform = "https://github.com/thatsnotamuffin/somerepo/terraform/role.tf"

  name                    = "myrole"
  assume_role_policy      = local.my_role_trust_policy
  create_instance_profile = true
}
