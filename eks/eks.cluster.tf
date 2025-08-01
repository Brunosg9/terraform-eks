data "terraform_remote_state" "vpc" {
  backend   = "s3"
  config = {
    bucket         = "github-s3-terraform-tfstate2"
    key            = "vpc-terraform/terraform.tfstate"
    region         = "us-east-1"
  }
}

resource "aws_eks_cluster" "this" {
    name                        = "${var.eks_cluster.name}-${var.environment}"
    role_arn                    = aws_iam_role.eks_cluster_role.arn
    enabled_cluster_log_types   = var.eks_cluster.enabled_cluster_log_types
    bootstrap_self_managed_addons = false

    access_config {
        authentication_mode     = var.eks_cluster.access_config_athentication_mode
    }
    
    compute_config {
        enabled = true
        node_pools = ["general-purpose"]
        node_role_arn = aws_iam_role.eks_node_group.arn
    }
    
    kubernetes_network_config {
        elastic_load_balancing {
            enabled = true
        }
    }
    
    storage_config {
        block_storage {
            enabled = true
        }
    }
    
    vpc_config {
        subnet_ids              = data.terraform_remote_state.vpc.outputs.private_subnet_ids
    }
    depends_on = [
        aws_iam_role_policy_attachment.eks_cluster_policies,
    ]
}