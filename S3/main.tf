
terraform {
  required_version = "~> 1.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }


  backend "s3" {
    bucket = "bootcamp29-1-anne"
    key = "terraform/terraform.tfstate"
    dynamodb_table = "terraform-lock"
    region = "us-east-2"
    encrypt = true

 }
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.aws_s3_bucket
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
  }
  tags = {
    Name        = var.bucket-tag
    Environment = "Dev"
  }
}

resource "aws_dynamodb_table" "tf_lock" {
  name = var.aws_dynamodb_table 
  hash_key = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  
  attribute {
     name = "LockID"
     type = "S"
   }
  tags = {
    Name = "Terraform Lock Table"
   }
   lifecycle {
   prevent_destroy = false
  }

  
  #Provider Block
provider "aws" {
   region  = var.region
   profile = "landmark"
 }
 
 }

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