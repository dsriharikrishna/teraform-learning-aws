variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "terraform-devops"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.2.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs (across 3 AZs for high availability)"
  type        = list(string)
  default     = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs (across 3 AZs for high availability)"
  type        = list(string)
  default     = ["10.2.11.0/24", "10.2.12.0/24", "10.2.13.0/24"]
}

variable "database_subnet_cidrs" {
  description = "Database subnet CIDRs (across 3 AZs for high availability)"
  type        = list(string)
  default     = ["10.2.21.0/24", "10.2.22.0/24", "10.2.23.0/24"]
}

variable "availability_zones" {
  description = "Availability zones to deploy in"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "single_nat_gateway" {
  description = "Deploy multi-AZ NAT Gateways for production high availability"
  type        = bool
  default     = false
}

variable "app_port" {
  description = "Port the application listens on"
  type        = number
  default     = 8080
}

variable "container_image" {
  description = "Production container image"
  type        = string
  default     = "public.ecr.aws/docker/library/httpd:latest"
}

variable "ecs_desired_count" {
  description = "Desired number of ECS task containers"
  type        = number
  default     = 3
}

variable "ecs_cpu" {
  description = "Fargate CPU units"
  type        = number
  default     = 1024
}

variable "ecs_memory" {
  description = "Fargate Memory (MB)"
  type        = number
  default     = 2048
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t4g.medium"
}

variable "db_name" {
  description = "RDS database name"
  type        = string
  default     = "proddb"
}

variable "db_admin_username" {
  description = "RDS database master username"
  type        = string
  default     = "prodadmin"
}

variable "alert_email" {
  description = "Email address for CloudWatch alarm notifications"
  type        = string
  default     = "prod-alerts@example.com"
}
