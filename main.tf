# VPC and Network Module
provider "aws" {
  region = var.aws_region
}


module "network" {
  source = "./modules/vpc"

  default-route = var.default-route
  projectname   = var.projectname
  vpc_cidr      = var.vpc_cidr
  environment   = var.environment
}

module "eic" {
  source = "./modules/eic"

  projectname     = var.projectname
  environment     = var.environment
  subnet_id       = module.network.private_subnet_ids[0]
  security_groups = [module.security.eic_sg_id]
}

# Security Groups Module
module "security" {
  source = "./modules/sg"

  vpc_id        = module.network.vpc_id
  vpc_cidr      = var.vpc_cidr
  default-route = var.default-route
  projectname   = var.projectname
  environment   = var.environment
}

module "ec2" {
  source = "./modules/ec2"

  projectname        = var.projectname
  depends_on         = [module.rds]
  environment        = var.environment
  vpc_id             = module.network.vpc_id
  aws_region         = var.aws_region
  subnet_id          = module.network.private_subnet_ids[1]
  security_group_ids = [module.security.ec2_sg_id]
  target_group_arn   = module.alb.target_group_arn
  ec2_instance_type  = var.ec2_instance_type
}

# EFS Module
module "efs" {
  source = "./modules/efs"

  projectname     = var.projectname
  environment     = var.environment
  subnet_ids      = module.network.private_subnet_ids
  security_groups = [module.security.efs_sg_id]
}

# RDS Module
module "rds" {
  source = "./modules/rds"

  db_engine         = var.db_engine
  db_engine_version = var.db_engine_version
  db_instance_class = var.db_instance_class
  db_storage_size   = var.db_storage_size
  db_storage_type   = var.db_storage_type
  projectname       = var.projectname
  environment       = var.environment
  db_name           = var.db_name
  db_username       = var.db_username
  subnet_ids        = module.network.private_subnet_ids
  security_groups   = [module.security.rds_sg_id]
}

# Load Balancer Module
module "alb" {
  source = "./modules/alb"

  load_balancer_type = var.load_balancer_type
  projectname        = var.projectname
  environment        = var.environment
  vpc_id             = module.network.vpc_id
  subnet_ids         = module.network.public_subnet_ids
  security_groups    = [module.security.alb_sg_id]
}

module "asg" {
  source = "./modules/asg"

  depends_on        = [module.ec2]
  alb_instance_type = var.alb_instance_type
  instance_profile  = module.ec2.iam_instance_profile
  desired_capacity  = var.desired_capacity
  min_size          = var.min_size
  max_size          = var.max_size
  projectname       = var.projectname
  environment       = var.environment
  vpc_id            = module.network.vpc_id
  subnet_ids        = module.network.private_subnet_ids
  security_groups   = [module.security.ec2_sg_id]
  target_group_arn  = module.alb.target_group_arn
}