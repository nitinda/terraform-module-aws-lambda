
variable "filename" {
    description = "The path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options cannot be used"
    default     = null
}

variable "s3_bucket" {
    description = "The S3 bucket location containing the function's deployment package"
    default     = null
}

variable "s3_key" {
    description = "The S3 key of an object containing the function's deployment package. Conflicts with filename."
    default     = null
}

variable "s3_object_version" {
    description = "The object version containing the function's deployment package. Conflicts with filename."
    default     = null
}

variable "function_name" {
    description = "A unique name for your Lambda Function."  
}

variable "dead_letter_config" {
    description = "Nested block to configure the function's dead letter queue"
    type        = map(string)
    default     = {}
}

variable "handler" {
    description = "The function entrypoint in your code"  
}

variable "role" {
    description = "IAM role attached to the Lambda Function."  
}

variable "description" {
  description = "Description of what your Lambda Function does"
}

variable "layers" {
    description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function"
    default     = null
}

variable "memory_size" {
    description = "Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128"
    default     = 128
    type        = number
}

variable "runtime" {
    description = "The identifier of the function's runtime."  
}

variable "timeout" {
    description = "The amount of time your Lambda Function has to run in seconds. Defaults to 3"
    default     = 3
    type        = number
}

variable "reserved_concurrent_executions" {
    description = "The amount of reserved concurrent executions for this lambda function"
    default     = -1
    type        = number
}

variable "publish" {
    description = "Whether to publish creation/change as new Lambda Function Version. Defaults to false."
    default     = false
    type        = bool
}

variable "vpc_config" {
    description = "Provide this to allow your function to access your VPC"
    default     = {}
    type        = any
}

variable "environment" {
    description = "The Lambda environment's configuration settings"
    default     = {}
    type        = any
}

variable "kms_key_arn" {
    description = "Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables"
    default     = null
}

variable "source_code_hash" {
    description = "Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key"
    default     = null
}

variable "tags" {
    description = "A map of tags to assign to the object."
    default     = {}
    type        = map(string)
}

variable "file_system_config" {
    description = "The connection settings for an EFS file system"
    default     = {}
    type        = map(string)
}