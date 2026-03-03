variable "databricks_account_id" {
  type        = string
  description = "Databricks Account ID"
}

variable "env" {
  type        = string
  description = "Environment name (dev/prod)"
  default     = "dev"
}

variable "root_bucket_name" {
  type = string
}

variable "project" {
  type = string
  default = "dbx-workspace-iac"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "tags" {
  type = map(string)
}
