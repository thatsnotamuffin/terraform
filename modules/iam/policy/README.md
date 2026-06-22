# IAM Policy Module
## Overview
This module creates an IAM policy.

| Terraform Version | 
| ---- |
| `>= 1.8.4` |

| Provider | Version |
| ---- | ---- |
| `aws` | `>= 6.51.0` |

## Terraform Documentation
[aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/6.51.0/docs/data-sources/iam_policy_document)

[aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/6.51.0/docs/resources/iam_policy)

## Variables and Values
### <ins>Tags</ins>
| Variable | Type | Description | Default |
| ---- | ---- | ---- | ---- |
| `tags` | string | A map defining user-supplied tags | `{}` |
| `description` | string | A description of the IAM Role and its purpose | none |
| `source_terraform` | string | The URL of the Terraform code in the repo this module is used in. NOTE: not the central Terraform repo origin (thatsnotamuffin/terraform) | none |

### <ins>Policy</ins>
| Variable | Type | Description | Default |
| ---- | ---- | ---- | ---- |
| `name` | string | Name of the policy. If omitted, Terraform will assign a random, unique name | none |
| `description` | string | Description of the IAM policy | none |
| `statement` | list(object) | Configuration block for a policy statement | none |
| `statement.sid` | string | Sid (statement ID) is an identifier for a policy statement | none |
| `statement.actions` | list(string) | List of actions that this statement either allows or denies | none |
| `statement.resources` | list(string) |  List of resource ARNs that this statement applies to | none |
| `statement.effect` | string | Whether this statement allows or denies the given actions. Valid values are Allow and Deny | none |
| `statement.principals` | list(object) | Configuration block for principals | none |
| `statement.principals.type` | string | Type of principal. Valid values include `AWS`, `Service`, `Federated`, `CanonicalUser` and `*` | none |
| `statement.principals.identifiers` | list(string) | List of identifiers for principals. When `statement.principals.type` is `AWS`, these are IAM principal ARNs. When `statement.principals.type` is `Federated`, these are web identity users or SAML provider ARNs. When `statement.principals.type` is `CanonicalUser`, these are [canonical user IDs](https://docs.aws.amazon.com/general/latest/gr/acct-identifiers.html#FindingCanonicalId) | none |
| `statement.conditions` | list(object) | Configuration block for a condition | none |
| `statement.conditions.test` | string | Name of the [IAM condition operator](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition_operators.html) to evaluate | none |
| `statement.conditions.variable` | string | Name of a [Context Variable](http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements.html#AvailableKeys) to apply the condition to | none |
| `statement.conditions.values` | list(string) | Values to evaluate the condition against. If multiple values are provided, the condition matches if at least one of them applies | none |

## Outputs
| Output | Description |
| ---- | ---- |
| `arn` | ARN assigned by AWS to this policy |
| `id` | ARN assigned by AWS to this polic |
| `policy_id` | Policy's ID. |
| `json` | Standard JSON policy document rendered based on the arguments |
| `minified_json` | Minified JSON policy document rendered based on the arguments |

**Example Policy**
```hcl
module "example_iam_policy" {
  source = "git::https://github.com/thatsnotamuffin/terraform.git//modules/iam/policy?ref=v0.1.0"

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
```
