resource "aws_security_group" "alb" {
  name   = format("%s-sg-alb", local.name)
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = format("%s-sg-alb", local.name)
  }
}

resource "aws_security_group_rule" "alb_ingress_internet_443" {
  security_group_id = aws_security_group.alb.id

  type      = "ingress"
  protocol  = "tcp"
  from_port = 443
  to_port   = 443

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_ingress_internet_80" {
  security_group_id = aws_security_group.alb.id

  type      = "ingress"
  protocol  = "tcp"
  from_port = 80
  to_port   = 80

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_to_ecs_egress_8000" {
  security_group_id        = aws_security_group.alb.id
  source_security_group_id = aws_security_group.ecs.id

  type      = "egress"
  protocol  = "tcp"
  from_port = 8000
  to_port   = 8000
}

resource "aws_security_group" "ecs" {
  name   = format("%s-sg-ecs", local.name)
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = format("%s-sg-ecs", local.name)
  }
}

resource "aws_security_group_rule" "alb_to_ecs_ingress_8000" {
  security_group_id        = aws_security_group.ecs.id
  source_security_group_id = aws_security_group.alb.id

  type      = "ingress"
  protocol  = "tcp"
  from_port = 8000
  to_port   = 8000
}

resource "aws_security_group_rule" "ecs_egress_internet_all" {
  security_group_id = aws_security_group.ecs.id

  type      = "egress"
  protocol  = "tcp"
  from_port = 0
  to_port   = 65535

  cidr_blocks = ["0.0.0.0/0"]
}