module "github_oidc" {
  source = "../../../modules/iam/oidc"

  # Tags
  name             = "GitHub OIDC"
  description      = "OIDC for GitHub to interact with IAM roles"
  source_terraform = "https://github.com/thatsnotamuffin/somerepo/terraform/oidc.tf"

  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["959cb2b52b4ad201a593847abca32ff48f838c2e"]
}
