variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "cluster_name" {
  description = "ECS cluster name (optional)"
  type        = string
  default     = ""
}

variable "service_name" {
  description = "ECS service name (optional)"
  type        = string
  default     = ""
}

variable "desired_count" {
  description = "Desired number of ECS task instances"
  type        = number
  default     = 2
}

variable "cpu" {
  description = "Fargate CPU units (256, 512, 1024, 2048, 4096)"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Fargate Memory (512, 1024, 2048, etc.)"
  type        = number
  default     = 512
}

variable "container_image" {
  description = "Docker image URI"
  type        = string
}

variable "container_port" {
  description = "Port exposed by container"
  type        = number
  default     = 8080
}

variable "private_subnet_ids" {
  description = "Private subnets for ECS task placement"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "Security group ID for ECS tasks"
  type        = string
}

variable "target_group_arn" {
  description = "Target group ARN for ALB traffic distribution"
  type        = string
}

variable "execution_role_arn" {
  description = "ECS task execution role ARN"
  type        = string
}

variable "task_role_arn" {
  description = "ECS task role ARN"
  type        = string
}

variable "environment_variables" {
  description = "List of environment key/value maps"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "secrets" {
  description = "List of secrets key/valueFrom maps"
  type = list(object({
    name      = string
    valueFrom = string
  }))
  default = []
}

variable "tags" {
  description = "Tags to attach to resources"
  type        = map(string)
  default     = {}
}
