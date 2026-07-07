module "karpenter" {
  count  = var.karpenter_enable ? 1 : 0
  source = "terraform-aws-modules/eks/aws//modules/karpenter"

  cluster_name = module.eks.cluster_name

  create_iam_role = true
  iam_role_name   = "${module.eks.cluster_name}-karpenter-controller"

  node_iam_role_use_name_prefix = false
  node_iam_role_name = var.cluster_name
  create_pod_identity_association = true

  node_iam_role_additional_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  enable_spot_termination         = true

  queue_name = "${module.eks.cluster_name}-karpenter"

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

resource "helm_release" "karpenter" {
  count  = var.karpenter_enable ? 1 : 0
  namespace           = "kube-system"
  name                = "karpenter"
  repository          = "oci://public.ecr.aws/karpenter"
  repository_username = data.aws_ecrpublic_authorization_token.token.user_name
  repository_password = data.aws_ecrpublic_authorization_token.token.password
  chart               = "karpenter"
  version             = "1.6.0"
  wait                = false

  values = [
    <<-EOT
    nodeSelector:
      cloudlabs.infra-services: 'true'
    dnsPolicy: Default
    settings:
      clusterName: ${var.cluster_name}
      clusterEndpoint: ${var.cluster_endpoint}
      interruptionQueue: ${module.karpenter[0].queue_name}
      enableZonalShift: true
    webhook:
      enabled: false
    EOT
  ]
}
