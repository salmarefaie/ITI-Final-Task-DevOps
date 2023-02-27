output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet1_id" {
  value = aws_subnet.public-subnet["public_subnet1"].id
}

output "public_subnet2_id" {
  value = aws_subnet.public-subnet["public_subnet2"].id
}

output "private_subnet1_id" {
  value = aws_subnet.private-subnet["private_subnet1"].id
}

output "private_subnet2_id" {
  value = aws_subnet.private-subnet["private_subnet2"].id
}

output "gateway_id" {
  value = aws_internet_gateway.gateway.id
}

output "nat_id" {
  value = aws_nat_gateway.nat.id
}

output "public_route_table_id" {
  value = aws_route_table.route_table["public_name"].id
}

output "private_route_table_id" {
  value = aws_route_table.route_table["private_name"].id
}

output "sg_id" {
  value = aws_security_group.sg.id
}