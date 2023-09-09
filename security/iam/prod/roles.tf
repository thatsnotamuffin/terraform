#- EKS
# Node Role
resource "aws_iam_role" "eks_node_role" {
  name               = "eks-node-role"
  assume_role_policy = local.eks_trust_policy

  tags = {
    Name        = "eks-node-role"
    Service     = "Kubernetes"
    Environment = "All"
    Managed_By  = local.managed_by
  }
}

resource "aws_iam_role_policy_attachment" "eks_node_worker_attach" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

  depends_on = [
    aws_iam_role.eks_node_role
  ]
}

resource "aws_iam_role_policy_attachment" "eks_node_ecr_attach" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

  depends_on = [
    aws_iam_role.eks_node_role
  ]
}

resource "aws_iam_role_policy_attachment" "eks_node_attach" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

  depends_on = [
    aws_iam_role.eks_node_role
  ]
}

resource "aws_iam_role_policy_attachment" "eks_node_dns_attach" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = aws_iam_policy.external_dns_policy.arn

  depends_on = [
    aws_iam_role.eks_node_role,
    aws_iam_policy.external_dns_policy
  ]
}

resource "aws_iam_role_policy_attachment" "eks_node_autoscaler_attach" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = aws_iam_policy.autoscaler_policy.arn

  depends_on = [
    aws_iam_role.eks_node_role,
    aws_iam_policy.autoscaler_policy
  ]
}

# Cluster Role
resource "aws_iam_role" "eks_cluster_role" {
  name               = "eks-cluster-role"
  assume_role_policy = local.eks_trust_policy

  tags = {
    Name        = "eks-cluster-role"
    Service     = "Kubernetes"
    Environment = "All"
    Managed_By  = local.managed_by
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_attach" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  depends_on = [
    aws_iam_role.eks_cluster_role
  ]
}

resource "aws_iam_role_policy_attachment" "eks_cluster_service_attach" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"

  depends_on = [
    aws_iam_role.eks_cluster_role
  ]
}

resource "aws_iam_role_policy_attachment" "eks_cluster_iam_access_attach" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = aws_iam_policy.eks_iam_policy.arn

  depends_on = [
    aws_iam_role.eks_cluster_role,
    aws_iam_policy.eks_iam_policy
  ]
}

resource "aws_iam_role_policy_attachment" "eks_cluster_all_access_attach" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = aws_iam_policy.eks_all_access_policy.arn

  depends_on = [
    aws_iam_role.eks_cluster_role,
    aws_iam_policy.eks_all_access_policy
  ]
}
