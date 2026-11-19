# elastic ip's

resource "aws_eip" "umami_nat_eip_1a" {

  domain = "vpc"

  tags = {
    Name = "umami-nat-eip-1a"
  }
}

resource "aws_eip" "umami_nat_eip_1b" {
  domain = "vpc"

  tags = {
    Name = "umami-nat-eip-1b"

  }
}


#Nat gateways - will use resource address of eip

resource "aws_nat_gateway" "umami_nat_1a" {
  allocation_id = aws_eip.umami_nat_eip_1a.id
  subnet_id     = aws_subnet.umami_public_1a.id
  tags = {
    Name = "umami-nat-1a"
  }
}

resource "aws_nat_gateway" "umami_nat_1b" {
  allocation_id = aws_eip.umami_nat_eip_1b.id
  subnet_id     = aws_subnet.umami_public_1b.id
  tags = {
    Name = "umami-nat-1b"
  }
}