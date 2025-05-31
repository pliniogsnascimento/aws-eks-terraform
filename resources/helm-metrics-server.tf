resource "helm_release" "metrics-server" {
  count = var.enable_metrics_server ? 1 : 0
  name  = "metrics-server"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metrics-server"
  namespace  = "kube-system"

  values = ["${file("${path.module}/templates/metrics-server.yaml")}"]
}
