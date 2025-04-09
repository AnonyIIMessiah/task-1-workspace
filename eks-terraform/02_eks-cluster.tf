resource "aws_eks_cluster" "task-eks" {
  name = "task-eks"

  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.cluster.arn
  version  = "1.31"

  vpc_config {
    subnet_ids = data.aws_subnets.eks_subnet.ids

    endpoint_public_access = true
  }



  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}

resource "aws_iam_role" "cluster" {
  name = "task-eks-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}

# resource "aws_eks_access_entry" "user-1" {
#   cluster_name      = aws_eks_cluster.task-eks.name
#   principal_arn     = var.user_arn
#   kubernetes_groups = ["system:masters"] # Optional
# }

# Create access entry (no groups needed)
resource "aws_eks_access_entry" "user_1" {
  cluster_name  = aws_eks_cluster.task-eks.name
  principal_arn = var.user_arn
}

# Grant admin access using access policy
resource "aws_eks_access_policy_association" "admin_policy" {
  cluster_name  = aws_eks_cluster.task-eks.name
  principal_arn = var.user_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}
