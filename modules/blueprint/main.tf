module "eks_cluster" {
  source = "../eks"
  
  cluster_name = var.cluster_name
  kubernetes_version = var.kubernetes_version

  karpenter_enable = var.karpenter_enable
}
