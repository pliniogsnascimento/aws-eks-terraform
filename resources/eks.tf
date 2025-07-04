resource "aws_eks_cluster" "gitops_eks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks-cluster-role.arn
  version  = var.k8s_version

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  tags = {
    Name = var.cluster_name
  }

  vpc_config {
    subnet_ids = [
      aws_subnet.private_subnet_1.id,
      aws_subnet.private_subnet_2.id,
      aws_subnet.private_subnet_3.id,
      aws_subnet.public_subnet_1.id,
      aws_subnet.public_subnet_2.id,
      aws_subnet.public_subnet_3.id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.gitops-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.gitops-AmazonEKSVPCResourceController
  ]
}

resource "aws_eks_node_group" "eks_ng_1" {
  cluster_name    = aws_eks_cluster.gitops_eks.name
  node_group_name = "gitops-ng-1"
  node_role_arn   = aws_iam_role.eks-node-role.arn
  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id,
    aws_subnet.private_subnet_3.id,
  ]

  capacity_type  = "SPOT"
  instance_types = ["t4g.small"]
  ami_type = "BOTTLEROCKET_ARM_64"

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = 2
  }

  depends_on = [
    aws_iam_role_policy_attachment.gitops-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.gitops-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.gitops-AmazonEKS_CNI_Policy
  ]

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  dynamic "taint" {
    for_each = var.taints
    content {
      key = taint.value["key"]
      effect = taint.value["effect"]
      value = taint.value["value"]
    }
  }

  tags = {
    "kubernetes.io/cluster/cluster-name/${var.cluster_name}" = "owned"
  }
}
