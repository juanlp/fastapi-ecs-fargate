resource "aws_lb" "lb" {
  name = var.name

  load_balancer_type = "application"
  internal           = false
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids

  tags = {
    Name = var.name
  }
}

resource "aws_lb_listener" "lb_listener_80" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_target_group" "main" {
  name = var.name

  port        = 8000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled  = true
    path     = "/docs"
    port     = "traffic-port"
    protocol = "HTTP"
  }
}
