resource "aws_cloudwatch_event_rule" "eventbridge_rule" {
  name        = "MyEventBridgeRule"
  description = "EventBridge rule to capture all alarms' state change events"
  event_pattern = <<EOF
{
  "detail": {
    "state": {
      "value": ["ALARM"]
    }
  },
  "detail-type": ["CloudWatch Alarm State Change"],
  "source": ["aws.cloudwatch"]
}
EOF
}

resource "aws_cloudwatch_event_target" "step_function_target" {
  rule      = aws_cloudwatch_event_rule.eventbridge_rule.name
  arn       = aws_sfn_state_machine.step_function.arn
  target_id = "my_target"
  role_arn  = aws_iam_role.eventbridge_target_role.arn
}

resource "aws_iam_role" "eventbridge_target_role" {
  name = "EventBridgeTargetRole"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "eventbridge_target_role_policy" {
  name        = "EventBridgeTargetRoleInlinePolicy2"  # Give a unique name
  description = "Inline policy for EventBridge Target IAM role"

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = ["states:*"],
        Effect   = "Allow",
        Resource = aws_sfn_state_machine.step_function.arn
      },
      {
        Action   = [
          "states:ListStateMachines",
          "states:CreateActivity",
          "states:StartExecution"
        ],
        Effect   = "Allow",
        Resource = "${aws_cloudwatch_event_target.step_function_target.arn}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eventbridge_target_role_policy_attachment" {
  policy_arn = aws_iam_policy.eventbridge_target_role_policy.arn
  role       = aws_iam_role.eventbridge_target_role.name
}
