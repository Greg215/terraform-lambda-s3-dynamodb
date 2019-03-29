# main tf code

provider "aws" {
  region = "${var.aws_region}"
}

#----- s3 module -------------
module "s3" {
  source          = "./s3"
  project_name    = "${var.project_name}"
  tag_bucket_name = "${var.tag_bucket_name}"
  lambda_arn      = "${module.lambda.resource_name}"
}

#----- dynamodb module -------
module "dynamodb" {
  source        = "./dynamodb"
  table_name    = "${var.table_name}"
  rcp           = "${var.rcp}"
  wcp           = "${var.wcp}"
  partition_key = "${var.partition_key}"
  sort_key      = "${var.sort_key}"
}

#------ lambda module -------
module "lambda" {
  source           = "./lambda"
  function_name    = "${var.function_name}"
  source_file_name = "${var.source_file_name}"
  output_file_name = "${var.output_file_name}"
  language         = "${var.language}"
  file_name        = "${var.file_name}"
  source_arn       = "${module.s3.source_arn}"
}
