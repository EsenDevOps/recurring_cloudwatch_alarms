provider "aws" { 
  region = "${var.region}"
}

# module "lambda_function" {
#   source = "./modules/lambda_function"
#   tag_for_repeated_notification = var.tag_for_repeated_notification
# }

# module "step_function" {
#   source = "./modules/step_function"
#   lambda_function_arn = module.lambda_function.lambda_function_arn
#   wait_seconds = var.wait_seconds
# }

# module "event_bridge" {
#   source = "./modules/event_bridge"
#   step_function_arn = module.step_function.step_function_arn
# }
