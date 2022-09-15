terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "eks/mycluster/nodegroup/mynodegroup/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "eks_cluster" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//eks/node-group?ref=<relevant tag>"

    cluster_name        = "mycluster"
    node_group_name     = "mynodegroup"
    node_role_arn       = "arn:aws:iam::000aaa111bbbc:role/my-node-role-name"
    subnet_ids          = ["subnet-000aaa111bbb", "subnet-222ccc333ddd"]
    instance_types      = ["m5.large"]
    disk_size           = 100
    force_update        = true
    
    node_labels = {
        Role            = "general-use"
    }

    scaling_settings = {
        desired_size    = 10
        max_size        = 20
        min_size        = 5
    }

    update_max_unavailable = 1
    ssh_key         = "my-ssh-key"
    security_groups = ["sg-000aaa111bbb", "sg-222ccc333ddd"]
    target_region   = "us-east-1"
    target_env      = "Stage"
    target_app      = "MyApp"
    target_service  = "MyService"
}
