variable "cluster_name" {
  description = "Name of the EKS cluster"
  type = string
}

variable "kubernetes_version" {
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.33`)"
  type = string
}
