resource "aws_elastic_beanstalk_application" "hello-world" {
  name        = "hello-world"
  description = "hello-world-app"
}

resource "aws_elastic_beanstalk_environment" "hello-world-env" {
  name                = "hello-world-env"
  application         = aws_elastic_beanstalk_application.hello-world.name
  solution_stack_name = "64bit Amazon Linux 2 v3.4.4 running Docker"
  setting {
      namespace = "aws:autoscaling:launchconfiguration"
      name      = "IamInstanceProfile"
      value     = "aws-elasticbeanstalk-ec2-role"
    }
}