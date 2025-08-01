output "eks_cluster_name" {
  value       = aws_eks_cluster.this.name
}

output "eks_cluster_arn" {
  value       = aws_eks_cluster.this.arn
}

output "eks_cluster_role" {
  value       = aws_iam_role.eks_cluster_role.arn
}

# Node group output removed - using EKS Auto Mode
# output "node_group_arn" {
#   value       = aws_eks_node_group.this.arn
# }