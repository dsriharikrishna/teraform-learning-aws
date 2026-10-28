terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }

  # Remote backend config
  # backend "s3" {
  #   bucket         = "terraform-devops-tf-state-us-east-1"
  #   key            = "prod/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-devops-tf-locks"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  }
}

locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

module "vpc" {
  source = "../../modules/vpc"

  environment           = var.environment
  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  availability_zones    = var.availability_zones
  single_nat_gateway    = var.single_nat_gateway
  tags                  = locals.common_tags
}

module "ecr" {
  source = "../../modules/ecr"

  environment          = var.environment
  project_name         = var.project_name
  image_tag_mutability = "IMMUTABLE"
  tags                 = locals.common_tags
}

module "security_groups" {
  source = "../../modules/security-groups"

  environment  = var.environment
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  app_port     = var.app_port
  tags         = locals.common_tags
}

module "alb" {
  source = "../../modules/alb"

  environment           = var.environment
  project_name          = var.project_name
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.security_groups.alb_security_group_id
  app_port              = var.app_port
  tags                  = locals.common_tags
}

module "rds" {
  source = "../../modules/rds"

  environment           = var.environment
  project_name          = var.project_name
  instance_class        = var.db_instance_class
  database_name         = var.db_name
  admin_username        = var.db_admin_username
  db_subnet_group_name  = module.vpc.db_subnet_group_name
  rds_security_group_id = module.security_groups.rds_security_group_id
  multi_az              = true
  skip_final_snapshot   = false
  tags                  = locals.common_tags
}

module "secrets_manager" {
  source = "../../modules/secrets-manager"

  environment  = var.environment
  project_name = var.project_name
  initial_secrets = {
    APP_ENV = var.environment
  }
  tags = locals.common_tags
}

module "iam" {
  source = "../../modules/iam"

  environment  = var.environment
  project_name = var.project_name
  secrets_arns = [
    module.secrets_manager.secret_arn,
    module.rds.db_credentials_secret_arn
  ]
  tags = locals.common_tags
}

module "ecs" {
  source = "../../modules/ecs"

  environment           = var.environment
  project_name          = var.project_name
  desired_count         = var.ecs_desired_count
  cpu                   = var.ecs_cpu
  memory                = var.ecs_memory
  container_image       = var.container_image
  container_port        = var.app_port
  private_subnet_ids    = module.vpc.private_subnet_ids
  ecs_security_group_id = module.security_groups.ecs_security_group_id
  target_group_arn      = module.alb.target_group_arn
  execution_role_arn    = module.iam.ecs_task_execution_role_arn
  task_role_arn         = module.iam.ecs_task_role_arn
  environment_variables = [
    { name = "ENVIRONMENT", value = var.environment },
    { name = "PORT", value = tostring(var.app_port) }
  ]
  tags = locals.common_tags
}

module "monitoring" {
  source = "../../modules/monitoring"

  environment             = var.environment
  project_name            = var.project_name
  ecs_cluster_name        = module.ecs.cluster_name
  ecs_service_name        = module.ecs.service_name
  alb_arn_suffix          = module.alb.alb_arn
  target_group_arn_suffix = module.alb.target_group_arn
  alert_email             = var.alert_email
  tags                    = locals.common_tags
}
