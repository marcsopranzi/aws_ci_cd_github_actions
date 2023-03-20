################### TEST #####################################
#S3 Bucket on Which we will add policy
resource "aws_s3_bucket" "development-uat-bucket" {
  bucket        = "website-uat-ms"
  force_destroy = true
  tags = merge(
    local.common_tags,
    tomap({ "Name" = "uat-storage" })
  )
}

#DataSource to generate a policy document
data "aws_iam_policy_document" "public_read_access_uat" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.development-uat-bucket.arn,
      "${aws_s3_bucket.development-uat-bucket.arn}/*",
    ]
  }
}

#Resource to add bucket policy to a bucket 
resource "aws_s3_bucket_policy" "public_read_access_uat" {
  bucket = aws_s3_bucket.development-uat-bucket.id
  policy = data.aws_iam_policy_document.public_read_access_uat.json
}



################### PROD #####################################
#S3 Bucket on Which we will add policy
resource "aws_s3_bucket" "development-prod-bucket" {
  bucket        = "website-prod-ms"
  force_destroy = true
  tags = merge(
    local.common_tags,
    tomap({ "Name" = "prod-storage" })
  )
}

#DataSource to generate a policy document
data "aws_iam_policy_document" "public_read_access_prod" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.development-prod-bucket.arn,
      "${aws_s3_bucket.development-prod-bucket.arn}/*",
    ]
  }
}

#Resource to add bucket policy to a bucket 
resource "aws_s3_bucket_policy" "public_read_access_prod" {
  bucket = aws_s3_bucket.development-prod-bucket.id
  policy = data.aws_iam_policy_document.public_read_access_prod.json
}


