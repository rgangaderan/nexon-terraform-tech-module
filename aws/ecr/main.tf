locals {
  name_prefix = "${var.name}-${var.stage}"
}

resource "aws_ecr_repository" "artifacts" {
  # checkov:skip=CKV_AWS_51
  # checkov:skip=CKV_AWS_136
  name = local.name_prefix

  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "artifacts_lifecycle" {
  repository = aws_ecr_repository.artifacts.name
  policy     = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 10 images",
            "selection": {
                "tagStatus": "untagged",
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
