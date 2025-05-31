data "aws_availability_zones" "main" {
  filter {
    name   = "region-name"
    values = ["us-east-1"]
  }
}

resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "eks_vpc"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.0.0/20"
  availability_zone = data.aws_availability_zones.main.names[0]

  tags = {
    Name                                        = "private_subnet_1",
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.16.0/20"
  availability_zone = data.aws_availability_zones.main.names[1]


  tags = {
    Name                                        = "private_subnet_2",
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.32.0/20"
  availability_zone = data.aws_availability_zones.main.names[1]


  tags = {
    Name                                        = "private_subnet_3",
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"

  }
}


resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.48.0/20"
  availability_zone = data.aws_availability_zones.main.names[0]

  tags = {
    Name                                        = "public_subnet_1",
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.64.0/20"
  availability_zone = data.aws_availability_zones.main.names[1]

  tags = {
    Name                                        = "public_subnet_2",
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.80.0/20"
  availability_zone = data.aws_availability_zones.main.names[1]

  tags = {
    Name                                        = "public_subnet_3",
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_subnet_3.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.nat_route_table.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.nat_route_table.id
}

resource "aws_route_table_association" "private_n" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.nat_route_table.id
}
