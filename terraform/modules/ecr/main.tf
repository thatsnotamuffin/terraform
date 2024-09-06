resource "aws_ecr_repository" "repo" {
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = merge({
    Name       = var.name
    Region     = var.region
    Managed_By = "Terraform"
  }, var.tags)
}


resource "aws_ecr_lifecycle_policy" "lifecycle" {
  count      = var.set_policy ? 1 : 0
  repository = var.name

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
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
    },
    {
      "rulePriority": 2,
      "description": "Keep only the last ${var.image_retention_count} images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": ${var.image_retention_count}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF

  depends_on = [
    aws_ecr_repository.repo
  ]
}
