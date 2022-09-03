variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository."
  type        = string
  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "Mutability must be one of \"MUTABLE\", \"IMMUTABLE\"."
  }
  default = "MUTABLE"
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
  description = "Name prefix combination for local values"
  type        = string
  default     = null
}
