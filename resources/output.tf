output "cluster_endpoint" {
    value = aws_eks_cluster.gitops_eks.endpoint
}

output "cluster_ca" {
    value = aws_eks_cluster.gitops_eks.certificate_authority[0].data
}