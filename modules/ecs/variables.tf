variable "aws_region" {
  type = string
  default = "eu-west-1"
}

variable "cluster_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "task_definition_image" {
  type = string
}

variable "task_definition_network_mode" {
  type = string
}

variable "task_definition_family" {
  type = string
}

variable "task_definition_container_name" {
  type = string
}

variable "task_definition_container_port" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "api_gateway_stage" {
  type = string
}

variable "aws_lb_target_group_arn" {
  type = string
}

variable "aws_security_group_id" {
  type = string
}

variable "public_subnet_1_id" {
  type = string
}