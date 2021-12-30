module "vpc" {
  source = "./modules/vpc"

  name       = local.name
  aws_region = "eu-central-1"
  az_count   = 3
  cidr_block = "10.0.10.0/24"
}

module "ecr" {
  source = "./modules/ecr"

  name = local.name
}

module "alb" {
  source = "./modules/alb"

  name              = local.name
  security_group_id = aws_security_group.alb.id
  subnet_ids        = module.vpc.public_subnet_ids
  vpc_id            = module.vpc.vpc_id
}

module "ecs" {
  source = "./modules/ecs"

  name              = local.name
  docker_image_url  = module.ecr.repository_url
  security_group_id = aws_security_group.ecs.id
  subnet_ids        = module.vpc.public_subnet_ids
  target_group_arn  = module.alb.target_group_arn
}