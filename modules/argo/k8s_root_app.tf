resource "kubectl_manifest" "argocd_root_infra" {
  yaml_body = templatefile("${path.module}/templates/root-app.yaml", {
    repo_url        = var.repo_url
    target_revision = "HEAD"
  })
}
