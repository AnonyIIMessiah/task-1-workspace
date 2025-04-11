# Install the EBS CSI Driver using Helm via Terraform
# helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
# helm repo update
# helm install my-nginx-ingress ingress-nginx/ingress-nginx

resource "helm_release" "my-nginx-ingress" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"


  depends_on = [
    aws_eks_cluster.task-eks,
    aws_iam_role_policy_attachment.ebs_csi_driver_policy
  ]
}