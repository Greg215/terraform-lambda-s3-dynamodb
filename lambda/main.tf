resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy" {
  name        = "greg-test-policy"
  description = "policy for s3 dynamodb and lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:List*",
	"s3:Get*",
	"dynamodb:PutItem",
	"lambda:InvokeFunction",
	"dynamodb:GetItem",
	"logs:CreateLogGroup",
	"logs:CreateLogStream",
	"logs:PutLogEvents",
	"logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = "${aws_iam_role.iam_for_lambda.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}

data "archive_file" "zip" {
  type        = "zip"
  source_file = "${var.source_file_name}"
  output_path = "${var.output_file_name}"
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.func.arn}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${var.source_arn}"
}

resource "aws_lambda_function" "func" {
  filename      = "${data.archive_file.zip.output_path}"
  function_name = "${var.function_name}"
  role          = "${aws_iam_role.iam_for_lambda.arn}"
  handler       = "${var.file_name}.lambda_handler"
  runtime       = "${var.language}"
}
