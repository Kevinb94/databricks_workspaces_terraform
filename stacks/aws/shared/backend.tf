terraform {
  backend "s3" {
    bucket = "terraform-edw-state"
    key    = "databricks/aws/shared/terraform.tfstate"
    region = "us-east-1"
  }
}