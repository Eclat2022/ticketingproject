variable "aws_s3_bucket" {
  description = "the bucket"
  default     = "bootcamp29-1-anne"
  type        = string
}

 
variable "bucket-tag" {
  description = "the bucket tag"
  default     = "Terraform Lock Table"
  type        = string
}

variable  "aws_dynamodb_table" {
  description = "the dynamo_db_table"
  default     = "terraform-lock"
  type        = string
}

variable  "region" {
  description = "aws region"
  default     = "us-east-2"
  type        = string
}