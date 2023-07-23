variable "wait_seconds" {
  type        = number
  default     = 30
}

variable "tag_for_repeated_notification" {
  type        = string
  default     = "RepeatedAlarm:true"
}
