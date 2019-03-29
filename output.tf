# output of the main tf

#---- output of dynamodb----
output "Table name" {
	value = "${module.dynamodb.table_name}"
}

#----output of lambda-----
output "Resource name" {
	value = "${module.lambda.resource_name}"
}

#----output of s3-------
output "Bucket name" {
	value = "${module.s3.bucket_name}"
}
