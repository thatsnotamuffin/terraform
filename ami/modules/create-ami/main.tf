resource "aws_ami_from_instance" "create_ami" {
  name               = var.ami_name
  source_instance_id = var.source_instance_id

  tags = {
    Name         = var.ami_name
    Region       = var.region
    Environment  = var.environment
    Created_Date = "${timestamp()}"
  }
}
