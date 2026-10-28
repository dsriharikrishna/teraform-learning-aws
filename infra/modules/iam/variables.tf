variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "secrets_arns" {
  description = "List of Secrets Manager ARNs the ECS task is permitted to read"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to attach to resources"
  type        = map(string)
  default     = {}
}
