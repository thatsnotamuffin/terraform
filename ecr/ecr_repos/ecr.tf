##-- ECR Repositories --##

resource "aws_ecr_repository" "ecr_repos" {
    for_each                = var.ecr_repo_targets

    name                    = "${each.value.repo_name}"
    image_tag_mutability    = "${each.value.mutability}"

    image_scanning_configuration {
      scan_on_push          = "${each.value.image_scan}"
    }

    tags = {
        Name                = "${each.value.repo_name}"
        Region              = "${each.value.target_region}"
        Env                 = "${each.value.target_env}"
        App                 = "${each.value.target_app}"
    }
}

# Images Lifecycle Policy
# There is a limit of 10 prefixs and then you have to create another rule
resource "aws_ecr_lifecycle_policy" "ecr_tagged_lifecycle" {
  for_each                  = var.ecr_repo_targets
  repository                = "${each.value.repo_name}"

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep only the last 90 images",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"],
        "countType": "imageCountMoreThan",
        "countNumber": 90
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 2,
      "description": "Keep only the last 90 images",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["k", "l", "m", "n", "o", "p", "q", "r", "s", "t"],
        "countType": "imageCountMoreThan",
        "countNumber": 90
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 3,
      "description": "Keep only the last 90 images",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["u", "v", "w", "x", "y", "z", "0", "1", "2", "3"],
        "countType": "imageCountMoreThan",
        "countNumber": 90
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 4,
      "description": "Keep only the last 90 images",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["4", "5", "6", "7", "8", "9"],
        "countType": "imageCountMoreThan",
        "countNumber": 90
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 5,
      "description": "Keep only the last 14 days of untagged images",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": 14
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
  depends_on = [
    aws_ecr_repository.ecr_repos
  ]
}

