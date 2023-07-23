provider "aws" { 
  region = "us-east-1"
}

module "lambda_function" {
  source = "./modules/lambda_function"
}

module "step_function" {
  source = "./modules/step_function"
  lambda_function_arn = module.lambda_function.lambda_function_arn
}

module "event_bridge" {
  source = "./modules/event_bridge"
  step_function_arn = module.step_function.step_function_arn
  # step_function_id = module.step_function.step_function_id
}
