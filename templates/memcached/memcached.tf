terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "memcached/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "memcached" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//memcached?ref=<relevant tag>"

    # Security
    target_security_groups      = ["sg-000aaa111bbb", "sg-222ccc333ddd"]

    # Networking
    db_subnets                  = ["subnet-abc123def000", "subnet-abc123def111"]

    memcached = {
        subnet_group_name       = "memcached-subnet"
        cluster_id              = "my-memcached"
        node_type               = "cache.t3.medium"
        num_cache_nodes         = 2
        parameter_group_name    = "default.memcached1.6"
        port                    = 11211
        target_region           = "us-east-1"
        target_env              = "Stage"
    }
}
