resource "aws_s3_bucket" "demo-bucket" {
  bucket = "demo-bucket"

  tags = {
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "demo-bucket-acl" {
  bucket = aws_s3_bucket.demo-bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "demo-bucket-versioning" {
  bucket = aws_s3_bucket.demo-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "demo-path" {
    bucket = aws_s3_bucket.demo-bucket.id
    key    = "hello-world/"
    source = "/dev/null"
}