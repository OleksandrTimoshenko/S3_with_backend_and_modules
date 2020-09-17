variable "aws_access_key" {
  description = "Access key to your AWS account "
}

variable "aws_secret_key" {
  description = "Secret key to your AWS account "
}

module "staging" {
    source = "../../"
    aws_access_key = var.aws_access_key
    aws_secret_key = var.aws_secret_key
}