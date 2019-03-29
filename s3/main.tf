#--------------- generate the random id for bucket name--------------
resource "random_id" "tf_bucket_id" {
  byte_length = 2
}

#-------------- create the bucket------------------------------------
resource "aws_s3_bucket" "tf_bucket" {
  bucket        = "${var.project_name}-${random_id.tf_bucket_id.dec}"
  acl           = "private"
  force_destroy = true

  tags {
    Name = "${var.tag_bucket_name}"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

#----------------s3 notification-----------------------------------
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "${aws_s3_bucket.tf_bucket.id}"

  lambda_function {
    lambda_function_arn = "${var.lambda_arn}"
    events              = ["s3:ObjectRemoved:*"]
  }
}
