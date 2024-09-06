output "arn" {
  description = "ARN assigned to this provider"
  value       = aws_iam_openid_connect_provider.oidc.arn
}
