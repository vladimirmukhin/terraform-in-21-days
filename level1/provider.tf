terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

  required_version = ">= 1.2.0"

  backend "s3" {
    bucket         = "terraform-remote-state-123123123"
    key            = "level1.tfstate"
    region         = "us-east-1"
    dynamodb_table = "remote-state"
  }
}

provider "aws" {
  region = "us-east-1"
}
