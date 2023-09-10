#- EC2 Instance
# Data Instance
resource "aws_instance" "replset_instance" {
  count = var.replset_count

  ami           = var.ami
  instance_type = var.instance_type

  # Block Device - Root
  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
    encrypted   = true
    kms_key_id  = var.kms_key_id

    tags = {
      Name        = "root-vol-${var.replset_instance_names[count.index]}"
      Region      = var.region
      Environment = var.environment
      Service     = var.supported_service
      App         = var.supported_app
      Managed_By  = "Terraform"
    }
  }

  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.db_subnets[count.index]
  key_name               = var.ssh_key

  tags = {
    Name                  = var.replset_instance_names[count.index]
    Region                = var.region
    Environment           = var.environment
    Service               = var.supported_service
    App                   = var.supported_app
    "mongodb:replset"     = var.mongo_replset
    "mongodb:description" = var.mongo_description
    Hostname              = var.mongo_hostnames[count.index]
    Managed_By            = "Terraform"
  }
}

# Arbiter
resource "aws_instance" "arbiter_instance" {
  ami           = var.ami
  instance_type = var.instance_type

  # Block Device - Root
  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
    encrypted   = true
    kms_key_id  = var.kms_key_id

    tags = {
      Name        = "root-vol-${var.arbiter_instance_name}"
      Region      = var.region
      Environment = var.environment
      Service     = var.supported_service
      App         = var.supported_app
      Managed_By  = "Terraform"
    }
  }

  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.arbiter_subnet
  key_name               = var.ssh_key

  tags = {
    Name                  = var.arbiter_instance_name
    Region                = var.region
    Environment           = var.environment
    Service               = var.supported_service
    App                   = var.supported_app
    "mongodb:replset"     = var.mongo_replset
    "mongodb:description" = var.mongo_description
    Hostname              = var.arbiter_hostname
    Managed_By            = "Terraform"
  }
}

# Volume Attachment
resource "aws_volume_attachment" "mongo_replset_data_vol" {
  count        = var.replset_count
  device_name  = "/dev/xvdb"
  volume_id    = var.data_vol_ids[count.index]
  instance_id  = aws_instance.replset_instance[count.index].id
  skip_destroy = var.data_vol_destroy

  depends_on = [
    aws_instance.replset_instance
  ]
}

resource "aws_volume_attachment" "mongo_arbiter_data_vol" {
  device_name  = "/dev/xvdb"
  volume_id    = var.arbiter_data_vol
  instance_id  = aws_instance.arbiter_instance.id
  skip_destroy = var.data_vol_destroy

  depends_on = [
    aws_instance.arbiter_instance
  ]
}

# Route53
resource "aws_route53_record" "replset_record" {
  count   = length(aws_instance.replset_instance)
  zone_id = var.zone_id
  ttl     = 60
  name    = var.mongo_hostnames[count.index]
  type    = "A"
  records = [aws_instance.replset_instance[count.index].private_ip]
}

resource "aws_route53_record" "arbiter_record" {
  zone_id = var.zone_id
  ttl     = 60
  name    = var.arbiter_hostname
  type    = "A"
  records = [aws_instance.arbiter_instance.private_ip]
}
