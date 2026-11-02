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

resource "aws_security_group_rule" "alb_to_eks_cluster_sg_core_service" {
  type                     = "ingress"
  from_port                = 30081
  to_port                  = 30081
  protocol                 = "tcp"
  security_group_id        = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
  source_security_group_id = data.aws_security_group.alb.id
  description              = "NodePort do core-service (30081) a partir do ALB do api-gateway"
}

resource "aws_security_group_rule" "alb_to_eks_cluster_sg_repair_service" {
  type                     = "ingress"
  from_port                = 30082
  to_port                  = 30082
  protocol                 = "tcp"
  security_group_id        = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
  source_security_group_id = data.aws_security_group.alb.id
  description              = "NodePort do repair-service (30082) a partir do ALB do api-gateway"
}

resource "aws_security_group_rule" "alb_to_eks_cluster_sg_stock_service" {
  type                     = "ingress"
  from_port                = 30083
  to_port                  = 30083
  protocol                 = "tcp"
  security_group_id        = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
  source_security_group_id = data.aws_security_group.alb.id
  description              = "NodePort do stock-service (30083) a partir do ALB do api-gateway"
}

resource "aws_security_group_rule" "alb_to_eks_cluster_sg_billing_service" {
  type                     = "ingress"
  from_port                = 30084
  to_port                  = 30084
  protocol                 = "tcp"
  security_group_id        = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
  source_security_group_id = data.aws_security_group.alb.id
  description              = "NodePort do billing-service (30084) a partir do ALB do api-gateway"
}

resource "aws_security_group_rule" "alb_to_eks_cluster_sg_sonarqube" {
  type                     = "ingress"
  from_port                = 30900
  to_port                  = 30900
  protocol                 = "tcp"
  security_group_id        = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
  source_security_group_id = data.aws_security_group.alb.id
  description              = "NodePort do SonarQube (30900) a partir do ALB do api-gateway"
}
