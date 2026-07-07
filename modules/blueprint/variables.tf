variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "karpenter_enable" {
  type = bool
  default = false
}

variable "argo_enable" {
  type = bool
  default = false
}
