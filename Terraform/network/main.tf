# vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# internet gateway
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.internet_gateway
  }
}

# public subnets
resource "aws_subnet" "public-subnet" {
  vpc_id            = aws_vpc.vpc.id
  for_each          = var.public-subnet
  cidr_block        = each.value.cidr
  availability_zone = each.value.zone

  tags = {
    Name = each.key
  }
}

# private subnets
resource "aws_subnet" "private-subnet" {
  vpc_id            = aws_vpc.vpc.id
  for_each          = var.private-subnet
  cidr_block        = each.value.cidr
  availability_zone = each.value.zone

  tags = {
    Name = each.key
  }
}

#elastic ip
resource "aws_eip" "eip-nat" {
  vpc = true
}

# nat gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip-nat.id
  subnet_id     = aws_subnet.public-subnet["public_subnet1"].id

  tags = {
    Name = var.nat_gateway
  }
}

# route tables
resource "aws_route_table" "route_table" {
  vpc_id   = aws_vpc.vpc.id
  for_each = var.route_table

  tags = {
    Name = each.value
  }
}

# route
resource "aws_route" "route" {
  for_each               = var.route
  route_table_id         = each.value.routingTableID
  destination_cidr_block = var.public_cidr
  gateway_id             = each.value.gatewayID
}

# subnet association
resource "aws_route_table_association" "subnet_association" {
  for_each       = var.subnet_association
  subnet_id      = each.value.subnetID
  route_table_id = each.value.routingTableID
}


# security group 
resource "aws_security_group" "sg" {
  name        = var.security_group
  description = var.security_group
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.public_cidr]
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.public_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.public_cidr]
  }

  tags = {
    Name = var.security_group
  }
}