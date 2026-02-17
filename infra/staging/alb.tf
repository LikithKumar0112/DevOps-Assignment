resource "aws_lb" "pgagi_alb" {
  name               = "pgagi-alb-staging"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets = [
    aws_subnet.public_subnet.id,
    aws_subnet.public_subnet_2.id
  ]

  tags = {
    Name = "pgagi-alb-staging"
  }
}

resource "aws_lb_target_group" "frontend_tg" {
  name        = "pgagi-frontend-tg-staging"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.pgagi_vpc.id
  target_type = "ip"

  health_check {
    path                = "/"
    port                = "traffic-port"
    matcher             = "200-499"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 5
  }
}

resource "aws_lb_target_group" "backend_tg" {
  name        = "pgagi-backend-tg-staging"
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.pgagi_vpc.id
  target_type = "ip"

  health_check {
    path                = "/api/health"
    port                = "traffic-port"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 5
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.pgagi_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}

resource "aws_lb_listener_rule" "backend_rule" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}

