locals {
  # Tags
  region             = "us-east-1"
  environment        = "Development"
  domain_environment = "dev"

  # General
  ami        = data.aws_ami.dev_ami.id
  ssh_key    = "dev-admin"
  kms_key_id = "arn:aws:kms:us-east-1:111222333444:key/111aaa-22bb-33cc-44dd-555eee666fff"

  # Networking
  ssl_policy                     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  web_security_groups            = ["sg-111", "sg-222", "sg-333"]
  web_subnets                    = ["subnet-111aaa", "subnet-222bbb", "subnet-333ccc"]
  web_vpc                        = "vpc-111aaa"
  db_security_groups             = ["sg-111", "sg-222", "sg-333"]
  db_subnets                     = ["subnet-111aaa", "subnet-222bbb", "subnet-333ccc"]
  db_vpc                         = "vpc-111aaa"
  alb_logs_bucket                = "thatsnotamuffin-dev"
  cert_arn                       = "arn:aws:kms:us-east-1:111222333444:certificate/111aaa-22bb-33cc-44dd-555eee666fff"
  alb_enable_deletion_protection = false

  # Route53
  zone_id = "Z111bbb222ccc333ddd"
}

#- Data Sources
# AMI
data "aws_ami" "dev_ami" {
  owners = ["self"]

  filter {
    name   = "tag:Name"
    values = ["thatsnotamuffin-dev-ami"]
  }
}

# Elasticsearch Volumes
data "aws_ebs_volume" "es_vol_1" {
  most_recent = true

  filter {
    name   = "tag:Name"
    values = ["data-vol-thatsnotamuffin-es-1-${local.domain_environment}"]
  }
}

data "aws_ebs_volume" "es_vol_2" {
  most_recent = true

  filter {
    name   = "tag:Name"
    values = ["data-vol-thatsnotamuffin-es-2-${local.domain_environment}"]
  }
}

data "aws_ebs_volume" "es_vol_3" {
  most_recent = true

  filter {
    name   = "tag:Name"
    values = ["data-vol-arugula-es-1-${local.domain_environment}"]
  }
}

data "aws_ebs_volume" "mongo_vol_1" {
  most_recent = true

  filter {
    name   = "tag:Name"
    values = ["data-vol-thatsnotamuffin-mongo-1-${local.domain_environment}"]
  }
}

data "aws_ebs_volume" "mongo_vol_2" {
  most_recent = true

  filter {
    name   = "tag:Name"
    values = ["data-vol-thatsnotamuffin-mongo-2-${local.domain_environment}"]
  }
}

data "aws_ebs_volume" "mongo_vol_3" {
  most_recent = true

  filter {
    name   = "tag:Name"
    values = ["data-vol-thatsnotamuffin-mongo-3-${local.domain_environment}"]
  }
}
