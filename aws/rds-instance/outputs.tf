output "address" {
  value       = aws_db_instance.database.address
  description = "The hostname of the RDS instance"
}

output "db_arn" {
  value       = aws_db_instance.database.arn
  description = "The ARN of the RDS instance."
}

output "db_name" {
  value       = aws_db_instance.database.name
  description = "The database name."

}
