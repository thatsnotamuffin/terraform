terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "eks/mycluster/addons/terraform.tfstate"
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
    source = "git::https://github.com/thatsnotamuffin/terraform.git//eks/addon?ref=<relevant tag>"

    cluster_name    = "mycluster"
    target_addon    = "vpc-cni"
    version         = "v1.11.2-eksbuild.1"
}
