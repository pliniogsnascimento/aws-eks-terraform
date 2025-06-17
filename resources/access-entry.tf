data "aws_caller_identity" "current" {}

resource "aws_eks_access_entry" "main_user" {
  cluster_name      = aws_eks_cluster.gitops_eks.name
  principal_arn     = data.aws_caller_identity.current.arn
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "main_user_policy_association" {
  cluster_name  = aws_eks_cluster.gitops_eks.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = data.aws_caller_identity.current.arn

  access_scope {
    type       = "cluster"
  }
}
