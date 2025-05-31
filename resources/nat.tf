resource "aws_eip" "nat_eip" {
  vpc = true

  tags = {
    Name = "gitops-nat-eip"
  }
}

resource "aws_nat_gateway" "gitops-nat" {
  subnet_id     = aws_subnet.public_subnet_1.id
  allocation_id = aws_eip.nat_eip.id

  tags = {
    Name = "${var.cluster_name}-nat"
  }

  depends_on = [
    aws_internet_gateway.igw
  ]
}

resource "aws_route_table" "nat_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.gitops-nat.id
  }

  tags = {
    Name = "${var.cluster_name}-nat-route-table"
  }
}
