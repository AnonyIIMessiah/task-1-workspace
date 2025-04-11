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

# Configure the Kubernetes provider with proper authentication
provider "kubernetes" {
  host                   = aws_eks_cluster.task-eks.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.task-eks.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.task-eks.name]
    command     = "aws"
  }
}

# Configure the Helm provider with the same authentication
provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.task-eks.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.task-eks.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.task-eks.name]
      command     = "aws"
    }
  }
}