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


# ECS module
module "ecs" {
  source = "./modules/ecs"

  aws_region                     = var.aws_region
  cluster_name                   = var.cluster_name
  service_name                   = var.service_name
  task_definition_network_mode   = var.task_definition_network_mode
  task_definition_image          = var.task_definition_image
  task_definition_family         = var.task_definition_family
  task_definition_container_name = var.task_definition_container_name
  task_definition_container_port = var.task_definition_container_port

  public_subnet_1_id      = data.aws_subnet.public_subnet.id
  aws_lb_target_group_arn = data.aws_lb_target_group.target_group.id
  aws_security_group_id   = data.aws_security_group.security_group.id
}
