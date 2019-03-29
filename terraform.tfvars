aws_region = "eu-west-1"

table_name = "greg-test-lambda-s3-dynamodb"

rcp = 1

wcp = 1

partition_key = "object_name" 

sort_key = "deleted_at"


function_name = "greg-test-lambda-s3-dynamodb"

source_file_name = "lambda_s3.py"

file_name = "lambda_s3"

output_file_name = "lambda_s3.zip"

language = "python3.6"


project_name = "greg-test-lambda-s3-dynamodb-shanghai"

tag_bucket_name = "greg-test-lambda-s3-dynamodb"
