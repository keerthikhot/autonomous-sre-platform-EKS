# Architecture:
# - 1 master: AWS-managed EKS control plane (single cluster API/etcd)
# - 2 workers: EC2 instances in the managed node group below

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.project_name}-cluster"
  cluster_version = var.cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    workers = {
      name           = "${var.project_name}-workers"
      instance_types = [var.node_instance_type]

      min_size     = var.worker_node_count
      max_size     = var.worker_node_count
      desired_size = var.worker_node_count

      disk_size = var.node_disk_size

      labels = {
        role = "worker"
      }
    }
  }

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    eks-pod-identity-agent = {
      most_recent = true
    }
  }
}
