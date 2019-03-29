resource "aws_dynamodb_table" "dynamodb-table" {
  name           = "${var.table_name}"
  billing_mode   = "PROVISIONED"
  read_capacity  = "${var.rcp}"
  write_capacity = "${var.wcp}"
  hash_key       = "${var.partition_key}"
  range_key      = "${var.sort_key}"

  attribute {
    name = "${var.partition_key}"
    type = "S"
  }

  attribute {
    name = "${var.sort_key}"
    type = "S"
  }

  tags = {
    Name        = "greg-test-dynamodb-table"
    Environment = "testing"
  }
}
