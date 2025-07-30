resource "aws_eks_node_group" "this" {
    cluster_name    = "${aws_eks_cluster.this.name}"
    node_group_name = "${var.eks_cluster.name}-node-group"
    node_role_arn   = aws_iam_role.eks_node_group_role.arn
    subnet_ids     = data.terraform_remote_state.eks.outputs.private_subnet_ids
    capacity_type   = var.eks_cluster.node_group.capacity_type
    instance_types  = var.eks_cluster.node_group.instance_type

    scaling_config {
        desired_size = var.eks_cluster.node_group.scaling_config_desired_size
        max_size     = var.eks_cluster.node_group.scaling_config_max_size
        min_size     = var.eks_cluster.node_group.scaling_config_min_size
    }

    depends_on = [
        aws_iam_role_policy_attachment.eks_node_AmazonEKSWorkerNodePolicy,
        aws_iam_role_policy_attachment.eks_AmazonEKS_CNI_Policy,
        aws_iam_role_policy_attachment.eks_ContainerRegistryReadOnly,
    ]
}