output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "alb_dns_name" {
  description = "Public URL of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "ecr_repository_url" {
  description = "ECR Repository URL for Docker image push"
  value       = module.ecr.repository_url
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = module.ecs.cluster_name
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = module.ecs.service_name
}

output "rds_endpoint" {
  description = "RDS connection endpoint"
  value       = module.rds.db_instance_endpoint
}

output "secrets_manager_arn" {
  description = "Secrets Manager ARN"
  value       = module.secrets_manager.secret_arn
}

output "sns_alerts_topic_arn" {
  description = "SNS topic ARN for monitoring alarms"
  value       = module.monitoring.sns_topic_arn
}
