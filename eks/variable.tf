variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "prd"
}

variable "eks_cluster" {
    type = object({
        name                             = string
        role_name                        = string
        access_config_athentication_mode = string
        private_subnet_ids               = list(string)
        enabled_cluster_log_types        = list(string)
        node_group = object({
            role_name                     = string
            instance_type                 = list(string)
            capacity_type                 = string
            scaling_config_desired_size   = number
            scaling_config_max_size       = number
            scaling_config_min_size       = number
        })
    })
    default = {
        name                             = "eks-cluster"
        role_name                        = "eks-cluster-role"
        access_config_athentication_mode = "API_AND_CONFIG_MAP"
        private_subnet_ids               = ["<change-here>", "<change-here>"]
        enabled_cluster_log_types        = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
        node_group = {
            role_name                     = "eks-node-group-role"
            instance_type                 = ["t3.medium"]
            capacity_type                 = "ON_DEMAND"
            scaling_config_desired_size   = 1
            scaling_config_max_size       = 1
            scaling_config_min_size       = 1
        }
    }
}