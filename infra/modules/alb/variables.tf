variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALB target group will be created"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs where the ALB will be placed"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security group ID for ALB"
  type        = string
}

variable "app_port" {
  description = "Port on which the application targets listen"
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "HTTP health check endpoint"
  type        = string
  default     = "/healthz"
}

variable "tags" {
  description = "Tags to attach to resources"
  type        = map(string)
  default     = {}
}
