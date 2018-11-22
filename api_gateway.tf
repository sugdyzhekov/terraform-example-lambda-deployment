resource "aws_api_gateway_rest_api" "my_demo_api" {
  name        = "MyDemoAPI"
  description = "This is my API for demonstration purposes"
}

resource "aws_lambda_permission" "my_test_lambda_invoke_permission" {
  statement_id  = "AllowMyDemoAPIInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.test_lambda.function_name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.my_demo_api.execution_arn}/*/*/*"
}

resource "aws_api_gateway_resource" "test_resource" {
  rest_api_id = "${aws_api_gateway_rest_api.my_demo_api.id}"
  parent_id   = "${aws_api_gateway_rest_api.my_demo_api.root_resource_id}"
  path_part   = "test"
}

resource "aws_api_gateway_method" "test_resource_method_get" {
  rest_api_id   = "${aws_api_gateway_rest_api.my_demo_api.id}"
  resource_id   = "${aws_api_gateway_resource.test_resource.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = "${aws_api_gateway_rest_api.my_demo_api.id}"
  resource_id             = "${aws_api_gateway_resource.test_resource.id}"
  http_method             = "${aws_api_gateway_method.test_resource_method_get.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.test_lambda.invoke_arn}"
}

resource "aws_api_gateway_deployment" "my_demo_api" {
  depends_on  = ["aws_api_gateway_integration.integration"]
  rest_api_id = "${aws_api_gateway_rest_api.my_demo_api.id}"
  stage_name  = "dev"
}
