variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "karpenter_enable" {
  description = "Enable the IAM config for Karpenter"
  type = bool
  default = false
}
