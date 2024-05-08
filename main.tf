terraform {
  required_providers {
    aws = {
      source  = "aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

### ECS module
module "ecs" {
  source = "./modules/ecs"

  cluster_name                   = var.cluster_name
  service_name                   = var.service_name
  task_definition_network_mode   = var.task_definition_network_mode
  task_definition_image          = var.task_definition_image
  task_definition_family         = var.task_definition_family
  task_definition_container_name = var.task_definition_container_name
  task_definition_container_port = var.task_definition_container_port

  # from data:
  #   public_subnet_1_id       = module.networking.subnet_ids["public_subnet_1_id"]
  #   public_subnet_2_id       = module.networking.subnet_ids["public_subnet_2_id"]
  #   private_subnet_1_id      = module.networking.subnet_ids["private_subnet_1_id"]
  #   aws_lb_target_group_name = module.networking.aws_lb_target_group["aws_lb_target_group_name"]
  #   aws_lb_target_group_arn  = module.networking.aws_lb_target_group["aws_lb_target_group_arn"]
  #   aws_security_group_id    = module.networking.aws_security_group["aws_security_group_id"]
}
