variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "cluster_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "api_gateway_stage" {
  type = string
}

variable "task_definition_image" {
  type = string
}

variable "task_definition_network_mode" {
  type = string
}

variable "task_definition_container_name" {
  type = string
}

variable "task_definition_container_port" {
  type = string
}

variable "task_definition_family" {
  type = string
}

variable "log_group_name" {
  type = string
}

variable "launch_type" {
  type = string
}

variable "desired_count" {
  type = string
}

