module "cloud_labs" {
  source = "../../modules/blueprint"

  cluster_name = "cloud-labs"
  kubernetes_version = "1.36"

  karpenter_enable = true
}
