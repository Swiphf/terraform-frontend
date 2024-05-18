# Create ECS cluster
resource "aws_ecs_cluster" "ecs-cluster" {
  name = var.cluster_name
}

# Create a log group
resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = var.log_group_name
  retention_in_days = 3
}

# Define ECS task definitions for frontend
resource "aws_ecs_task_definition" "task" {
  family                   = var.task_definition_family
  network_mode             = var.task_definition_network_mode
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn

  depends_on = [
    aws_ecs_cluster.ecs-cluster
  ]

  container_definitions = jsonencode([
    {
      name   = var.task_definition_container_name
      image  = var.task_definition_image
      cpu    = 128
      memory = 256
      environment = [
        {
          "name" : "BACKEND_URL",
          "value" : "https://${data.aws_api_gateway_rest_api.api_gateway_rest_api.id}.execute-api.${var.aws_region}.amazonaws.com/${var.api_gateway_stage}"
        }
      ]
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.log_group_name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = var.task_definition_container_name
        }
      }
    }
  ])
}

resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.ecs-cluster.arn
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type

  depends_on = [
    aws_ecs_cluster.ecs-cluster
  ]

  load_balancer {
    target_group_arn = var.aws_lb_target_group_arn
    container_name   = var.task_definition_container_name
    container_port   = var.task_definition_container_port
  }

  network_configuration {
    assign_public_ip = true
    security_groups  = [var.aws_security_group_id]
    subnets          = [var.public_subnet_1_id]
  }
}
