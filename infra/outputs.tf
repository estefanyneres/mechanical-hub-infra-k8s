output "eks_cluster_name" {
  description = "Nome do cluster EKS"
  value       = aws_eks_cluster.cluster.name
}

output "eks_cluster_endpoint" {
  description = "Endpoint de acesso ao cluster EKS"
  value       = aws_eks_cluster.cluster.endpoint
}
