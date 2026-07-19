module "eks_cluster" {
  source = "../eks"
  
  cluster_name = var.cluster_name
  cluster_endpoint = module.eks_cluster.cluster_endpoint
  kubernetes_version = var.kubernetes_version

  karpenter_enable = var.karpenter_enable
}

module "aws_load_balancer_controller" {
  count = var.lb_controller_enable ? 1 : 0
  source = "../aws-load-balancer-controller"

  cluster_name = var.cluster_name

  provider_arn = module.eks_cluster.oidc_provider_arn

  depends_on = [ module.eks_cluster ]
}
#
# module "argo_core" {
#   count = var.argo_enable ? 1 : 0
#   source = "../argo"
#
#   repo_url = var.repo_url
#
#   depends_on = [ module.aws_load_balancer_controller ]
# }

