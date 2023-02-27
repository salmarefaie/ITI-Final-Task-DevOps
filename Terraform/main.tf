module "network" {
  source           = "./network"
  vpc_cidr         = "10.0.0.0/16"
  vpc_name         = "my vpc"
  internet_gateway = "internet gateway"
  nat_gateway      = "nat"
  public_cidr      = "0.0.0.0/0"
  security_group   = "security group"

  public-subnet = {
    "public_subnet1" = { cidr = "10.0.0.0/24", zone = "us-east-1b" },
    "public_subnet2" = { cidr = "10.0.2.0/24", zone = "us-east-1c" }
  }

  private-subnet = {
    "private_subnet1" = { cidr = "10.0.1.0/24", zone = "us-east-1b" },
    "private_subnet2" = { cidr = "10.0.3.0/24", zone = "us-east-1c" }
  }

  route_table = {
    "public_name"  = "public route table",
    "private_name" = "private route table"
  }

  route = {
    "route1" = { routingTableID = module.network.public_route_table_id, gatewayID = module.network.gateway_id },
    "route2" = { routingTableID = module.network.private_route_table_id, gatewayID = module.network.nat_id }
  }

  subnet_association = {
    "publicSubnet_association1"  = { subnetID = module.network.public_subnet1_id, routingTableID = module.network.public_route_table_id },
    "publicSubnet_association2"  = { subnetID = module.network.public_subnet2_id, routingTableID = module.network.public_route_table_id },
    "privateSubnet_association1" = { subnetID = module.network.private_subnet1_id, routingTableID = module.network.private_route_table_id },
    "privateSubnet_association2" = { subnetID = module.network.private_subnet2_id, routingTableID = module.network.private_route_table_id }
  }
}

module "iam" {
  source            = "./iam"
  cluster-role-name = "cluster-role"
  node-role-name    = "node-role"
}

module "EKS" {
  source           = "./EKS"
  cluster-name     = "cluster"
  cluster-role-arn = module.iam.cluster-role-arn
  policy-cluster   = module.iam.cluster-policy

  public-subnet1-id  = module.network.public_subnet1_id
  public-subnet2-id  = module.network.public_subnet2_id
  private-subnet1-id = module.network.private_subnet1_id
  private-subnet2-id = module.network.private_subnet2_id

  worker-nodes-name         = "worker-nodes"
  node-role-arn             = module.iam.node-role-arn
  policy-node               = module.iam.node-policy
  policy-CNI                = module.iam.cni-policy
  policy-container-readonly = module.iam.container-policy

  endpoint      = true
  instance_type = "t3.medium"
  key           = "project"
  capacity_type = "ON_DEMAND"
}

module "ec2" {
  source          = "./ec2"
  vpcID           = module.network.vpc_id
  ec2_type        = "t2.micro"
  ami             = "ami-0557a15b87f6559cf"
  subnet_id       = module.network.public_subnet2_id
  sg_id           = module.network.sg_id
  key_name        = "project"
  ec2_name        = "basion host"
  enable_publicIP = true
}

