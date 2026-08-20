resource "aws_eks_access_entry" "access_entry" {
  cluster_name  = aws_eks_cluster.cluster.name
  principal_arn = local.principalArn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "access_entry_association" {
  cluster_name  = aws_eks_cluster.cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = local.principalArn

  access_scope {
    type = "cluster"
  }
}
