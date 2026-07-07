module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }

  endpoint_public_access = false

  enable_cluster_creator_admin_permissions = true

  vpc_id     = data.aws_vpc.this.id
  subnet_ids = data.aws_subnets.private.ids

  security_group_additional_rules = {
    vpn_https = {
      description              = "Access from VPN"
      type                     = "ingress"
      from_port                = 443
      to_port                  = 443
      protocol                 = "tcp"
      source_security_group_id = data.aws_security_group.pivpn.id
    }
  }

  node_security_group_tags = {
    "karpenter.sh/discovery" = var.cluster_name
  }

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    infra-services = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]

      min_size     = 2
      max_size     = 10
      desired_size = 2

      labels = {
        "cloudlabs.infra-services" = "true"
      }

      metadata_options = {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 2
      }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
