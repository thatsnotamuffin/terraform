# Terraform
Centralized Terraform repository - used to host modules

## Release
Refer to this [document](./docs/README.md) for how to perform releases. Each merge to the `main` branch must be followed by a new release.

> [!TIP]
> A `source_terraform` variable is used frequently in tags. This is to apply a tag to the AWS resource describing where the terraform originated from for easy tracking when looking in the AWS console. A `Managed_By` tag is also used to easily identify which resources are created by Terraform when looking in the AWS console.

> [!NOTE]
> Most of these modules will make use of a locals block for the tags in order to set some required tags for the resource as well as allowing a list of user supplied tags for the resource
