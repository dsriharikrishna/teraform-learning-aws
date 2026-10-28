resource "aws_secretsmanager_secret" "app" {
  name                    = "${var.project_name}/${var.environment}/app-secrets"
  recovery_window_in_days = var.environment == "prod" ? 30 : 0
  kms_key_id              = var.kms_key_arn

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-secrets"
  })
}

resource "aws_secretsmanager_secret_version" "app" {
  secret_id     = aws_secretsmanager_secret.app.id
  secret_string = jsonencode(var.initial_secrets)

  lifecycle {
    ignore_changes = [secret_string]
  }
}
