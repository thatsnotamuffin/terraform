resource "aws_dlm_lifecycle_policy" "ebs_lifecycle_policy" {
  description        = var.description
  execution_role_arn = var.execution_role_arn
  state              = var.state

  policy_details {
    resource_types = var.resource_types

    schedule {
      name = var.schedule_name

      create_rule {
        interval      = var.create_interval
        interval_unit = var.create_interval_unit
        times         = var.times
      }

      retain_rule {
        interval      = var.retain_interval
        interval_unit = var.retain_interval_unit
      }

      copy_tags = var.copy_tags
    }

    target_tags = {
      Name = var.target_name
    }
  }

  tags = {
    Name        = var.lifecycle_name
    Region      = var.region
    Environment = var.environment
    Managed_By  = "Terraform"
  }
}
