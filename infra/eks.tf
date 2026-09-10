resource "aws_eks_cluster" "cluster" {
  name     = "eks-${var.projectName}"
  role_arn = local.labRole
  version  = "1.32"

  access_config {
    authentication_mode = "API"
  }

  vpc_config {
    subnet_ids         = data.aws_subnets.public.ids
    security_group_ids = [data.aws_security_group.app.id]
  }

  tags = var.tags
}

resource "aws_launch_template" "node_group" {
  name_prefix = "${var.projectName}-nodeg-"

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 50
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "nodeg-${var.projectName}"
  node_role_arn   = local.labRole
  subnet_ids      = data.aws_subnets.public.ids
  instance_types  = [var.instance_type]

  launch_template {
    id      = aws_launch_template.node_group.id
    version = aws_launch_template.node_group.latest_version
  }

  scaling_config {
    min_size     = 2
    desired_size = 2
    max_size     = 5
  }

  update_config {
    max_unavailable = 1
  }

  tags = merge(var.tags, {
    "k8s.io/cluster-autoscaler/enabled"                = "true"
    "k8s.io/cluster-autoscaler/eks-${var.projectName}" = "owned"
  })
}
