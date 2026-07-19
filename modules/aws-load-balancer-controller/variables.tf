variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "provider_arn" {
  description = "ARN of the Cluster OIDC Provider"
  type        = string
}
