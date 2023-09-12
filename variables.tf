variable "region" {
  type        = string
  default     = "us-east-1"
}

// lambda function variables

variable "tag_for_repeated_notification" {
  type    = string
  default = "RepeatedAlarm:true"
}

variable "wait_seconds" {
  type    = number
  default = 30
}

variable bucket_id {
  type        = string
  default     = "recurring-lambda-code"
}

variable object_key {
  type        = string
  default     = "lambda_py.zip"
}
