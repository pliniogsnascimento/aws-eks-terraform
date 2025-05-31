variable "cluster_name" {
  default = "gitops-eks"
}

variable "enable_argocd" {
  default = false
}

variable "enable_metrics_server" {
  default = false
}
