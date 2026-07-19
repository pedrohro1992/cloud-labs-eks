variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

## KARPENTER
variable "karpenter_enable" {
  type = bool
  default = false
}

## ARGOCD
variable "argo_enable" {
  type = bool
  default = false
}

variable "repo_url" {
  type = string
  description = "Repo contain the projects"
  default = ""
}

## AWS Load Balancer Controller
variable "lb_controller_enable" {
  type = bool
  default = false
}
