resource "aws_iam_policy" "Travis-Deploy-To-S3" {
  name        = "Travis-Deploy-To-S3"
  path        = "/"
  description = "Travis-Deploy-To-S3"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "s3:Get*",
                    "s3:List*",
                    "s3:PutObject"
                ],
                "Resource": [
                    "*"
                ]
            }
        ]
    })
}

resource "aws_iam_policy" "Travis-Deploy-To-EB" {
  name        = "Travis-Deploy-To-EB"
  path        = "/"
  description = "Travis-Deploy-To-EB"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action":[
                    "elasticbeanstalk:CreateApplicationVersion",
                    "elasticbeanstalk:DescribeEnvironments",
                    "elasticbeanstalk:DeleteApplicationVersion",
                    "elasticbeanstalk:UpdateEnvironment"
                ],
                "Resource": [
                    "arn:aws:elasticbeanstalk:*"
                ]
            }
        ]
    })
}

resource "aws_iam_policy_attachment" "Travis-Deploy-To-EB-attc" {
  name       = "Travis-Deploy-To-EB-attc"
  users      = ["Travis"]
  policy_arn = aws_iam_policy.Travis-Deploy-To-EB.arn
}

resource "aws_iam_policy_attachment" "Travis-Deploy-To-S3-attc" {
  name       = "Travis-Deploy-To-S3-attc"
  users      = ["Travis"]
  policy_arn = aws_iam_policy.Travis-Deploy-To-S3.arn
}

resource "aws_iam_policy_attachment" "Travis-VPC-Access" {
  name       = "Travis-VPC-Access"
  users      = ["Travis"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_policy_attachment" "Travis-EC2-Access" {
  name       = "Travis-EC2-Access"
  users      = ["Travis"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_policy_attachment" "ElasticBeanstalkCustom" {
  name       = "TravisElasticBeanstalkCustom"
  users      = ["Travis"]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkCustomPlatformforEC2Role"
}

resource "aws_iam_policy_attachment" "CloudFormationRead" {
  name       = "CloudFormationRead"
  users      = ["Travis"]
  policy_arn = "arn:aws:iam::aws:policy/AWSCloudFormationReadOnlyAccess"
}