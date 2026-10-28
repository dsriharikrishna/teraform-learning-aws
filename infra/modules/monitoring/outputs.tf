output "sns_topic_arn" {
  description = "ARN of the SNS alert notification topic"
  value       = aws_sns_topic.alerts.arn
}

output "ecs_high_cpu_alarm_arn" {
  description = "ARN of the ECS high CPU alarm"
  value       = aws_cloudwatch_metric_alarm.ecs_high_cpu.arn
}

output "ecs_high_memory_alarm_arn" {
  description = "ARN of the ECS high memory alarm"
  value       = aws_cloudwatch_metric_alarm.ecs_high_memory.arn
}

output "alb_5xx_alarm_arn" {
  description = "ARN of the ALB 5xx alarm"
  value       = aws_cloudwatch_metric_alarm.alb_5xx_errors.arn
}
