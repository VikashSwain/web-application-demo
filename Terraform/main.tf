resource "aws_eks_cluster" "cluster" {
  name     = "cluster"
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.pub_sub_1.id, aws_subnet.pub_sub_2.id]
  }
  version = "1.29"
  tags = {
    Name = "my-eks-cluster"
  }
}


# node-group

resource "aws_eks_node_group" "node_grp" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "node_grp"
  node_role_arn   = aws_iam_role.role_11.arn
  subnet_ids      = [aws_subnet.pub_sub_1.id, aws_subnet.pub_sub_2.id]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  instance_types = ["t3.medium"]

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly
  ]

  tags = {
    Name = "node_grp"
  }
  
}
