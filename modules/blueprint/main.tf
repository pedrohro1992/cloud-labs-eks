module "eks_cluster" {
  source = "../eks"
  
  cluster_name = var.cluster_name
  cluster_endpoint = module.eks_cluster.cluster_endpoint
  kubernetes_version = var.kubernetes_version

  karpenter_enable = var.karpenter_enable
}

module "argo_core" {
  count = var.argo_enable ? 1 : 0
  source = "../argo"

  depends_on = [ module.eks_cluster ]
}
