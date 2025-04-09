output "cluster_id" {
  description = "EKS Cluster ID"
  value       = aws_eks_cluster.task-eks.id
}

output "cluster_certificate_authority_data" {
  description = "EKS Cluster Certificate Authority Data"
  value       = aws_eks_cluster.task-eks.certificate_authority.0.data

}

output "cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = aws_eks_cluster.task-eks.endpoint

}