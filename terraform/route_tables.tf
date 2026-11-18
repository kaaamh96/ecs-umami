
resource "aws_route_table" "umami_public_rt" {
  vpc_id = aws_vpc.umami_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.umami_igw.id
  }

  tags = {
    Name = "umami-public-rt"
  }

}

#route table associations