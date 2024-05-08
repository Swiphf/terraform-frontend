terraform {
  backend "s3" {
    bucket = "ido-backend-frontend-dev"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}