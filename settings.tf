terraform {
  backend "s3" {
    bucket = "example-bucket"
    key    = "lambda.state"
    region = "eu-west-1"
  }
}

provider "aws" {
  region = "eu-west-1"
}

provider "archive" {}