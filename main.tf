provider "aws" {
  region                      = "ap-southeast-2"
  access_key                  = "fake"
  secret_key                  = "fake"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    lambda   = "http://localhost:4566"
  }
}

locals {
  # Dummy IAM role ARN acceptable to Terraform provider and LocalStack
  lambda_fake_role_arn = "arn:aws:iam::000000000000:role/lambda-ex"
}

// LAMBDA FUNCTIONS
resource "aws_lambda_function" "test" {
  function_name = "test"
  filename      = "test.zip"
  handler       = "index.handler"
  role          = local.lambda_fake_role_arn
  runtime       = "nodejs20.x"
  timeout       = 5
  memory_size   = 128
}

// LAMBDA FUNCTION URLS (public)
resource "aws_lambda_function_url" "test" {
  function_name      = aws_lambda_function.test.function_name
  authorization_type = "NONE"
}

resource "aws_lambda_permission" "test_url_public" {
  statement_id           = "FunctionURLAllowPublicAccessTest"
  action                 = "lambda:InvokeFunctionUrl"
  function_name          = aws_lambda_function.test.function_name
  principal              = "*"
  function_url_auth_type = "NONE"
}

resource "aws_lambda_function_url" "test_url" {
  function_name      = aws_lambda_function.test.function_name
  authorization_type = "NONE"
}