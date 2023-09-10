variable "region" {
  type        = string
  default     = "us-east-1"
}

//event bridge variables

variable "cloudwatch_alarm_tag_key" {
  default = "send-repeated-notification"
}

variable "cloudwatch_alarm_tag_value" {
  default = "true"
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