data "aws_iam_policy_document" "my_test_lambda" {
  statement {
    actions = ["sts:AssumeRole"],
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "my_test_lambda" {
  name = "my_test_lambda"
  assume_role_policy = "${data.aws_iam_policy_document.my_test_lambda.json}"
}

resource "aws_iam_role_policy_attachment" "my_test_lambda_access_to_write_logs" {
  role = "${aws_iam_role.my_test_lambda.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
