module "mongo_servers" {
  source = "../modules/mongodb"

  # Tags
  region            = local.region
  environment       = local.environment
  supported_app     = "My App"
  supported_service = "MongoDB 4.2"
  mongo_replset     = "thatsnotamuffin-mongodb-${local.domain_environment}"
  mongo_description = "thatsnotamuffin-mongodb-${local.domain_environment}"

  # General Instance Settings
  replset_count          = 2
  ami                    = local.ami
  instance_type          = "t3.medium"
  kms_key_id             = local.kms_key_id
  ssh_key                = local.ssh_key
  replset_instance_names = ["thatsnotamuffin-mongo-1-${local.domain_environment}", "thatsnotamuffin-mongo-2-${local.domain_environment}"]
  arbiter_instance_name  = "thatsnotamuffin-arbiter-${local.domain_environment}"

  # Storage
  volume_size      = 50
  volume_type      = "gp3"
  data_vol_ids     = [data.aws_ebs_volume.mongo_vol_1.id, data.aws_ebs_volume.mongo_vol_2.id]
  arbiter_data_vol = data.aws_ebs_volume.mongo_vol_3.id
  data_vol_destroy = false

  # Networking
  vpc_security_group_ids = local.db_security_groups
  db_subnets             = local.db_subnets
  arbiter_subnet         = "subnet-333ccc"

  # Route53
  zone_id          = local.zone_id
  mongo_hostnames  = ["thatsnotamuffin-mongo-1.myurl.com", "thatsnotamuffin-mongo-2.myurl.com"]
  arbiter_hostname = "thatsnotamuffin-mongo-3.myurl.com"
}
