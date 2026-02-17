resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.pgagi_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "pgagi-public-subnet-staging"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.pgagi_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "pgagi-private-subnet-staging"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.pgagi_vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1b"

  tags = {
    Name = "pgagi-public-subnet-2-staging"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.pgagi_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "pgagi-private-subnet-2-staging"
  }
}

