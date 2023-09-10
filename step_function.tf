resource "aws_sfn_state_machine" "step_function" {
  name     = "MyStepFunction"
  role_arn = aws_iam_role.stepfunction_role.arn

  definition = <<EOF
{
  "StartAt": "WaitState",
  "States": {
    "WaitState": {
      "Type": "Wait",
      "Seconds": ${var.wait_seconds},
      "Next": "LambdaTask"
    },
    "LambdaTask": {
      "Type": "Task",
      "Resource": "${aws_lambda_function.notification_lambda.arn}",
      "Next": "ChoiceTask"
    },
    "ChoiceTask": {
      "Type": "Choice",
      "Choices": [
        {
          "Variable": "$.currState",
          "StringEquals": "OK",
          "Next": "SuccessState"
        },
        {
          "Variable": "$.currState",
          "StringEquals": "ALARM",
          "Next": "WaitState"
        }
      ],
      "Default": "DefaultState"
    },
    "SuccessState": {
      "Type": "Succeed"
    },
    "DefaultState": {
      "Type": "Succeed"
    }
  }
}
EOF
}

resource "aws_iam_role" "stepfunction_role" {
  name = "StepFunctionsExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "states.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "stepfunction_policy" {
  name        = "StepFunctionInlinePolicy"
  description = "Inline policy for Step Function IAM role"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["lambda:InvokeFunction"],
        Effect = "Allow",
        Resource = aws_lambda_function.notification_lambda.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "stepfunction_policy_attachment" {
  policy_arn = aws_iam_policy.stepfunction_policy.arn
  # policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.stepfunction_role.name
}
