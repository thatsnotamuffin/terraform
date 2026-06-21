output "arn" {
  value       = aws_iam_policy.policy.arn
  description = "ARN assigned by AWS to this policy"
}

output "id" {
  value       = aws_iam_policy.policy.id
  description = "ARN assigned by AWS to this policy"
}

output "policy_id" {
  value       = aws_iam_policy.policy.policy_id
  description = "Policy's ID"
}

output "json" {
  value       = data.aws_iam_policy_document.document.json
  description = "Standard JSON policy document rendered based on the arguments"
}

output "minified_json" {
  value       = data.aws_iam_policy_document.document.minified_json
  description = "Minified JSON policy document rendered based on the arguments"
}
