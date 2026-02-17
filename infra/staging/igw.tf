resource "aws_internet_gateway" "pgagi_igw" {
  vpc_id = aws_vpc.pgagi_vpc.id

  tags = {
    Name = "pgagi-igw-staging"
  }
}

