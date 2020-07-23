resource "aws_lambda_function" "lambda_function" {
  filename          = var.filename
  s3_bucket         = var.s3_bucket
  s3_key            = var.s3_key
  s3_object_version = var.s3_object_version
  function_name     = var.function_name

  dynamic "dead_letter_config" {
    for_each = var.dead_letter_config
    content {
      target_arn = dead_letter_config.value.target_arn
    }
  }

  handler                        = var.handler
  role                           = var.role
  description                    = var.description
  layers                         = var.layers
  memory_size                    = var.memory_size
  runtime                        = var.runtime
  timeout                        = var.timeout
  reserved_concurrent_executions = var.reserved_concurrent_executions

  dynamic "vpc_config" {
    for_each = var.vpc_config
    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnet_ids         = vpc_config.value.subnet_ids
    }
  }

  dynamic "environment" {
    for_each = var.environment
    content {
      variables = lookup(environment.value, "variables", null)
    }
  }

  kms_key_arn      = var.kms_key_arn
  publish          = var.publish
  source_code_hash = var.source_code_hash
  tags             = var.tags
  
  dynamic "file_system_config" {
    for_each = var.file_system_config
    content {
      arn              = file_system_config.value.arn
      local_mount_path = file_system_config.value.local_mount_path
    }
  }
}