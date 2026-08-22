resource "aws_security_group_rule" "eks_cluster_sg_to_rds" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = data.aws_security_group.rds.id
  source_security_group_id = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
  description              = "PostgreSQL a partir do security group automatico do cluster EKS"
}

resource "aws_security_group_rule" "alb_to_eks_cluster_sg_nodeport" {
  type                     = "ingress"
  from_port                = 30080
  to_port                  = 30080
  protocol                 = "tcp"
  security_group_id        = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
  source_security_group_id = data.aws_security_group.alb.id
  description              = "NodePort da aplicacao (30080) a partir do ALB do api-gateway"
}
