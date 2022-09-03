output "instance_ids" {
  value       = aws_instance.ec2_private.*.id
  description = "EC2 Instance IDs"
}
