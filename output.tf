# output of the main tf

#---- output of dynamodb------------------
output "Dynamodb Table name" {
  value = "${module.dynamodb.table_name}"
}

#----output of lambda---------------------
output "Lambda Resource name" {
  value = "${module.lambda.resource_name}"
}

#----output of s3-------------------------
output "S3 Bucket name" {
  value = "${module.s3.bucket_name}"
}
