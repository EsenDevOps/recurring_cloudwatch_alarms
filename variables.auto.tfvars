// aws region where cloud resources are provisioned and hosted 
region="us-east-1"

// number of seconds lambda will wait until sending next email
wait_seconds=5

// tag that you need to add to cloudwatch alarm
tag_for_repeated_notification="RepeatedAlarm:true"

// bucket id that should contain object with code (bucket should be in the same region as lambda function)
bucket_id="recurring-lambda-code"

// s3 object that should have app code
object_key="lambda_py.zip"