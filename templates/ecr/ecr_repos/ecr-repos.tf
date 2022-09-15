terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "ecr/repos/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "ecr_repositories" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ecr/ecr_repos?ref=<relevant tag>"

    ecr_repo_targets = {
        ecr1 = {
            repo_name               = "ecr1"
            mutability              = "MUTABLE"
            image_scan              = false
            target_region           = "us-east-1"
            target_env              = "N/A"
            target_app              = "MyApp1"
        },
        ecr2 = {
            repo_name               = "ecr2"
            mutability              = "MUTABLE"
            image_scan              = false
            target_region           = "us-east-1"
            target_env              = "N/A"
            target_app              = "MyApp2"
        },
        ecr3 = {
            repo_name               = "ecr3"
            mutability              = "MUTABLE"
            image_scan              = false
            target_region           = "us-east-1"
            target_env              = "N/A"
            target_app              = "MyApp3"
        },
    }
}

