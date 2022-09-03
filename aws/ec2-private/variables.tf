variable "stage" {
  description = "The application deployment stage."
  type        = string
  validation {
    condition     = contains(["development", "qa", "production", "staging"], var.stage)
    error_message = "Invalid stage name - Stage must be one of \"development\", \"qa\", \"production\", \"staging\"."
  }
}

variable "name" {
  description = "Prefix used to create resource names."
  type        = string
}

variable "image_id" {
  type        = string
  description = "The AMI from which to launch the instance."
}

variable "instance_type" {
  type        = map(any)
  description = "The instance type to use for the instance"
}

variable "subnet_id" {
  type        = string
  default     = ""
  description = "The VPC Subnet ID to associate."
}

variable "tag_info" {
  type        = map(any)
  default     = {}
  description = " A map of tags to assign to the resource."
}

variable "user_data" {
  type        = string
  default     = null
  description = "The base64-encoded user data to provide when launching the instance."
}

variable "key_name" {
  type        = string
  description = "EC2 key-pare name."
}

variable "instance_count" {
  type        = number
  description = "Number of EC2 Instances to be launched."
}

variable "security_groups" {
  type        = list(any)
  default     = []
  description = "A list of security group names to associate with EC2"
}

variable "iam_instance_profile" {
  type        = string
  default     = ""
  description = "The IAM Instance Profile to launch the instance with."
}
