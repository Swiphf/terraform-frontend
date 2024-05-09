
# Create ECS cluster
resource "aws_ecs_cluster" "ecs-cluster" {
  name = var.cluster_name
}

# Define ECS task definitions for frontend
resource "aws_ecs_task_definition" "task" {
  family                   = var.task_definition_family
  network_mode             = var.task_definition_network_mode
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  depends_on = [
    aws_ecs_cluster.ecs-cluster
  ]

  container_definitions = jsonencode([
    {
      name   = var.task_definition_container_name
      image  = var.task_definition_image
      cpu    = 128
      memory = 256
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
          protocol      = "tcp"
        }
      ]
    }
  ])

  # container_definitions = <<DEFINITION
  #   [
  #     {
  #       "name": "${var.task_definition_container_name}",
  #       "image": "${var.task_definition_image}",
  #       "essential": true,
  #       "portMappings": [
  #         {
  #           "containerPort": 5000,
  #           "hostPort": 5000
  #         }
  #       ],
  #       "logConfiguration": {
  #         "logDriver": "awslogs",
  #         "options": {
  #           "awslogs-group": "${var.cloudwatch_group}",
  #           "awslogs-region": "${var.aws_region}",
  #           "awslogs-stream-prefix": "ecs"
  #         }
  #       }
  #     }
  #   ]
  #   DEFINITION
}

resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.ecs-cluster.arn
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

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
