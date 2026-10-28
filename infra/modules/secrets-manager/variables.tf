variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "kms_key_arn" {
  description = "KMS key ARN for secret encryption (optional, null uses default aws/secretsmanager)"
  type        = string
  default     = null
}

variable "initial_secrets" {
  description = "Map of key-value pairs to store initially in the secret"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to attach to resources"
  type        = map(string)
  default     = {}
}
