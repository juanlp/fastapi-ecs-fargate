resource "aws_cloudwatch_log_group" "ecs" {
  name              = format("/ecs/%s", var.name)
  retention_in_days = 7
  tags = {
    Name = var.name
  }
}

resource "aws_cloudwatch_log_stream" "ecs" {
  log_group_name = aws_cloudwatch_log_group.ecs.name
  name           = format("%s-stream", var.name)
}