# output of s3

output "bucket_name" {
  value = "${aws_s3_bucket.tf_bucket.id}"
}

output "source_arn" {
	value = "${aws_s3_bucket.tf_bucket.arn}"
}
