# Backends
The backends don't leverage a module structure and are defined specifically for their respective environment. The configs found here create an S3 tfstate backend, a DynamoDB used for terraform locks, and a KMS key to encrypt the contents.

[Backend Documentation](https://developer.hashicorp.com/terraform/language/settings/backends/s3)

The KMS key is set to enable the key to be rotated.

The S3 bucket has versioning enabled with private only permissions.

## Required Input
Copy and pasting one of the example configs is advised. The only changes that need to be made are to the names of the DynamoDB table, the S3 bucket name, and the KMS key name (if desired). As well as the `Region` and `Environment` tags for these resources
