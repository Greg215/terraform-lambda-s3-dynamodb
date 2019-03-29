from __future__ import print_function

import json
import boto3

print("Loading function")

# Get the service resource
s3 = boto3.client('s3')
dynamodb = boto3.resource('dynamodb')

# lambda_handler is the main function in lambda function
def lambda_handler(event,context):
    records = event['Records']
    for record in records:
        source_bucket = record['s3']['bucket']['name']
        deleted_at = record['eventTime']
        key = record['s3']['object']['key']
        user_id = record['userIdentity']['principalId']
        print(record)
        
        #just print function
        print("Bucket: " + source_bucket)
        print("delet_file: " + key)
        print("who delete it" + user_id)
        
        insert_data(source_bucket, key, deleted_at, user_id)
        
        
# insert_data function for inserting data into dynamodb table
def insert_data(source_bucket, key, deleted_at, user_id):
    table = dynamodb.Table('greg-test-lambda-s3-dynamodb')
    table.put_item(
        Item={
            'object_name': key,
            'deleted_at': deleted_at,
            'delete_by': user_id,
            'bucket_name': source_bucket
        }
    )   

