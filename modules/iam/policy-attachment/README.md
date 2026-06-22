# IAM Role Policy Attachment Module
## Overview
This module attaches an already existing IAM policy to an already existing IAM role

| Terraform Version | 
| ---- |
| `>= 1.8.4` |

| Provider | Version |
| ---- | ---- |
| `aws` | `>= 6.51.0` |

## Terraform Documentation
[aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/6.51.0/docs/resources/iam_role_policy_attachment)

## Variables and Values
| Variable | Type | Description | Default | Required |
| ---- | ---- | ---- | ---- | ---- |
| `role` | string | The name of the IAM role to which the policy should be applied | none | yes |
| `policy_arn` | string | The ARN of the policy you want to apply | none | yes |

## Example
```hcl
module "myrole_policy_attach" {
  source = "git::https://github.com/thatsnotamuffin/terraform.git//modules/iam/policy-attachment?ref=v0.1.0"

  role       = "myrole"
  policy_arn = "arn:aws:iam::1122334455:policy/myrole-policy"
}
```
