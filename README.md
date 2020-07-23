# _Terraform Module : terraform-module-aws-lambda-function_
_Terraform Module for_ **_AWS Lambda Function_**

<!--BEGIN STABILITY BANNER-->
---

![_Code : Stable_](https://img.shields.io/badge/Code-Stable-brightgreen?style=for-the-badge&logo=github)

> **_This is a stable example. It should successfully build out of the box_**
>
> _This examples does is built on Construct Libraries marked "Stable" and does not have any infrastructure prerequisites to build._

---
<!--END STABILITY BANNER-->

## _General_

_This module may be used to create_ **_Lambda Function_** _resources in AWS cloud provider......_

---


## _Prerequisites_

_This module needs_ **_Terraform 0.12.29_** _or newer._
_You can download the latest Terraform version from_ [here](https://www.terraform.io/downloads.html).

_This module deploys aws services details are in respective feature branches._

---

## _Features_

_Below we are able to check the resources that are being created as part of this module call:_

* **_Lambda Function_**



---

## _Usage_

## _Using this repo_

_To use this module, add the following call to your code:_

## _Example Usage_

### _Basic Usage_

```tf
module "lambda_function" {
  source = "git::https://github.com/nitinda/terraform-module-aws-lambda-function.git?ref=master"

  providers = {
    aws = aws.services
  }

  filename         = "lambda_function_payload.zip"
  function_name    = "lambda_function_name"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "exports.test"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")
  runtime = "nodejs12.x"

  environment {
    variables = {
      foo = "bar"
    }
  }

  tags = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "lambda-function"
    }
  )
}
```

### _Lambda File Systems_

```tf
module "lambda_function" {
  source = "git::https://github.com/nitinda/terraform-module-aws-lambda-function.git?ref=master"

  providers = {
    aws = aws.services
  }

  file_system_config = {
    # EFS file system access point ARN
    arn = "${aws_efs_access_point.access_point_for_lambda.arn}"
    # Local mount path inside the lambda function. Must start with '/mnt/'.
    local_mount_path = "/mnt/efs"
  }

  vpc_config = {
    # Every subnet should be able to reach an EFS mount target in the same Availability Zone. Cross-AZ mounts are not permitted.
    subnet_ids         = ["${aws_subnet.subnet_for_lambda.id}"]
    security_group_ids = ["${aws_security_group.sg_for_lambda.id}"]
  }

  tags = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "lambda-function"
    }
  )
}
```

---

## _Argument Reference_

---

_The following arguments are supported:_

---

* _**filename** - (Optional) The path to the function's deployment package within the local filesystem. If defined, The s3\_-prefixed options cannot be used._
* _**s3\_bucket** - (Optional) The S3 bucket location containing the function's deployment package. Conflicts with **filename**. This bucket must reside in the same AWS region where you are creating the Lambda function._
* _**s3\_key** - (Optional) The S3 key of an object containing the function's deployment package. Conflicts with **filename**._
* _**s3\_object\_version** - (Optional) The object version containing the function's deployment package. Conflicts with **filename**._
* _**function\_name** - (Required) A unique name for your Lambda Function._
* _**dead\_letter\_config** - (Optional) Nested block to configure the function's dead letter queue. See details below._
* _**handler** - (Required) The function [entrypoint](https://docs.aws.amazon.com/lambda/latest/dg/walkthrough-custom-events-create-test-function.html) in your code._
* _**role** - (Required) IAM role attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See [Lambda Permission Model](https://docs.aws.amazon.com/lambda/latest/dg/intro-permission-model.html) for more details._
* _**description** - (Optional) Description of what your Lambda Function does._
* _**layers** - (Optional) List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function. See [Lambda Layers](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html)_
* _**memory\_size** - (Optional) Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128. See [Limits](https://docs.aws.amazon.com/lambda/latest/dg/limits.html)._
* _**runtime** - (Required) See [Runtimes](https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime) for valid values._
* _**timeout** - (Optional) The amount of time your Lambda Function has to run in seconds. Defaults to 3. See [Limits](https://docs.aws.amazon.com/lambda/latest/dg/limits.html)._
* _**reserved\_concurrent\_executions** - (Optional) The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1. See [Managing Concurrency](https://docs.aws.amazon.com/lambda/latest/dg/concurrent-executions.html)._
* _**publish** - (Optional) Whether to publish creation/change as new Lambda Function Version. Defaults to false._
* _**vpc\_config** - (Optional) Provide this to allow your function to access your VPC. Fields documented below. See [Lambda in VPC](http://docs.aws.amazon.com/lambda/latest/dg/vpc.html)._
* _**environment** - (Optional) The Lambda environment's configuration settings._
* _**kms\_key\_arn** - (Optional) Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key. If this configuration is provided when environment variables are not in use, the AWS Lambda API does not save this configuration and Terraform will show a perpetual difference of adding the key. To fix the perpetual difference, remove this configuration._
* _**source\_code\_hash** - (Optional) Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or **s3\_key**. The usual way to set this is filebase64sha256("file.zip") (Terraform 0.11.12 and later) or base64sha256(file("file.zip")) (Terraform 0.11.11 and earlier), where "file.zip" is the local filename of the lambda function source archive._
* **_tags_** _- (Optional) A map of tags to assign to the resource_
* _**file\_system\_config** - (Optional) The connection settings for an EFS file system. Fields documented below. Before creating or updating Lambda functions with **file\_system_\config**, EFS mount targets much be in available lifecycle state. Use depends\_on to explicitly declare this dependency. See [Using Amazon EFS with Lambda](https://docs.aws.amazon.com/lambda/latest/dg/services-efs.html)._



---

## _Attributes Reference_
---

_In addition to all arguments above, the following attributes are exported:_


* _**arn** - The Amazon Resource Name (ARN) identifying your Lambda Function._
* _**invoke\_arn** - The ARN to be used for invoking Lambda Function from API Gateway - to be used in aws\_api\_gateway\_integration's uri._
* _**version** - Latest published version of your Lambda Function._
* _**last\_modified** - The date this resource was last modified._
* _**source\_code\_hash** - Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters._
* _**source\_code\_size** - The size in bytes of the function .zip file._
---


### _Usage_

_In order for the variables to be accessed on module level please use the syntax below:_

```tf
module.<module_name>.<output_variable_name>
```

_The output variable is able to be accessed through terraform state file using the syntax below:_

```tf
data.terraform_remote_state.<module_name>.<output_variable_name>
```

---

## _Authors_

_Module maintained by Module maintained by the -_ **_Nitin Das_**