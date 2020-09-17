terraform {
  backend "s3" {
    bucket = "test-busket-03-09-2020-terraform"
    key    = "build/key.txt"
    region = "eu-central-1"
  }
}