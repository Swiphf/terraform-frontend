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

module "iam_assumable_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_arns = [
    "arn:aws:iam::905418055021:user/admin"
  ]

  create_role = true

  role_name         = "ecs-task-execution-role"
  role_requires_mfa = false

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]
  number_of_custom_role_policy_arns = 2
}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"
}

# # iam_role module
# module "iam_role" {
#   source = "./modules/iam_role"
# }

# ecs module
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
  launch_type                    = var.launch_type
  desired_count                  = var.desired_count
  execution_role_arn             = data.aws_iam_role.ecs_task_execution_role.arn
  api_gateway_stage              = var.api_gateway_stage
  public_subnet_1_id             = data.aws_subnet.public_subnet.id
  aws_lb_target_group_arn        = data.aws_lb_target_group.target_group.id
  aws_security_group_id          = data.aws_security_group.security_group.id
  log_group_name                 = var.log_group_name

  # depends_on = [module.iam_role]
}
