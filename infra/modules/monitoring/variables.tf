variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "ecs_cluster_name" {
  description = "ECS cluster name for CloudWatch alarms"
  type        = string
}

variable "ecs_service_name" {
  description = "ECS service name for CloudWatch alarms"
  type        = string
}

variable "alb_arn_suffix" {
  description = "ALB ARN suffix for CloudWatch metrics"
  type        = string
}

variable "target_group_arn_suffix" {
  description = "Target group ARN suffix for CloudWatch metrics"
  type        = string
}

variable "alert_email" {
  description = "Email address for SNS alert notifications"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to attach to resources"
  type        = map(string)
  default     = {}
}
