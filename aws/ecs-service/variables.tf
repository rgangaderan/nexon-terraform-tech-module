variable "ecs_configuration" {
  description = "The object describing the task definition configuration"
  type = object(
    {
      general_configuration = object({
        cpu           = number
        memory        = number
        image         = string
        desired_count = number
        launch_type   = string

      })

      ports = object({
        container_port = number
        host_port      = number

      })


    }
  )
}

# variable "environment_variable" {
#   type = object({
#     name  = string
#     value = string
#   })
#   description = "The environment variables to pass to the container. This is a list of maps"
# }


variable "stage" {
  description = "The application deployment stage."
  type        = string
  default     = "development"
  validation {
    condition     = contains(["development", "qa", "production", "staging"], var.stage)
    error_message = "Invalid stage name - Stage must be one of \"development\", \"qa\", \"production\", \"staging\"."
  }
}

variable "name" {
  description = "Prefix used to create resource names."
  type        = string
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets associated with the task or service."
}

variable "security_groups" {
  type        = list
  description = "Security groups associated with the task or service."
}

variable "assign_public_ip" {
  type        = bool
  description = "Assign a public IP address to the ENI (Fargate launch type only)."
}

variable "target_group_arn" {
  type        = string
  description = "ARN of the Load Balancer target group to associate with the service."
}

variable "ecs_task_execution_role" {
  type        = string
  description = "ECS Task Execution role to pull ECR Images"
}

variable "task_role_arn" {
  type        = string
  description = "ECS Task role"
}
