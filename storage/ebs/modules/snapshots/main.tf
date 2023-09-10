resource "aws_ebs_snapshot" "ebs_snapshot" {
  volume_id   = var.volume_id
  description = var.description

  tags = {
    Name        = var.snapshot_name
    Origin      = var.volume_id
    Region      = var.region
    Environment = var.environment
    App         = var.supported_app
    Service     = var.supported_service
    Managed_By  = "Terraform"
  }
}
