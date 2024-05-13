# Get the required BACKEND_URL from the existing api gateway
data "aws_api_gateway_rest_api" "api_gateway_rest_api" {
  name = "BackendAPI"
}