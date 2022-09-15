terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "eks/mycluster/cluster/terraform.tfstate"
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
    source = "git::https://github.com/thatsnotamuffin/terraform.git//eks/cluster?ref=<relevant tag>"

    cluster_name        = "mycluster"
    version             = "1.21"
    cluster_role        = "arn:aws:iam::000aaa111bbbc:role/my-cluster-role-name"
    subnet_ids          = ["subnet-000aaa111bbb", "subnet-222ccc333ddd"]
    public_access       = true
    private_access      = false
    security_group_ids  = ["sg-000aaa111bbb", "sg-222ccc333ddd"]
    cluster_log_types   = ["api", "authenticator"]
    target_region       = "us-east-1"
    target_env          = "Stage"
    target_app          = "MyApp"
    target_service      = "MyService"
}
