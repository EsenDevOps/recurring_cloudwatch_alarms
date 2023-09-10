resource "aws_lambda_function" "notification_lambda" {
  filename      = "./lambda_py.zip"  # Path to your Lambda function's ZIP file
  function_name = "MyNotificationLambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.lambda_handler"  # Change this to your Lambda function's entry point
  runtime       = "python3.10"    # Change this to your desired runtime
  environment {
    variables = {
      TagForRepeatedNotification = "${var.tag_for_repeated_notification}"
      # Add more environment variables as needed
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "LambdaNotificatonRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "LambdaRoleInlinePolicy"
  description = "Inline policy for Lambda IAM role"

  policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect   = "Allow"
          Action   = [
            "cloudwatch:ListTagsForResource",
            "cloudwatch:DescribeAlarms"
          ],
          Resource = "*"
        },
        {
          Effect   = "Allow"
          Action   = [
            "sns:publish",
            "sns:ListTopics"
          ]
          Resource = "*"
        }
      ]
    })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_policy.arn
  # policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.lambda_role.name
}
