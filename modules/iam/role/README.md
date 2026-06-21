# IAM Role Module
## Overview
This module creates an IAM role and an instance profile if needed by setting the `create_instance_profile` variable to `true`. This will create an instance profile with the same name as the role that is created.

| Terraform Version | 
| ---- |
| `>= 1.8.4` |

| Provider | Version |
| ---- | ---- |
| `aws` | `>= 6.51.0` |

## Terraform Documentation
[aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/6.51.0/docs/resources/iam_role)

[aws_iam_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/6.51.0/docs/resources/iam_instance_profile)

## Variables and Values
### <ins>Tags</ins>
| Variable | Type | Description | Default |
| ---- | ---- | ---- | ---- |
| `tags` | string | A map defining user-supplied tags | `{}` |
| `description` | string | A description of the IAM Role and its purpose | none |
| `source_terraform` | string | The URL of the Terraform code in the repo this module is used in. NOTE: not the central Terraform repo origin (thatsnotamuffin/terraform) | none |

### <ins>IAM Role</ins>
| Variable | Type | Description | Default |
| ---- | ---- | ---- | ---- |
| `name` | string | Name of the IAM role | none |
| `assume_role_policy` | string | Policy that grants an entity permission to assume the role | none |
| `create_instance_profile` | bool | Determines whether or not to make the instance role an instance profile | `false` |

## Example
```hcl
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
  source = "git::https://github.com/thatsnotamuffin/terraform.git//modules/iam/role?ref=v0.1.0"

  # Tags
  description      = "A role for my application"
  source_terraform = "https://github.com/thatsnotamuffin/somerepo/terraform/role.tf"

  name                    = "myrole"
  assume_role_policy      = local.my_role_trust_policy
  create_instance_profile = true
}
```
