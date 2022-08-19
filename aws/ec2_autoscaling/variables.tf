variable "image_id" {
  type        = string
  description = "The AMI from which to launch the instance."
}

variable "instance_type" {
  type        = map(any)
  description = "The type of the instance."
}

variable "key_name" {
  type        = string
  description = "The key name to use for the instance"
}

variable "user_data" {
  type        = string
  default     = null
  description = "The base64-encoded user data to provide when launching the instance."
}

variable "volume_size" {
  type        = string
  description = "The size of the volume in gigabytes."
}

variable "volume_type" {
  type        = string
  default     = ""
  description = "The volume type. Can be standard, gp2, gp3, io1, io2, sc1 or st1 (Default: gp2)."
}

variable "subnet_id" {
  type        = string
  default     = ""
  description = "The VPC Subnet ID to associate."
}

variable "iam_instance_profile" {
  type        = string
  default     = ""
  description = "The IAM Instance Profile to launch the instance with."
}

variable "max_size" {
  type        = string
  description = "The maximum size of the Auto Scaling Group."
}

variable "min_size" {
  type        = string
  description = "The minimum size of the Auto Scaling Group."
}

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

variable "security_groups" {
  type        = list(any)
  description = "A list of security group IDs to associate"
}

variable "vpc_zone_identifier" {
  type        = list(any)
  description = "A list of subnet IDs to launch resources in."
}

variable "load_balancers" {
  type        = list(any)
  description = "A list of elastic load balancer names to add to the autoscaling group names."
}
