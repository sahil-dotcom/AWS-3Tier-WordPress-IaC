terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.82"
    }
  }
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket         = "terraform-state-locking-6y3mxj"
    key            = "dev/app/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "state-lock"
    encrypt        = true
  }
}