output "application_lb" {
  description = "An object describing the central load balancer of the environment"
  value       = aws_alb.this_alb
}

output "listeners" {
  description = "An object describing the listeners attached to the load balancer"
  value = {
    http = aws_alb_listener.http_listener_service
  }
}

output "security_group_id" {
  description = "A list of security group IDs to assign to the application load balancer."
  value       = aws_security_group.alb_sg.id
}

output "target_group_arns" {
  value       = aws_lb_target_group.instance_target_group.arn
  description = "ARN of the Target Group"

}
