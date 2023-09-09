resource "aws_db_subnet_group" "rds_db_subnet_group" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids

  # Tags
  tags = {
    Name        = var.subnet_group_name
    Region      = var.region
    Environment = var.environment
  }
}
