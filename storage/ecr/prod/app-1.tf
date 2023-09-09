# Repo 1
module "app_repo_1" {
    source = "../modules/ecr-repo"

    # Tags
    region = local.region

    # Repo Settings
    name = local.app_1_name
    image_tag_mutability = "MUTABLE"
    scan_on_push = false  
}

module "app_lifecycle_1" {
    source = "../modules/ecr-policy"

    container_repo = local.app_1_name
    image_retention_count = 100
    untagged_image_retention = 14
}
