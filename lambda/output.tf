#-------- output of lambda------

output "resource_name" {
  value = "${aws_lambda_function.func.arn}"
}
