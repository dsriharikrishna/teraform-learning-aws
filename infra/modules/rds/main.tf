# Generate secure master password
resource "random_password" "master_password" {
  length           = 20
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Store database credentials in AWS Secrets Manager
resource "aws_secretsmanager_secret" "db_credentials" {
  name                    = "${var.project_name}/${var.environment}/rds-credentials"
  recovery_window_in_days = var.environment == "prod" ? 30 : 0

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-rds-credentials"
  })
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    engine   = var.engine
    host     = aws_db_instance.main.address
    port     = aws_db_instance.main.port
    username = var.admin_username
    password = random_password.master_password.result
    database = var.database_name
  })
}

# RDS Database Instance
resource "aws_db_instance" "main" {
  identifier             = "${var.project_name}-${var.environment}-db"
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  max_allocated_storage  = var.max_allocated_storage
  storage_type           = "gp3"
  db_name                = var.database_name
  username               = var.admin_username
  password               = random_password.master_password.result
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = [var.rds_security_group_id]
  multi_az               = var.multi_az
  publicly_accessible    = false
  skip_final_snapshot    = var.skip_final_snapshot
  final_snapshot_identifier = "${var.project_name}-${var.environment}-db-final-snapshot"
  storage_encrypted      = true
  auto_minor_version_upgrade = true
  deletion_protection    = var.environment == "prod" ? true : false

  backup_retention_period = var.environment == "prod" ? 30 : 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "Sun:04:30-Sun:05:30"

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-db"
  })
}
