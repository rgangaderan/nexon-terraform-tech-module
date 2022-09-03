output "url" {
  description = "URL of the ECR"
  value       = aws_ecr_repository.artifacts.repository_url
}

output "repo_name" {
  description = "Name of the ECR Repo"
  value       = aws_ecr_repository.artifacts.name
}
