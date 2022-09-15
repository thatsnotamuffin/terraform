##-- EC2 Instances MongoDB --##
# This covers either the Savoy ReplicaSet or the Napa ReplicaSet - It must be ran twice to deploy both ReplicaSets
# It will deploy the EC2 instances as well as configure the relevant Route53 DNS records


#- EC2 Instances
# This deploys the replica set members that actually contain data
resource "aws_instance" "mongo_instances" {
    count                   = var.cluster_count

    # General Instance Info
    ami                     = var.general_instance_settings.global_ami
    instance_type           = var.mongodb_settings.mongo_instance_type

    # Block Devices
    # Root volume
    root_block_device {
      volume_type           = var.general_instance_settings.vol_type
      volume_size           = var.general_instance_settings.root_vol_size
      encrypted             = var.general_instance_settings.encrypted_volume
      kms_key_id            = var.general_instance_settings.kms_key

      # Tags - Required Below
      tags = {
        "Name"              = "root-vol-${var.mongo_instance_names[count.index]}"
        "Region"            = var.target_region
        "Env"               = var.target_env
        "Service"           = "MongoDB ${var.mongodb_settings.target_version}"
        "App"               = var.mongodb_settings.target_app
      }
    }

    # Security Groups
    vpc_security_group_ids  = var.target_security_groups

    # Networking
    subnet_id               = var.db_subnets[count.index]

    # Instance Profile
    iam_instance_profile    = var.mongodb_settings.instance_role

    # Miscellaneous
    key_name                = var.general_instance_settings.ssh_key

    tags = {
      "Name"                = var.mongo_instance_names[count.index]
      "Region"              = var.target_region
      "Env"                 = var.target_env
      "Service"             = "MongoDB ${var.mongodb_settings.target_version}"
      "App"                 = var.mongodb_settings.target_app
      "mongodb:replset"     = var.mongodb_settings.mongodb_replset
      "mongodb:description" = var.mongodb_settings.mongodb_description
      "hostname"            = var.mongo_hostnames[count.index]
    } 
}

# This deploys the arbiter replica set member
resource "aws_instance" "mongo_arbiter" {
  # General Instance Info
  ami           = var.general_instance_settings.global_ami
  instance_type = var.arbiter_settings.instance_type

  # Block Devices
  # Root Volume
  root_block_device {
    volume_type = var.arbiter_settings.volume_type
    volume_size = var.arbiter_settings.volume_size
    encrypted   = var.arbiter_settings.encrypted_volume
    kms_key_id  = var.arbiter_settings.kms_key_id

    tags = {
        "Name"              = "root-vol-${var.arbiter_settings.instance_name}"
        "Region"            = var.target_region
        "Env"               = var.target_env
        "Service"           = "MongoDB ${var.mongodb_settings.target_version}"
        "App"               = var.mongodb_settings.target_app
      }
    }

    # Security Groups
    vpc_security_group_ids  = var.target_security_groups

    # Networking
    subnet_id               = var.arbiter_settings.subnet_id

    # Instance Profile
    iam_instance_profile    = var.arbiter_settings.arbiter_instance_profile

    # Miscellaneous
    key_name                = var.arbiter_settings.ssh_key

    tags = {
      "Name"                = var.arbiter_settings.instance_name
      "Region"              = var.target_region
      "Env"                 = var.target_env
      "Service"             = "MongoDB ${var.mongodb_settings.target_version}"
      "App"                 = var.mongodb_settings.target_app
      "mongodb:replset"     = var.mongodb_settings.mongodb_replset
      "mongodb:description" = var.mongodb_settings.mongodb_description
      "hostname"            = var.arbiter_settings.hostname
    }
}

# Volume Attachment
# Data containing replica set instances
resource "aws_volume_attachment" "mongo_data_volume" {
  count                     = var.cluster_count
  device_name               = "/dev/xvdb"
  volume_id                 = var.data_vol_ids[count.index]
  instance_id               = aws_instance.mongo_instances[count.index].id
  skip_destroy              = var.data_vol_destroy
}

# Arbiter data volume
resource "aws_volume_attachment" "arbiter_data_vol" {
  device_name               = "/dev/xvdb"
  volume_id                 = var.arbiter_data_vol
  instance_id               = aws_instance.mongo_arbiter.id
  skip_destroy              = var.data_vol_destroy
}

#- Route53
# Data containing replica set instances
resource "aws_route53_record" "mongo_records" {
  count                     = length(aws_instance.mongo_instances)
  zone_id                   = var.mongodb_record.zone_id
  ttl                       = var.mongodb_record.ttl
  type                      = var.mongodb_record.record_type
  name                      = var.mongo_hostnames[count.index]
  records                   = [aws_instance.mongo_instances[count.index].private_ip]
}

# Arbiter
resource "aws_route53_record" "arbiter_record" {
  zone_id                   = var.mongodb_record.zone_id
  ttl                       = var.mongodb_record.ttl
  type                      = var.mongodb_record.record_type
  name                      = var.arbiter_settings.hostname
  records                   = [aws_instance.mongo_arbiter.private_ip]
}

