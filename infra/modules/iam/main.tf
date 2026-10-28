# Assume Role Policy for ECS Tasks
data "aws_iam_policy_document" "ecs_tasks_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# 1. ECS Task Execution Role (used by AWS to pull images, send logs, fetch secrets)
resource "aws_iam_role" "ecs_execution_role" {
  name               = "${var.project_name}-${var.environment}-ecs-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume_role.json

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-ecs-execution-role"
  })
}

# Attach standard AWS managed execution policy
resource "aws_iam_role_policy_attachment" "ecs_execution_role_standard" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Secret access policy for Task Execution Role (to fetch secrets during task launch)
data "aws_iam_policy_document" "ecs_execution_secrets_policy_doc" {
  count = length(var.secrets_arns) > 0 ? 1 : 0

  statement {
    effect    = "Allow"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = var.secrets_arns
  }
}

resource "aws_iam_policy" "ecs_execution_secrets" {
  count  = length(var.secrets_arns) > 0 ? 1 : 0
  name   = "${var.project_name}-${var.environment}-ecs-execution-secrets-policy"
  policy = data.aws_iam_policy_document.ecs_execution_secrets_policy_doc[0].json
}

resource "aws_iam_role_policy_attachment" "ecs_execution_secrets_attachment" {
  count      = length(var.secrets_arns) > 0 ? 1 : 0
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = aws_iam_policy.ecs_execution_secrets[0].arn
}

# 2. ECS Task Role (used by the running application container code)
resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.project_name}-${var.environment}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume_role.json

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-ecs-task-role"
  })
}
