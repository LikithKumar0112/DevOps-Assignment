resource "aws_cloudwatch_log_group" "backend" {
  name              = "/ecs/backend-prod"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "frontend" {
  name              = "/ecs/frontend-prod"
  retention_in_days = 7
}

