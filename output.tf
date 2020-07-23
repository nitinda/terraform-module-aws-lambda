output "arn" {
    value = aws_lambda_function.lambda_function.arn
}

output "invoke_arn" {
    value = aws_lambda_function.lambda_function.invoke_arn
}

output "version" {
    value = aws_lambda_function.lambda_function.version
}

output "last_modified" {
    value = aws_lambda_function.lambda_function.last_modified
}

output "source_code_hash" {
    value = aws_lambda_function.lambda_function.source_code_hash
}

output "source_code_size" {
    value = aws_lambda_function.lambda_function.source_code_size
}

