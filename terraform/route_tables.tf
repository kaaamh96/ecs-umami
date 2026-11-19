
#public route table 

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

#public route table associations



resource "aws_route_table_association" "umami_public_1a_assoc" {
  subnet_id      = aws_subnet.umami_public_1a.id
  route_table_id = aws_route_table.umami_public_rt.id

}


resource "aws_route_table_association" "umami_public_1b_assoc" {
  subnet_id      = aws_subnet.umami_public_1b.id
  route_table_id = aws_route_table.umami_public_rt.id
}




#private route table x2 as we want two natgateways one in each private AZ



resource "aws_route_table" "umami_private_rt_1a" {
  vpc_id = aws_vpc.umami_vpc.id

  tags = {
    Name = "umami-private-rt-1a"

  }
}

resource "aws_route_table" "umami_private_rt_1b" {
  vpc_id = aws_vpc.umami_vpc.id

  tags = {
    Name = "umami-private-rt-1b"

  }
}

#private associations

resource "aws_route_table_association" "umami_private_1a_assoc" {

  subnet_id      = aws_subnet.umami_private_1a.id
  route_table_id = aws_route_table.umami_private_rt_1a.id


}

resource "aws_route_table_association" "umami_private_1b_assoc" {

  subnet_id      = aws_subnet.umami_private_1b.id
  route_table_id = aws_route_table.umami_private_rt_1b.id

}