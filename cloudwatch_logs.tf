resource "aws_cloudwatch_log_group" "my_test_lambda" {
  name              = "/aws/lambda/my_test_lambda_function"
  retention_in_days = 7
}