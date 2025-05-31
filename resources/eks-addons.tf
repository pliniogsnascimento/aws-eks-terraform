resource "aws_eks_addon" "eks-addon-vpc-cni" {
  cluster_name = aws_eks_cluster.gitops_eks.name
  addon_name   = "vpc-cni"
}

resource "aws_eks_addon" "eks-addon-kube-proxy" {
  cluster_name = aws_eks_cluster.gitops_eks.name
  addon_name   = "kube-proxy"
}

resource "aws_eks_addon" "eks-addon-coredns" {
  cluster_name = aws_eks_cluster.gitops_eks.name
  addon_name   = "coredns"
}
