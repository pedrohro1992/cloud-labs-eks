variable "argocd_version" {
  type        = string
  default     = "7.7.0" # Versão do Helm Chart
  description = "ArgoCD chart version"
}

variable "repo_url" {
  type = string
  description = "Repo contain the projects"
  default = ""
}
