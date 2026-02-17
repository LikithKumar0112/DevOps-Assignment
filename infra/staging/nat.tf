resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "pgagi-nat-eip-staging"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "pgagi-nat-staging"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.pgagi_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "pgagi-private-rt-staging"
  }
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

