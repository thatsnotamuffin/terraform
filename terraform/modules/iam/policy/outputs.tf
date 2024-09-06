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
