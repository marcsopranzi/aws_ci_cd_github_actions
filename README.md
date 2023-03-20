# AWS Terraform continuous deployment of static website

This repo shows how simple it is to deploy a static website in aws-s3 using terraform and github actions.
The template code can be found at: sample site: [https://github.com/startbootstrap/startbootstrap-resume]
Your website will available at: `https://{BUCKET-NAME}.s3.{REGION}.amazonaws.com/public/index.html`


## AWS:
The first step is to set up AWS credentials for an S3 user with programmatic access, the credentials will be used for github actions and for terraform.

## Terraform:
To ensure the correct settings for each bucket, the best approach is to use infrastructure as code. The resources are:
* **aws_s3_bucket** defining bucket name, tags and deletion of non empty buckets.
* **aws_iam_policy_document** defining the policy to make the site available to external users.
* **aws_s3_bucket_policy** applying the policy for the bucket.

## Github:
The master/main branch should be protected to avoid accidental releases into production.
In the settingS section create the keys AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY for the matching values in AWS.
Actions:
* **Checkout code** to make the repo available for the workflow.
* **Aws-actions** to connect to aws.
* **AWS Shell** to update the website files.

Each time a feature branch pushes code into the remote repo, a github action will deploy the changes to a UAT site for user acceptance testing. If everything is OK, after a pull request and merge, these changes will be available in production.
