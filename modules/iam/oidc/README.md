# IAM OIDC Module
## Overview
This module creates an IAM OIDC

| Terraform Version | 
| ---- |
| `>= 1.8.4` |

| Provider | Version |
| ---- | ---- |
| `aws` | `>= 6.51.0` |

## Terraform Documentation
[aws_iam_openid_connect_provider](https://registry.terraform.io/providers/hashicorp/aws/6.51.0/docs/resources/iam_openid_connect_provider)

## Variables and Values
### <ins>Tags</ins>
| Variable | Type | Description | Default |
| ---- | ---- | ---- | ---- |
| `tags` | map(string) | A map defining user-supplied tags | `{}` |
| `name` | string | Name of the IAM OIDC | none |
| `description` | string | A description of the OIDC and its purpose | none |
| `source_terraform` | string | The URL of the Terraform code in the repo this module is used in. NOTE: not the central Terraform repo origin (thatsnotamuffin/terraform) | none |

### <ins>IAM OIDC</ins>
| Variable | Type | Description | Default |
| ---- | ---- | ---- | ---- |
| `url` | string | The URL of the identity provider. Corresponds to the iss claim | none |
| `client_id_list` | list(string) | A list of client IDs (also known as audiences) | none |
| `thumbprint_list` | list(string) | A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s) | none |

## Outputs
| Output | Description |
| ---- | ---- |
| `arn` | The ARN assigned by AWS for this provider |
| `url` | The URL for the provider |

## Example
```hcl
module "github_oidc" {
  source = "git::https://github.com/thatsnotamuffin/terraform.git//modules/iam/oidc?ref=v0.1.0"

  # Tags
  name             = "GitHub OIDC"
  description      = "OIDC for GitHub to interact with IAM roles"
  source_terraform = "https://github.com/thatsnotamuffin/somerepo/terraform/oidc.tf"

  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["959cb2b52b4ad201a593847abca32ff48f838c2e"]
}
```
