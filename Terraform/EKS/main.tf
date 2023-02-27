# cluster eks
resource "aws_eks_cluster" "cluster" {
  name     = var.cluster-name
  role_arn = var.cluster-role-arn

  vpc_config {
    subnet_ids = [
      var.public-subnet1-id,
      var.public-subnet2-id,
      var.private-subnet1-id,
      var.private-subnet2-id
    ]
    endpoint_private_access = var.endpoint
    endpoint_public_access  = var.endpoint
  }

  depends_on = [
    var.policy-cluster
  ]
}

# worker nodes
resource "aws_eks_node_group" "worker-nodes" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = var.worker-nodes-name
  node_role_arn   = var.node-role-arn

  subnet_ids = [
    var.private-subnet1-id,
    var.private-subnet2-id
  ]

  capacity_type  = var.capacity_type
  instance_types = [var.instance_type]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    var.policy-node,
    var.policy-CNI,
    var.policy-container-readonly
  ]

  remote_access {
    ec2_ssh_key = var.key
  }
}