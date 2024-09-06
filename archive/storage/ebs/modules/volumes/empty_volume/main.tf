resource "aws_ebs_volume" "empty_vol" {
  availability_zone = var.az_id
  final_snapshot    = var.final_snapshot
  size              = var.vol_size
  type              = "gp3"
  encrypted         = true
  kms_key_id        = var.kms_key_id
  iops              = var.iops
  throughput        = var.throughput

  tags = {
    Name        = var.vol_name
    Region      = var.region
    Environment = var.environment
    App         = var.supported_app
    Service     = var.supported_service
    Managed_By  = "Terraform"
  }
}
