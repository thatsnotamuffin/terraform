resource "aws_eks_addon" "eks_addon" {
    cluster_name    = var.cluster_name
    addon_name      = var.target_addon
    addon_version   = var.version
}
