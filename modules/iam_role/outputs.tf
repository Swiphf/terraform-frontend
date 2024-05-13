output "execution_role_arn" {
  value = {
    execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  }
}