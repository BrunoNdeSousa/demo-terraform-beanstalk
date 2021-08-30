resource "aws_s3_bucket" "test-b-ci-travis" {
  bucket = "test-b-ci-travis"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "travis-path" {
    bucket = "${aws_s3_bucket.test-b-ci-travis.id}"
    acl    = "private"
    key    = "hello-world/"
    source = "/dev/null"
}