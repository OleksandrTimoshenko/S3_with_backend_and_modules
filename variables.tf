variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "bucket_name" {
  default="test-busket-terraform-with-backend"
}

variable "mime_types" {
  default = {
    htm = "text/html"
    html = "text/html"
    css = "text/css"
    js = "application/javascript"
    map = "application/javascript"
    json = "application/json"
  }
}