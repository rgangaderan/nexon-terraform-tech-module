variable "task_definition" {
  description = "The object describing the task definition configuration"
  type = object(
    {
      task_definition = string
      general_configuration = object({
        cpu    = string
        memory = string
      })
      ports = object({
        container_port = number
        host_port      = number

      })


    }
  )
}

variable "volume" {
  type        = bool
  description = "Weather to create docker volume"
}

variable "host_path" {
  type        = string
  description = "Path on the host container instance that is presented to the container"
}

variable "iam_role" {
  type        = string
  description = "ARN of the IAM role that allows Amazon ECS to make calls to load balancer on your behalf"
}


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
