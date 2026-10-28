variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "terraform-devops"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "database_subnet_cidrs" {
  description = "Database subnet CIDRs"
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "availability_zones" {
  description = "Availability zones to deploy in"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "single_nat_gateway" {
  description = "Deploy single NAT Gateway to reduce dev costs"
  type        = bool
  default     = true
}

variable "app_port" {
  description = "Port the application listens on"
  type        = number
  default     = 8080
}

variable "container_image" {
  description = "Default container image for dev environment"
  type        = string
  default     = "public.ecr.aws/docker/library/httpd:latest"
}

variable "ecs_desired_count" {
  description = "Desired number of ECS task containers"
  type        = number
  default     = 2
}

variable "ecs_cpu" {
  description = "Fargate CPU units"
  type        = number
  default     = 256
}

variable "ecs_memory" {
  description = "Fargate Memory (MB)"
  type        = number
  default     = 512
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t4g.micro"
}

variable "db_name" {
  description = "RDS database name"
  type        = string
  default     = "devdb"
}

variable "db_admin_username" {
  description = "RDS database master username"
  type        = string
  default     = "devadmin"
}

variable "alert_email" {
  description = "Email address for CloudWatch alarm notifications"
  type        = string
  default     = "devops-team@example.com"
}
