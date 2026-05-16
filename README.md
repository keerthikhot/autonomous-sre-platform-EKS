# AI-Powered EKS (Terraform)

Terraform layout that provisions an **Amazon EKS** cluster with:

- **1 master (control plane)** — AWS-managed EKS API/etcd (not an EC2 instance).
- **2 worker nodes** — EKS managed node group (`min` / `max` / `desired` = 2).

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) configured (`aws configure` or env vars)
- IAM permissions to create VPC, EKS, EC2, IAM roles, etc.

## Deploy

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars   # edit region/name if needed
terraform init
terraform plan
terraform apply
```

After apply, configure `kubectl`:

```bash
aws eks update-kubeconfig --region <region> --name ai-powered-eks-cluster
kubectl get nodes
```

You should see two worker nodes in `Ready` state.

## Destroy

```bash
cd terraform
terraform destroy
```

## Layout

| File | Purpose |
|------|---------|
| `versions.tf` | Terraform and provider constraints |
| `providers.tf` | AWS provider |
| `variables.tf` | Input variables |
| `vpc.tf` | VPC, subnets, NAT (2 AZs) |
| `eks.tf` | EKS cluster (1 control plane) + 2-node worker group |
| `outputs.tf` | Cluster endpoint, kubeconfig hint |

## Cost note

Default worker type is `t3.small` (Free Tier–eligible). NAT Gateway and EKS control plane still incur charges. Destroy when idle with `terraform destroy`.
