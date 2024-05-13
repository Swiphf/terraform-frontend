cluster_name                   = "frontend-ecs"
service_name                   = "frontend"
task_definition_network_mode   = "awsvpc"
task_definition_image          = "idoswiphf/frontend:0.0.12"
task_definition_family         = "frontend-task"
task_definition_container_name = "frontend"
task_definition_container_port = 5000
api_gateway_stage              = "dev"
