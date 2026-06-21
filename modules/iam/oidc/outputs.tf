output "arn" {
  value       = aws_iam_openid_connect_provider.oidc.arn
  description = "The ARN assigned by AWS for this provider"
}

output "url" {
  value       = aws_iam_openid_connect_provider.oidc.url
  description = "The URL for the provider"
}
