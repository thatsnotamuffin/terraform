resource "aws_ebs_volume" "vol_from_snapshot" {
  availability_zone = var.az_id
  final_snapshot    = var.final_snapshot
  snapshot_id       = var.snapshot_id
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
