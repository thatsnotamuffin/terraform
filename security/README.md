# Security
A collection of security modules for KMS and IAM. The IAM section has 'hard-coded' configs as each IAM setup can be different per organization. These are meant for reference material when considering your own infrastructure provisioning and permissions.

## IAM 
A module that creates various IAM resources. This is highly dependent on specific requirements for an organization and can't necessarily be covered in a README in this repo's context. To summarize this section, the IAM configs create groups, users, roles, and various policies.

### General Flow
Policies are created first then applied to their respective roles, groups, or users.

Groups are created first then users.

The role resources are not dependent on other resources being deployed. The policy attachments are dependent on the role and policy, if applicable, being created.

### Policies
The policy configs use an `aws_iam_policy_document` resource to create the policy that is later referenced via the `aws_iam_policy` resource.

[IAM Policy Document Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/data-sources/iam_policy_document)

[IAM Policy Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/iam_policy)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `name` | String | Name of the policy | my-policy |
| `description` | String | Description for the policy | This is my policy |
| `Environment` | String | Environment the policy is created for | dev |

### Roles
The role configs create an AWS IAM role and attach a policy either referenced by an ARN copied from AWS or referencing an ARN from a created policy within the terraform configs.

[IAM Role Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/iam_role)

[IAM Role Policy Attachment Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/iam_role_policy_attachment)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `name` | String | Name of the IAM role | my-role |
| `assume_role_policy` | JSON/String | Policy to assume for the role | my-policy |
| `Service` | String | Service the role supports | Kubernetes |
| `Environment` | String | Environment the role is created for | dev

### Groups
The groups config creates a group then adds users to the group via the `aws_iam_user_group_membership` resource. The group membership is dependent on the user being created first.

[IAM Group Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/iam_group)

[IAM User Group Membership Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/iam_user_group_membership)

[IAM Group Policy Attachment Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/iam_group_policy_attachment)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `name` | String | Name of the group to be created | developers |
| `policy_arn` | String | ARN of the policy to be attached to the group | arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly |

### Users
The users config creates users but applies no permissions to individual users as they are to be managed within the IAM groups.

[IAM User Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/iam_user)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `name` | String | Name of the IAM user | my-user |
| `force_destroy` | Bool | Force destroy the user's credentials even if they're not managed by Terraform | true
| `Email` | String | Email of the user | my-user@myurl.com |
| `Supervisor` | String | Name or Email of the supervisor for the user | my-supervisor@myurl.com |
| `Team` | String | The team the user belongs to | R&D |

## KMS
This module creates a KMS key and an alias for it

[KMS Key Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/kms_key)

[KMS Alias Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/kms_alias)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `description` | String | Description for the KMS key | Encrypts EBS volumes |
| `deletion_window_in_days` | Number | How many days the key exists before being deleted when scheduled for deletion | 10 |
| `enable_key_rotation` | Bool | Enable key rotation | true |
| `kms_key_alias` | String | Name of the KMS key | "alias/ebs-key" |
| `purpose` | String | What the KMS key encrypts | EBS volumes |
| `region` | String | Region the key is created in | us-east-1 |
| `environment` | String | Environment the key is created for | dev |
