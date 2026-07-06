module "karpenter" {
  count = var.karpenter_enable ? 1 : 0
  source = "terraform-aws-modules/eks/aws//modules/karpenter"

  cluster_name = module.eks.cluster_name

  create_iam_role = true
  iam_role_name   = "${module.eks.cluster_name}-karpenter-controller"

  create_node_iam_role = true
  node_iam_role_name   = "${module.eks.cluster_name}-karpenter-node"

  create_pod_identity_association                     = true
  enable_spot_termination         = true 

  queue_name = "${module.eks.cluster_name}-karpenter"

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
