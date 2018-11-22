data "archive_file" "payload" {
  type        = "zip"
  source_dir  = "src"
  output_path = "build/payload.zip"
}

resource "aws_lambda_function" "test_lambda" {
  filename         = "build/payload.zip"
  function_name    = "my_test_lambda_function"
  role             = "${aws_iam_role.my_test_lambda.arn}"
  handler          = "test.my_handler"
//  source_code_hash = "${base64sha256(file("build/payload.zip"))}"
  source_code_hash = "${data.archive_file.payload.output_base64sha256}"
  runtime          = "python3.6"

  environment {
    variables = {
      foo = "bar"
    }
  }
}