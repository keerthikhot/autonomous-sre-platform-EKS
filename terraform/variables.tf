variable "aws_region" {
  description = "AWS region for the EKS cluster"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix for resources"
  type        = string
  default     = "ai-powered-eks"
}

variable "environment" {
  description = "Environment label (e.g. dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS control plane"
  type        = string
  default     = "1.31"
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes (must be free-tier-eligible if your account restricts launches)"
  type        = string
  default     = "t3.small"

  validation {
    condition = contains(
      ["t2.micro", "t3.micro", "t3.small", "t4g.micro", "t4g.small"],
      var.node_instance_type
    )
    error_message = "node_instance_type must be Free Tier-eligible (e.g. t3.small). t3.medium is not allowed on Free Tier accounts."
  }
}

variable "node_disk_size" {
  description = "Root volume size (GiB) for worker nodes"
  type        = number
  default     = 20
}

variable "worker_node_count" {
  description = "Number of worker nodes in the managed node group"
  type        = number
  default     = 2

  validation {
    condition     = var.worker_node_count >= 1 && var.worker_node_count <= 10
    error_message = "worker_node_count must be between 1 and 10."
  }
}
