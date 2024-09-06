resource "aws_iam_openid_connect_provider" "oidc" {
  url             = var.url
  client_id_list  = var.client_id_list
  thumbprint_list = var.thumbprint_list

  tags = merge({
    Purpose    = var.purpose
    Created_By = var.created_by
    Managed_By = "Terraform"
  }, var.tags)
}
