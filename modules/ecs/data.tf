data "aws_security_group" "security_group" {
  name = "frontend_security_group"
}

data "aws_lb_target_group" "target_group" {
  name = "frontend-target-group"
}

data "aws_subnet" "public_subnet" {
  filter {
    name   = "tag:Name"
    values = ["Public Subnet-1"]
  }
}
