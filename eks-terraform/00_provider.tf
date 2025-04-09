terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.94.1"
    }
  }
  backend "s3" {
    bucket  = "task-1-eks-cluster"
    key     = "eks/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}