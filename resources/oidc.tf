data "tls_certificate" "eks-cluster" {
  url = aws_eks_cluster.gitops_eks.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks-oid" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks-cluster.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.gitops_eks.identity[0].oidc[0].issuer
}
