provider "aws" {
  region     = "us-east-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

locals {
  user = ["Azure"]
}

variable aws_access_key {
  sensitive = true
}

variable aws_secret_key {
  sensitive = true
}