resource "aws_iam_policy" "Deploy-To-S3" {
  name        = "Deploy-To-S3"
  path        = "/"
  description = "Deploy-To-S3"

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

resource "aws_iam_policy" "Deploy-To-EB" {
  name        = "Deploy-To-EB"
  path        = "/"
  description = "Deploy-To-EB"

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

resource "aws_iam_policy_attachment" "Deploy-To-EB-attc" {
  name       = "Deploy-To-EB-attc"
  users      = local.user
  policy_arn = aws_iam_policy.Deploy-To-EB.arn
}

resource "aws_iam_policy_attachment" "Deploy-To-S3-attc" {
  name       = "Deploy-To-S3-attc"
  users      = local.user
  policy_arn = aws_iam_policy.Deploy-To-S3.arn
}

resource "aws_iam_policy_attachment" "VPC-Access" {
  name       = "VPC-Access"
  users      = local.user
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_policy_attachment" "EC2-Access" {
  name       = "EC2-Access"
  users      = local.user
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_policy_attachment" "ElasticBeanstalkCustom" {
  name       = "ElasticBeanstalkCustom"
  users      = local.user
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkCustomPlatformforEC2Role"
}

resource "aws_iam_policy_attachment" "CloudFormationRead" {
  name       = "CloudFormationRead"
  users      = local.user
  policy_arn = "arn:aws:iam::aws:policy/AWSCloudFormationReadOnlyAccess"
}