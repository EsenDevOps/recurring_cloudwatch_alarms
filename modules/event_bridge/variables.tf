variable "step_function_arn" {}

# variable "cloudwatch_arn" {}

variable "cloudwatch_alarm_tag_key" {
  default = "send-repeated-notification"
}

variable "cloudwatch_alarm_tag_value" {
  default = "true"
}