resource "aws_ecs_task_definition" "backend_task" {
  family                   = "pgagi-backend-task-dev"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "backend"
      image     = "369883815917.dkr.ecr.ap-south-1.amazonaws.com/pgagi-backend:latest"
      essential = true

      portMappings = [
        {
          containerPort = 5000
          hostPort      = 0
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_task_definition" "frontend_task" {
  family                   = "pgagi-frontend-task-dev"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "frontend"
      image     = "369883815917.dkr.ecr.ap-south-1.amazonaws.com/pgagi-frontend:latest"
      essential = true

      portMappings = [
        {
          containerPort = 3000
          hostPort      = 0
          protocol      = "tcp"
        }
      ]
    }
  ])
}

