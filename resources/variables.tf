variable "cluster_name" {
  default = "gitops-eks"
}

variable "enable_argocd" {
  default = false
}

variable "enable_metrics_server" {
  default = false
}

variable "k8s_version" {
  default = "1.33"
}

variable "taints" {
  default = []
}

variable "min_size" {
  default = 2
}

variable "max_size" {
  default = 6
}

variable "desired_size" {
  default = 3
}
