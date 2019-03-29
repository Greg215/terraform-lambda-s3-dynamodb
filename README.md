# terraform-lambda-s3-dynamodb

The Objective

The objective of this is to write a Terraform script to provision a S3 bucket, a DynamoDB table, and a Lambda function.

The Lambda function would react to an object being deleted from the bucket and record the object's name and time of deletion in the DynamoDB table. 

Both the bucket policy and the Lambda function’s IAM role policy follow the principle of least privilege.

Terraform:
Use Terraform version 0.11.8. It may be deployed in multiple regions by only changing Terraform variable values.

S3 bucket:
The bucket invokes the Lambda function directly. - Enforce the use of SSE-S3.

DynamoDB table:
Use "object_name" as the partition key, and "deleted_at" as the sort key. - These are the two attributes in the table, along with the bucket name and deleted user. - Provision the table with 1 RCU and 1 WCU.

Lambda function:
Write the function in Python 3.7. - Write logs to CloudWatch. - Please provide full test coverage and use Moto for mocking.
