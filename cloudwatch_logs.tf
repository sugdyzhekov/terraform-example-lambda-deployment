resource "aws_cloudwatch_log_group" "my_test_lambda" {
  name              = "/aws/lambda/${aws_lambda_function.test_lambda.function_name}"
  retention_in_days = 7
}