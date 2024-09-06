resource "aws_ecr_lifecycle_policy" "ecr_tagged_lifecycle" {
  repository = var.container_repo

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep only the last ${var.image_retention_count} images",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"],
        "countType": "imageCountMoreThan",
        "countNumber": ${var.image_retention_count}
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 2,
      "description": "Keep only the last ${var.image_retention_count} images",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["k", "l", "m", "n", "o", "p", "q", "r", "s", "t"],
        "countType": "imageCountMoreThan",
        "countNumber": ${var.image_retention_count}
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 3,
      "description": "Keep only the last ${var.image_retention_count} images",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["u", "v", "w", "x", "y", "z", "0", "1", "2", "3"],
        "countType": "imageCountMoreThan",
        "countNumber": ${var.image_retention_count}
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 4,
      "description": "Keep only the last ${var.image_retention_count} images",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["4", "5", "6", "7", "8", "9"],
        "countType": "imageCountMoreThan",
        "countNumber": ${var.image_retention_count}
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 5,
      "description": "Keep only the last ${var.untagged_image_retention} days of untagged images",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": ${var.untagged_image_retention}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}
