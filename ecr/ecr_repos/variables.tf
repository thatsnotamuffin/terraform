#- ECR Variables -#

variable "ecr_repo_targets" {
    type = map(object({
        repo_name           = string
        mutability          = string
        image_scan          = bool
        target_region       = string
        target_env          = string
        target_app          = string
    }))
}

