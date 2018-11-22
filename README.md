## About

Terraform example code to deploy Python AWS Lambda function. Function returns request data. 

## Deployment
* Create S3 bucket for [terraform state](https://www.terraform.io/docs/state/index.html)
* Set bucket name in `settings.tf` 

### Initial
```
aws-vault exec -n example-account -- terraform init
aws-vault exec -n example-account -- terraform apply
```

### Redeploy
```
aws-vault exec example-account -- terraform apply
```
