resource "aws_ecs_cluster" "cluster" {
  name = var.name
  tags = {
    Name = var.name
  }
}

resource "aws_ecs_task_definition" "task" {
  family                   = var.name
  memory                   = var.memory
  cpu                      = var.cpu
  execution_role_arn       = format("arn:aws:iam::%s:role/ecs-task-%s", data.aws_caller_identity.current.account_id, var.name)
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = data.template_file.container_definition.rendered
  task_role_arn            = aws_iam_role.ecs-task.arn
  tags = {
    Name = var.name
  }
}

resource "aws_ecs_service" "service" {
  name            = var.name
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [var.security_group_id]
    subnets          = var.subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.name
    container_port   = 8000
  }
}

data "template_file" "container_definition" {
  template = file("${path.module}/templates/task.json.tpl")

  vars = {
    cluster_name = var.name
    cpu          = var.cpu
    memory       = var.memory
    image        = format("%s:latest", var.docker_image_url)
    aws_region   = data.aws_region.current.name
  }
}