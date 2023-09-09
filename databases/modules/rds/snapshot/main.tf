resource "aws_db_snapshot" "rds_snapshot" {
  db_instance_identifier = var.db_instance
  db_snapshot_identifier = var.db_snapshot_identifier

  # Tags
  tags = {
    Name            = var.db_snapshot_identifier
    Region          = var.region
    Environment     = var.environment
    Source_Instance = var.db_instance
  }
}
