# Get the OIDC provider URL for the EKS cluster
data "aws_eks_cluster" "this" {
  name = aws_eks_cluster.task-eks.name
}

data "aws_caller_identity" "current" {}

locals {
  oidc_provider = replace(data.aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")
}

# Create an IAM OIDC provider for the EKS cluster
resource "aws_iam_openid_connect_provider" "eks_oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"] # This is the thumbprint for AWS OIDC, you may need to update this
  url             = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
}

# Create IAM role for the EBS CSI Driver
resource "aws_iam_role" "ebs_csi_driver_role" {
  name = "ebs-csi-driver-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_provider}"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${local.oidc_provider}:sub" : "system:serviceaccount:kube-system:ebs-csi-controller-sa",
            "${local.oidc_provider}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

# Attach the AWS managed EBS CSI Driver policy to the role
resource "aws_iam_role_policy_attachment" "ebs_csi_driver_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.ebs_csi_driver_role.name
}

