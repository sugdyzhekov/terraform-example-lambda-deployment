output "my_demo_api_test_entrypoint" {
  value = "${aws_api_gateway_deployment.my_demo_api.invoke_url}/test"
}