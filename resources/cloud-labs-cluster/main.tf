module "cloud_labs" {
  source = "../../modules/blueprint"

  cluster_name = "cloud-labs"
  kubernetes_version = "1.36"

  karpenter_enable = true

  repo_url = "https://github.com/pedrohro1992/cloud-labs-gitops-infra.git"

  lb_controller_enable = true

  argo_enable = false

}
