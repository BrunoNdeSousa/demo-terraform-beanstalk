# AWS Elastic Beanstalk with Terraform

The infrastructure for this project was provisioned using Terraform and AWS Elastic Beanstalk. How it's done is explained in more detail bellow.

## Files in the folder

Below are the files used to provision the infrastructure and a brief explanation of what's written in them.

### `main.tf`

Used to tell Terraform what provider we'll be using. In our case, it's `aws`, and right below the aws region: `us-east-2`.

### `host.tf`

In this file, we declare two types of resource:

`aws_elastic_beanstalk_application`: creates an application resource in EB, which will be to deploy our application during CD.

`aws_elastic_beanstalk_environment`: creates an environment in which to deploy our application. In practice, it creates a small ec2 instance using the template declared in `solution_stack_name`, using a default vpc and security group with rules for access. Note the instance profile attached in the settings; it's necessary to launch an EB environment with a basic IAM role with access to S3 and EC2.

### `iam.tf`

For this file, we declare the resources:

`aws_iam_policy`: access policies used by the deploy user to read and write objects from S3 and Elastic Beanstalk.

`aws_iam_policy_attachment`: after creating the access policies, it's necessary to attach them to the user. That includes pre-configured policies that will allow the user to deploy to Elastic Beanstalk.

### `s3.tf`

Used to create the bucket and the path used by CD for deployment.

`aws_s3_bucket`: creates the bucket.

`aws_s3_bucket_acl`: attaches acl policy.

`aws_s3_bucket_versioning`: defines bucket versioning policy.

`aws_s3_object`: creates the path inside.