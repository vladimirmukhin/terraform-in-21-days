resource "aws_eks_cluster" "this" {
  name     = var.env_code
  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    subnet_ids = data.terraform_remote_state.level1.outputs.private_subnets
  }
}

resource "aws_eks_node_group" "this" {
  cluster_name    = var.env_code
  node_group_name = var.env_code
  node_role_arn   = aws_iam_role.nodes.arn
  subnet_ids      = data.terraform_remote_state.level1.outputs.private_subnets
  ami_type        = "AL2_x86_64"
  capacity_type   = "ON_DEMAND"
  disk_size       = 30
  instance_types  = ["t3.medium"]

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 3
  }

  depends_on = [ 
    aws_eks_cluster.this
  ]
}