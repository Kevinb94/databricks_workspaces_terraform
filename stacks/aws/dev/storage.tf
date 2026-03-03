resource "aws_s3_bucket" "root" {
  bucket = var.root_bucket_name
  tags   = var.tags
  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "root" {
  bucket = aws_s3_bucket.root.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "root" {
  bucket                  = aws_s3_bucket.root.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# IMPORTANT: generate the policy ONLY from the bucket (per guide)
data "databricks_aws_bucket_policy" "root" {
  bucket = aws_s3_bucket.root.bucket
}

resource "aws_s3_bucket_policy" "root" {
  bucket     = aws_s3_bucket.root.id
  policy     = data.databricks_aws_bucket_policy.root.json
  depends_on = [aws_s3_bucket_public_access_block.root]
}

resource "databricks_mws_storage_configurations" "dev" {
  provider                   = databricks.mws
  storage_configuration_name  = "dbx-${var.env}-storage"
  bucket_name                = aws_s3_bucket.root.bucket
  account_id = var.databricks_account_id
}