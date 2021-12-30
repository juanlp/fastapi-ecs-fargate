data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

#resource "aws_iam_role" "ecs" {
#  name_prefix          = var.name
#  assume_role_policy   = data.aws_iam_policy_document.ecs-assume-role-policy.json
#  max_session_duration = 3600
#}
#
#resource "aws_iam_role_policy_attachment" "ecs-attachment" {
#  policy_arn = aws_iam_policy.ecs-policy.arn
#  role       = aws_iam_role.ecs.id
#}
#
#resource "aws_iam_policy" "ecs-policy" {
#  policy = data.aws_iam_policy_document.ecs-policy.json
#  name   = format("%s-policy", var.name)
#  path   = "/"
#}
#
#data "aws_iam_policy_document" "ecs-assume-role-policy" {
#  statement {
#    effect = "Allow"
#    principals {
#      identifiers = [format("arn:aws:iam::%s:root", data.aws_caller_identity.current.account_id)]
#      type        = "AWS"
#    }
#    actions = ["sts:AssumeRole"]
#  }
#}
#
#data "aws_iam_policy_document" "ecs-policy" {
#  statement {
#    effect  = "Allow"
#    actions = ["ecs:UpdateService"]
#    resources = [
#      format("arn:aws:ecs:%s:%s:cluster/%s", data.aws_region.current.name, data.aws_caller_identity.current.account_id, var.name),
#      format("arn:aws:ecs:%s:%s:service/%s/*", data.aws_region.current.name, data.aws_caller_identity.current.account_id, var.name)
#    ]
#  }
#}

resource "aws_iam_role" "ecs-task" {
  name                 = format("ecs-task-%s", var.name)
  assume_role_policy   = data.aws_iam_policy_document.ecs-task-assume-role-policy.json
  max_session_duration = 3600
}

data "aws_iam_policy_document" "ecs-task-assume-role-policy" {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "ecs-task-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.ecs-task.id
}

#resource "aws_iam_policy" "ecs-task-policy" {
#  policy      = data.aws_iam_policy_document.ecs-task-policy.json
#  name_prefix = format("%s-task-policy", var.name)
#  path        = "/"
#}
#

#
#data "aws_iam_policy_document" "ecs-task-policy" {
#  statement {
#    effect    = "Allow"
#    actions   = ["s3:ListBucket"]
#    resources = ["*"]
#  }
#}