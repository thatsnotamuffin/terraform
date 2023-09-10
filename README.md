# Terraform
Example repository for a collection of AWS Terraform modules. 

`Terraform Version: 1.4.6`

`AWS Provider Version: 5.1.0`

# File Structure
This Repo covers 3 example environments - Dev - Pre-Production/Staging - Production. Some modules only have a global need, such as the IAM permissions for developers and infrastructure engineers found in the `security/iam` configs. 

More details for each section can be found in the associated directory's `README.md`
```
├── ami
│   ├── dev
│   ├── modules
│   │   └── create-ami
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       ├── variables.tf
│   │       └── versions.tf
│   ├── pre-prod
│   └── prod
├── backends
│   ├── dev
│   │   ├── main.tf
│   │   └── versions.tf
│   ├── pre-prod
│   │   ├── main.tf
│   │   └── versions.tf
│   └── prod
│       ├── main.tf
│       └── versions.tf
├── databases
│   ├── dev
│   ├── modules
│   │   ├── dynamodb
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── versions.tf
│   │   ├── memcached
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── versions.tf
│   │   └── rds
│   │       ├── db
│   │       │   ├── fresh-db
│   │       │   │   ├── main.tf
│   │       │   │   ├── variables.tf
│   │       │   │   └── versions.tf
│   │       │   └── from-snapshot
│   │       │       ├── main.tf
│   │       │       ├── variables.tf
│   │       │       └── versions.tf
│   │       ├── db-subnet
│   │       │   ├── main.tf
│   │       │   ├── variables.tf
│   │       │   └── versions.tf
│   │       ├── parameter-group
│   │       │   ├── main.tf
│   │       │   ├── variables.tf
│   │       │   └── versions.tf
│   │       └── snapshot
│   │           ├── main.tf
│   │           ├── variables.tf
│   │           └── versions.tf
│   ├── pre-prod
│   └── prod
├── docs
│   ├── example_pull_request.md
│   └── pull_request_template.md
├── README.md
├── security
│   ├── iam
│   │   └── prod
│   │       ├── backend.tf
│   │       ├── dlm-lifecycle-policy.tf
│   │       ├── eks-access-policy.tf
│   │       ├── eks-all-access-policy.tf
│   │       ├── eks-autoscaler-policy.tf
│   │       ├── eks-iam-access-policy.tf
│   │       ├── external-dns-policy.tf
│   │       ├── force-mfa-policy.tf
│   │       ├── groups.tf
│   │       ├── locals.tf
│   │       ├── roles.tf
│   │       ├── users.tf
│   │       └── versions.tf
│   └── kms
│       ├── dev
│       ├── modules
│       │   └── kms-key
│       │       ├── main.tf
│       │       ├── variables.tf
│       │       └── versions.tf
│       ├── pre-prod
│       └── prod
├── servers
│   ├── dev
│   ├── modules
│   │   ├── elasticsearch
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── versions.tf
│   │   ├── mongodb
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── versions.tf
│   │   └── nginx
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── versions.tf
│   ├── pre-prod
│   └── prod
└── storage
    ├── ebs
    │   ├── dev
    │   ├── modules
    │   │   ├── snapshots
    │   │   │   ├── main.tf
    │   │   │   ├── outputs.tf
    │   │   │   ├── variables.tf
    │   │   │   └── versions.tf
    │   │   └── volumes
    │   │       ├── empty_volume
    │   │       │   ├── main.tf
    │   │       │   ├── outputs.tf
    │   │       │   ├── variables.tf
    │   │       │   └── versions.tf
    │   │       └── from_snapshot
    │   │           ├── main.tf
    │   │           ├── outputs.tf
    │   │           ├── variables.tf
    │   │           └── versions.tf
    │   ├── pre-prod
    │   └── prod
    ├── ecr
    │   ├── modules
    │   │   ├── ecr-policy
    │   │   │   ├── main.tf
    │   │   │   ├── variables.tf
    │   │   │   └── versions.tf
    │   │   └── ecr-repo
    │   │       ├── main.tf
    │   │       ├── variables.tf
    │   │       └── versions.tf
    │   └── prod
    ├── lifecycle
    │   ├── dev
    │   ├── modules
    │   │   └── ebs-lifecycle
    │   │       ├── main.tf
    │   │       ├── variables.tf
    │   │       └── versions.tf
    │   ├── pre-prod
    │   └── prod
    └── s3
        ├── dev
        ├── modules
        │   ├── access-settings
        │   │   ├── main.tf
        │   │   ├── outputs.tf
        │   │   ├── variables.tf
        │   │   └── versions.tf
        │   └── create-bucket
        │       ├── main.tf
        │       ├── outputs.tf
        │       ├── variables.tf
        │       └── versions.tf
        ├── pre-prod
        └── prod

```

