output "control_plane_count" {
  description = "Managed EKS control planes (master) — always 1 per cluster"
  value       = 1
}

output "worker_node_count" {
  description = "Configured worker node count"
  value       = var.worker_node_count
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Kubernetes API server endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "Base64-encoded CA certificate for kubectl"
  value       = module.eks.cluster_certificate_authority_data
  sensitive   = true
}

output "cluster_oidc_issuer_url" {
  description = "OIDC issuer URL for IRSA"
  value       = module.eks.cluster_oidc_issuer_url
}

output "configure_kubectl" {
  description = "Command to configure kubectl for this cluster"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}"
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "node_group_autoscaling_group_names" {
  description = "Auto Scaling group names for worker nodes"
  value       = module.eks.eks_managed_node_groups_autoscaling_group_names
}
